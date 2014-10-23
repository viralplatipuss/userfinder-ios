//
//  UFViewController.h
//  UserFinder
//
//  Created by Dom Chapman on 10/23/14.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Services.h"

@interface UFViewController : UIViewController

-(instancetype)initWithServices:(Services *)services;

-(void)servicesDidLoad;

@property (nonatomic, strong, readonly) Services *services;


//Service key paths for KVO
-(NSString *)userLocationsKeyPath;

-(NSString *)isRefreshingKeyPath;

@end