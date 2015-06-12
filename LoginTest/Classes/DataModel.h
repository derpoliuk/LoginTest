//
//  DataModel.h
//  LoginTest
//
//  Created by Stanislav Derpoliuk on 5/11/15.
//  Copyright (c) 2015 Stanislav Derpoliuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property (nonatomic, readonly) BOOL userLoggedIn;
/// Just some data for FeedViewController
@property (nonatomic, readonly) NSArray *userPosts;

- (instancetype)initWithCallbak:(void (^)())callback NS_DESIGNATED_INITIALIZER;
- (void)login:(void (^)(BOOL success, NSError *error))completion;
- (void)logout;

@end
