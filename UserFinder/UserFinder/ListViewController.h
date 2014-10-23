//
//  ListViewController.h
//  UserFinder
//
//  Created by Dom Chapman on 10/23/14.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

#import "UFViewController.h"

@class ListViewController;

@protocol ListViewControllerDelegate <NSObject>

@optional

-(void)listViewController:(ListViewController *)listViewController selectedUserLocationIndex:(NSUInteger)userLocationIndex;

@end

@interface ListViewController : UFViewController

@property (nonatomic, weak, readwrite) id <ListViewControllerDelegate> delegate;

@end