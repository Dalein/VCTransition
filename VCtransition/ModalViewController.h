//
//  MPModalViewController.h
//  VCtransition
//
//  Created by Ivan Gnatyuk on 01.02.16.
//  Copyright (c) 2016 daleijn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GITransition.h"

#pragma mark detailView Delegate
@protocol ModalVCDelegate <NSObject>

@required
- (void)closeModal;
@end

@interface ModalViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewNavBar;

@property (strong, nonatomic) GITransition *transitionManager;

@property (nonatomic, weak) id<ModalVCDelegate> delegate;

@end
