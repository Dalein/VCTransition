//
//  PresentTransition.h
//  learnTrasition2
//
//  Created by Ivan Gnatyuk on 03.08.15.
//  Copyright (c) 2015 daleijn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomModalTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic) BOOL reverse;

@end
