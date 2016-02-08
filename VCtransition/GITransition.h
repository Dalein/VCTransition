//
//  GITransition.h
//  VCtransition
//
//  Created by Ivan Gnatyuk on 01.02.16.
//  Copyright (c) 2016 daleijn. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat kModalViewYOffset = 44.0;
static const CGFloat kModalViewNavBarHeight = 50.0;
static const CGFloat kNonModalViewMinScale = 0.9;
static const CGFloat kNonModalViewMinAlpha = 0.6;
extern int const GITransitionContainerViewTag;

@interface GITransition : NSObject <UIViewControllerAnimatedTransitioning,
                                                                UIViewControllerTransitioningDelegate,
                                                                UIGestureRecognizerDelegate>

@property (nonatomic, readwrite) id <UIViewControllerContextTransitioning> transitionContext;

@property (nonatomic) BOOL cancelUp;
@property (nonatomic) BOOL closeVCNow;

- (void)addGestureRecognizersToView:(UIView *)viewNavBar withSelfView:(UIView *)selfView;

@end
