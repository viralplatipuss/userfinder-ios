//
//  Services.m
//  UserFinder
//
//  Created by Dom Chapman on 10/23/14.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

#import "Services.h"

@implementation Services

-(instancetype)initWithUserFinderService:(UserFinderService *)userFinderService preferencesService:(PreferencesService *)preferencesService
{
	if (self = [super init]) {
		_userFinderService = userFinderService;
		_preferencesService = preferencesService;
	}
	
	return self;
}

@end
