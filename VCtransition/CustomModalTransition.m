//
//  PresentTransition.m
//  learnTrasition2
//
//  Created by Ivan Gnatyuk on 03.08.15.
//  Copyright (c) 2015 daleijn. All rights reserved.
//

#import "CustomModalTransition.h"

@implementation CustomModalTransition {
    BOOL reversed;
}

///*
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalFrameVC = [transitionContext finalFrameForViewController:toVC];
    CGRect bound = [[UIScreen mainScreen] bounds];
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    CGAffineTransform transformTo = CGAffineTransformIdentity;
    CGAffineTransform transformFrom = CGAffineTransformIdentity;
    if (!reversed) {
        toVC.view.frame = CGRectOffset(finalFrameVC, 0, bound.size.height);
        transformTo = CGAffineTransformMakeTranslation(0, -bound.size.height + 44.0);

        //Add to the container view
        [containerView addSubview:toVC.view];
    }
    else {
        transformFrom = CGAffineTransformMakeTranslation(0, bound.size.height);
    }
    
    
    [UIView animateWithDuration:duration animations:^ {
        toVC.view.transform = transformTo;
        fromVC.view.transform = transformFrom;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        reversed = !reversed;
    }];
}
//*/


/*
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromtVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    CGRect finalFrameVC = [transitionContext finalFrameForViewController:toVC];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
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
*/

- (NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4;
}

@end
