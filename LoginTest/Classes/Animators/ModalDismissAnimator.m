//
//  LoginToFeedAnimator.m
//  LoginTest
//
//  Created by Stanislav Derpoliuk on 6/6/15.
//  Copyright (c) 2015 Stanislav Derpoliuk. All rights reserved.
//

#import "ModalDismissAnimator.h"

@implementation ModalDismissAnimator

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [[transitionContext containerView] insertSubview:toViewController.view belowSubview:fromViewController.view];
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^
     {
         CGRect frame = fromViewController.view.frame;
         frame.origin.y = CGRectGetHeight(frame);
         fromViewController.view.frame = frame;
     } completion:^(BOOL finished)
     {
         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
     }];
}

@end
