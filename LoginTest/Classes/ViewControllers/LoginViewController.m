//
//  LoginViewController.m
//  LoginTest
//
//  Created by Stanislav Derpoliuk on 5/12/15.
//  Copyright (c) 2015 Stanislav Derpoliuk. All rights reserved.
//

#import "LoginViewController.h"
#import "DataModel.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation LoginViewController

@synthesize dataModel;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (IBAction)loginButtonPressed:(UIButton *)sender
{
    [self showProgress];
    [self.dataModel login:^(BOOL success, NSError *error) {
        [self hideProgress];
        if (success) {
            if (self.successLoginBlock) {
                self.successLoginBlock();
            }
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Login Error", @"Login Error")
                                                                                     message:error.localizedDescription
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK")
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:nil];
            [alertController addAction:defaultAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
}

#pragma mark - Progress

- (void)showProgress
{
    self.view.userInteractionEnabled = NO;
    [SVProgressHUD show];
}

- (void)hideProgress
{
    [SVProgressHUD dismiss];
    self.view.userInteractionEnabled = YES;
}

@end
