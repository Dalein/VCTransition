//
//  GITransition.m
//  VCtransition
//
//  Created by Ivan Gnatyuk on 01.02.16.
//  Copyright (c) 2016 daleijn. All rights reserved.
//

#import "GITransition.h"
#import "UIView+ToucheRespond.h"
#import <objc/runtime.h>

@implementation GITransition {
    
    CGFloat viewH;
    UIView *_selfView;
    BOOL isModalVCOnBottom;
    BOOL reversed;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                   sourceController:(UIViewController *)source {
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self;
}



#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 1.0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    self.transitionContext = transitionContext;
    isModalVCOnBottom = NO;
    
    UIViewController *fromtVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
   
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Swizzling
        Method originalMethod = class_getInstanceMethod([containerView class], @selector(hitTest:withEvent:));
        Method swappedMethod = class_getInstanceMethod([containerView class], @selector(GI_hitTest:withEvent:));
        method_exchangeImplementations(originalMethod, swappedMethod);
    });

    
    CGRect finalFrameVC = [transitionContext finalFrameForViewController:toVC];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    viewH = CGRectGetHeight(fromtVC.view.frame);
    
    // Define wich viewController we will move, and wich just scale
    UIViewController *modalVC = reversed ? fromtVC : toVC;
    UIViewController *nonModalVC = reversed ? toVC : fromtVC;
    
    CGRect modalFinalFrame = reversed ? CGRectOffset(finalFrameVC, 0, viewH) : finalFrameVC;
    float scaleFactor = 0.0;
    float alphaVal = 0.0;
    
    if (reversed) {
        scaleFactor = 1.0;
        alphaVal = 1.0;
    }
    else {
        // Set offset from the top for modalView
        modalFinalFrame.origin.y += kModalViewYOffset;
        // If we'll present now modalVC - hide it under the screen
        modalVC.view.frame = CGRectOffset(finalFrameVC, 0, viewH);
        
        scaleFactor = kNonModalViewMinScale;
        alphaVal = kNonModalViewMinAlpha;
        
        [containerView addSubview:toVC.view]; 
    }

    
    [UIView animateWithDuration:duration delay:0.0
         usingSpringWithDamping:100
          initialSpringVelocity:10
                        options:UIViewAnimationOptionAllowUserInteraction animations:^{
                            
                            nonModalVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, scaleFactor, scaleFactor);
                            nonModalVC.view.alpha = alphaVal;
                            modalVC.view.frame = modalFinalFrame;
                            
                            if (self.closeVCNow) {
                                toVC.view.transform = CGAffineTransformIdentity; // Fix rotation issue http://stackoverflow.com/questions/31969524/ios-custom-transitions-and-rotation/35182783#35182783
                                toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
                                self.closeVCNow = NO;
                            }
                            
                        } completion:^(BOOL finished) {
                            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                             reversed = !reversed;
    }];
    
}


#pragma GestureRecognizer delegate

- (void)addGestureRecognizersToView:(UIView *)viewNavBar withSelfView:(UIView *)selfView{
    _selfView = selfView;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [viewNavBar addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [viewNavBar addGestureRecognizer:tapRec];
}

- (void)tap:(UITapGestureRecognizer *)recognizer {
    if (isModalVCOnBottom) {
        [self moveModalViewUp:YES andDuration:0.4];
    }
}

- (void)pan:(UIPanGestureRecognizer *)recognizer{

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [recognizer setTranslation:CGPointZero inView:_selfView.superview];
    }
    
    // This don't allow drag modalVC beyond the screen
    // and don't allow drag it up when modalVC placed on the bottom
    if ([recognizer translationInView:_selfView].y < 0.1 || isModalVCOnBottom) {
        return;
    }
    
    CGFloat percentage = [recognizer translationInView:_selfView].y / CGRectGetHeight(_selfView.bounds);
    
    float scaleFactor = kNonModalViewMinScale + (1 - kNonModalViewMinScale) * percentage;
    float alphaVal = kNonModalViewMinAlpha + (1 - kNonModalViewMinAlpha) * percentage;
   
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.transform = CGAffineTransformScale(CGAffineTransformIdentity, scaleFactor, scaleFactor);
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.alpha = alphaVal;
    
    CGRect modalVCFrame = [_transitionContext viewForKey:UITransitionContextToViewKey].frame;
    modalVCFrame.origin.y = percentage * CGRectGetHeight(_selfView.frame) + kModalViewYOffset;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.frame = modalVCFrame;
    
    if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        
        CGFloat velocityY = [recognizer velocityInView:recognizer.view.superview].y;
        BOOL cancelUp = (velocityY < 0) || (velocityY == 0 && recognizer.view.frame.origin.y < CGRectGetHeight(_selfView.bounds)/2);
        
        CGFloat points = cancelUp ? recognizer.view.frame.origin.y : CGRectGetHeight(_selfView.bounds) - recognizer.view.frame.origin.y;
        NSTimeInterval duration = points / velocityY;
        
        if (duration < 0.2) {
            duration = 0.2;
        }
        else if(duration > 0.4){
            duration = 0.4;
        }
        
        // Move view
        [self moveModalViewUp:cancelUp andDuration:duration];
    }
}

- (void)moveModalViewUp:(BOOL)cancelUp andDuration:(NSTimeInterval)duration {
    
    CGRect modalVCFrame = [_transitionContext viewForKey:UITransitionContextToViewKey].frame;
    modalVCFrame.origin.y = cancelUp ? kModalViewYOffset : viewH - kModalViewNavBarHeight;
    CGAffineTransform transformVal = cancelUp ?
                                                CGAffineTransformMakeScale(kNonModalViewMinScale, kNonModalViewMinScale)
                                              :
                                                CGAffineTransformIdentity;
    CGFloat alphaVal = cancelUp ? kNonModalViewMinAlpha : 1.0;
    
    [UIView animateWithDuration:duration animations:^{
        [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.frame = modalVCFrame;
        [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.transform = transformVal;
        [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.alpha = alphaVal;
    } completion:^(BOOL finished) {
        isModalVCOnBottom = !cancelUp;
    }];
}

@end