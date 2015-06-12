//
//  AppDelegate.m
//  LoginTest
//
//  Created by Stanislav Derpoliuk on 6/12/15.
//  Copyright (c) 2015 Stanislav Derpoliuk. All rights reserved.
//

#import "AppDelegate.h"
#import "DataModel.h"
#import "LoginViewController.h"
#import "FeedViewController.h"
#import "ProgressHUDViewController.h"
#import "ModalDismissAnimator.h"
#import "ModalPresentAnimator.h"

@interface AppDelegate () <UINavigationControllerDelegate>

@property (nonatomic) DataModel *dataModel;
/// (UINavigationController *)self.window.rootViewController is too long
@property (nonatomic) UINavigationController *rootNavigationController;
@property (nonatomic) BOOL loginIsShown;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.rootNavigationController = (UINavigationController *)self.window.rootViewController;
    self.rootNavigationController.delegate = self;
    __block DataModel *dataModel = [[DataModel alloc] initWithCallbak:^{
        if (!dataModel.userLoggedIn) {
            [self showLoginWithDataModel:dataModel animated:NO];
        } else {
            [self showFeedWithDataModel:dataModel];
        }
        [dataModel addObserver:self
                    forKeyPath:@"userLoggedIn"
                       options:NSKeyValueObservingOptionNew
                       context:NULL];
    }];
    self.dataModel = dataModel;
    return YES;
}

#pragma mark - UI

- (void)showLoginWithDataModel:(DataModel *)dataModel animated:(BOOL)animated
{
    self.loginIsShown = YES;
    UIStoryboard *storyboard = self.rootNavigationController.storyboard;
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    loginViewController.dataModel = dataModel;
    loginViewController.successLoginBlock = ^(){
        [self showFeedWithDataModel:dataModel];
    };
    [self.rootNavigationController setViewControllers:@[loginViewController] animated:animated];
}

- (void)showFeedWithDataModel:(DataModel *)dataModel
{
    self.loginIsShown = NO;
    UIStoryboard *storyboard = self.rootNavigationController.storyboard;
    FeedViewController *feedViewController = [storyboard instantiateViewControllerWithIdentifier:@"FeedViewController"];
    feedViewController.dataModel = dataModel;
    [self.rootNavigationController setViewControllers:@[feedViewController] animated:YES];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if (object == self.dataModel && [keyPath isEqualToString:@"userLoggedIn"]) {
        BOOL userLoggedIn = [change[NSKeyValueChangeNewKey] boolValue];
        if (!userLoggedIn) {
            [self showLoginWithDataModel:self.dataModel animated:YES];
        }
    }
}

#pragma mark - UINavigationControllerDelegate

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    BOOL shouldLookLikeModalDismiss = [fromVC isKindOfClass:[LoginViewController class]] ||
    [fromVC isKindOfClass:[ProgressHUDViewController class]];
    BOOL shouldLookLikeModalPresent = [toVC isKindOfClass:[LoginViewController class]];
    
    if (operation == UINavigationControllerOperationPush && shouldLookLikeModalDismiss) {
        return [ModalDismissAnimator new];
    } else if (operation == UINavigationControllerOperationPush && shouldLookLikeModalPresent) {
        return [ModalPresentAnimator new];
    } else {
        return nil;
    }
}

@end
