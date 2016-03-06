//
//  UIView+ToucheRespond.h
//  VCtransition
//
//  Created by Gnatyuk Ivan on 02.02.16.

#import <UIKit/UIKit.h>
#import "GITransition.h"

@interface UIView (ToucheRespond)

- (UIView *)GI_hitTest:(CGPoint)point withEvent:(UIEvent *)event;

@end
