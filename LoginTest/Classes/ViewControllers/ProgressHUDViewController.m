//
//  ProgressHUDViewController.m
//  LoginTest
//
//  Created by Stanislav Derpoliuk on 6/7/15.
//  Copyright (c) 2015 Stanislav Derpoliuk. All rights reserved.
//

#import "ProgressHUDViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation ProgressHUDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [SVProgressHUD show];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

@end
