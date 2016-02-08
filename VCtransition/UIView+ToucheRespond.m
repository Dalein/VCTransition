//
//  UIView+ToucheRespond.m
//  VCtransition
//
//  Created by Gnatyuk Ivan on 02.02.16.

// http://stackoverflow.com/questions/4961386/event-handling-for-ios-how-hittestwithevent-and-pointinsidewithevent-are-r
// @onmyway133 answer

#import "UIView+ToucheRespond.h"

@implementation UIView (ToucheRespond)

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) {
        return nil;
    }

    if ([self pointInside:point withEvent:event]) {
        for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
            CGPoint convertedPoint = [subview convertPoint:point fromView:self];
            UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];
            if (hitTestView && hitTestView.tag != GITransitionContainerViewTag) {
                return hitTestView;
            }
        }
        return self;
    }
    
    return nil;
}



@end
