//
//  DataModel.m
//  LoginTest
//
//  Created by Stanislav Derpoliuk on 5/11/15.
//  Copyright (c) 2015 Stanislav Derpoliuk. All rights reserved.
//

#import "DataModel.h"

@interface DataModel ()

@property (nonatomic) BOOL userLoggedIn;

@end

@implementation DataModel

- (instancetype)init
{
    return [self initWithCallbak:nil];
}

- (instancetype)initWithCallbak:(void (^)())callback
{
    self = [super init];
    if (self) {
        // Do long initialization in background
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // Sleep for 2 seconds for testing purposes
            sleep(2);
            // Call callback block on main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                if (callback) {
                    callback();
                }
            });
        });
    }
    return self;
}

- (void)login:(void (^)(BOOL, NSError *))completion
{
    static NSUInteger loginAttemptsCount = 1;
    loginAttemptsCount++;
    
    // Login in background
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Sleep for 1 second for testing purposes
        sleep(1);
        // Login will be successful every second time
        BOOL userLoggedIn = loginAttemptsCount % 2;
        NSError *error;
        
        if (userLoggedIn) {
            self.userLoggedIn = YES;
        } else {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(@"Login failed", @"Login failed")};
            error = [NSError errorWithDomain:@"com.test.app" code:42 userInfo:userInfo];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(userLoggedIn, error);
            }
        });
    });
}

- (void)logout
{
    // Clean up all user data
    self.userLoggedIn = NO;
}

- (NSArray *)userPosts
{
    return @[@"Lorem", @"Ipsum", @"42"];
}

@end