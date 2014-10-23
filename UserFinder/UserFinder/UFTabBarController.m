//
//  UFTabBarController.m
//  UserFinder
//
//  Created by Dom Chapman on 10/23/14.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

#import "UFTabBarController.h"
#import "UFViewController.h"

static NSString * const kUserLocationsKeyPath = @"self.services.userFinderService.userLocations";

static NSString * const kIsRefreshingKeyPath = @"self.services.userFinderService.isRefreshing";

@implementation UFTabBarController

-(instancetype)initWithServices:(Services *)services
{
	if (self = [super init]) {
		_services = services;
	}
	
	[self servicesDidLoad];
	
	return self;
}

-(void)servicesDidLoad
{
	
}

-(NSString *)userLocationsKeyPath
{
	return kUserLocationsKeyPath;
}

-(NSString *)isRefreshingKeyPath
{
	return kIsRefreshingKeyPath;
}

@end