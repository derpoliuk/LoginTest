//
//  FeedViewController.m
//  LoginTest
//
//  Created by Stanislav Derpoliuk on 6/12/15.
//  Copyright (c) 2015 Stanislav Derpoliuk. All rights reserved.
//

#import "FeedViewController.h"
#import "DataModel.h"

NSString *const FeedCellReuseIdentifier = @"FeedCell";

@implementation FeedViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataModel.userPosts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FeedCellReuseIdentifier forIndexPath:indexPath];
    NSString *postText = self.dataModel.userPosts[indexPath.row];
    cell.detailTextLabel.text = postText;
    return cell;
}

- (IBAction)logoutBarButtonPressed:(UIBarButtonItem *)sender
{
    [self.dataModel logout];
}

@end
