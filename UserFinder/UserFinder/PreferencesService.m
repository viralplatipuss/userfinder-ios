//
//  PreferencesService.m
//  UserFinder
//
//  Created by Dom Chapman on 10/23/14.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

#import "PreferencesService.h"

static NSString * const kStartOnMapViewUserDefaultsKey = @"startOnMapView";

@implementation PreferencesService

-(void)setStartOnMapView:(BOOL)startOnMapView
{
	[[NSUserDefaults standardUserDefaults] setBool:startOnMapView forKey:kStartOnMapViewUserDefaultsKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL)startOnMapView
{
	return [[NSUserDefaults standardUserDefaults] boolForKey:kStartOnMapViewUserDefaultsKey];
}

@end
