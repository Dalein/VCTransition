//
//  ViewController.m
//  VCtransition
//
//  Created by Ivan Gnatyuk on 01.02.16.
//  Copyright (c) 2016 daleijn. All rights reserved.
//

#import "ViewController.h"
#import "ModalViewController.h"
#import "GITransition.h"

@interface ViewController () <ModalVCDelegate> {
    GITransition *transitionManager;
    
    ModalViewController *controller;
}

@end

@implementation ViewController

- (void)closeModal {
    NSLog(@"closeModal");

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    transitionManager = [[GITransition alloc] init];
    self.transitioningDelegate = transitionManager;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    controller = [storyboard instantiateViewControllerWithIdentifier:@"vcAddNewGoal"];
    controller.transitioningDelegate = transitionManager;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    controller.transitionManager = transitionManager;
    controller.delegate = self;

}


- (IBAction)show:(id)sender {
    [self presentViewController:controller animated:YES completion:nil];
}


- (IBAction)pushMe:(id)sender {
    NSLog(@"pushMe!");
}

@end
