//
//  GITransition.h
//  VCtransition
//
//  Created by Ivan Gnatyuk on 01.02.16.
//  Copyright (c) 2016 daleijn. All rights reserved.
//

#import <UIKit/UIKit.h>

const CGFloat kModalViewYOffset = 44.0;
const CGFloat kModalViewNavBarHeight = 50.0;
const CGFloat kNonModalViewMinScale = 0.9;
const CGFloat kNonModalViewMinAlpha = 0.6;

@interface GITransition : UIPercentDrivenInteractiveTransition <UIViewControllerAnimatedTransitioning,
                                                                UIViewControllerTransitioningDelegate,
                                                                UIGestureRecognizerDelegate>

@property (nonatomic, readwrite) id <UIViewControllerContextTransitioning> transitionContext;

@property (nonatomic) BOOL cancelUp;
@property (nonatomic) BOOL closeVCNow;

- (void)addGestureRecognizersToView:(UIView *)viewNavBar withSelfView:(UIView *)selfView;

@end
