//
//  LoginViewController.h
//  LoginTest
//
//  Created by Stanislav Derpoliuk on 5/12/15.
//  Copyright (c) 2015 Stanislav Derpoliuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataModel;

@interface LoginViewController : UIViewController

@property (nonatomic) DataModel *dataModel;

@property (nonatomic, copy) void (^successLoginBlock)();

@end
