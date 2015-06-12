//
//  BaseAnimator.m
//  LoginTest
//
//  Created by Stanislav Derpoliuk on 6/7/15.
//  Copyright (c) 2015 Stanislav Derpoliuk. All rights reserved.
//

#import "BaseAnimator.h"

const NSTimeInterval BaseAnimatorTransitionDuration = 0.3;

@implementation BaseAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return BaseAnimatorTransitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [NSObject doesNotRecognizeSelector:_cmd];
}

@end
