//
//  MPModalViewController.m
//  VCtransition
//
//  Created by Ivan Gnatyuk on 01.02.16.
//  Copyright (c) 2016 daleijn. All rights reserved.
//

#import "ModalViewController.h"
#import "GITransition.h"
#import "CustomModalTransition.h"

@interface ModalViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation ModalViewController {
    CustomModalTransition *transitionToNextModal;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.transitioningDelegate = self.transitionManager;
    [self.transitionManager addGestureRecognizersToView:self.viewNavBar withSelfView:self.view];
    
    transitionToNextModal = [[CustomModalTransition alloc] init];
    
    self.viewNavBar.backgroundColor = [UIColor colorWithRed:75/255.0 green:111/255.0 blue:150/255.0 alpha:1.0];
}


- (IBAction)close:(id)sender {
    self.transitionManager.closeVCNow = YES;
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate closeModal];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"presentModal2"]) {
        UINavigationController *navVC = segue.destinationViewController;
        navVC.modalPresentationStyle = UIModalPresentationCustom;
        navVC.transitioningDelegate = self;
    }
}

#pragma For Presen Modally mode (simple transition)
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source {
    return transitionToNextModal;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed  {
    return transitionToNextModal;
}


@end
