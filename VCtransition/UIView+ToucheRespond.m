//
//  UIView+ToucheRespond.m
//  VCtransition
//
//  Created by Gnatyuk Ivan on 02.02.16.


#import "UIView+ToucheRespond.h"

@implementation UIView (ToucheRespond)

- (UIView *)GI_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    [self GI_hitTest:point withEvent:event];
    
    NSLog(@"---GI_hitTest--");
    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) {
        return nil;
    }
    
    if ([self pointInside:point withEvent:event]) {
        for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
            CGPoint convertedPoint = [subview convertPoint:point fromView:self];
            UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];
            if (hitTestView) {
                return hitTestView;
            }
        }
    }
    return nil;
}


@end
