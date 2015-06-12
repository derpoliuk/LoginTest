//
//  ModalPresentAnimator.m
//  LoginTest
//
//  Created by Stanislav Derpoliuk on 6/7/15.
//  Copyright (c) 2015 Stanislav Derpoliuk. All rights reserved.
//

#import "ModalPresentAnimator.h"

@implementation ModalPresentAnimator

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toViewController.view];
    CGRect frame = toViewController.view.frame;
    CGRect toFrame = frame;
    frame.origin.y = CGRectGetHeight(frame);
    toViewController.view.frame = frame;
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^
     {
         toViewController.view.frame = toFrame;
     } completion:^(BOOL finished)
     {
         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
     }];
}

@end
