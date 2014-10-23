//
//  UserLocationMapAnnotation.m
//  UserFinder
//
//  Created by Dom Chapman on 10/23/14.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

#import "UserLocationMapAnnotation.h"

@implementation UserLocationMapAnnotation

@synthesize title = _title, subtitle = _subtitle, coordinate = _coordinate;

-(instancetype)initWithUserLocation:(UserLocation *)userLocation
{
	if (self = [super init]) {
		_title = userLocation.address;
		_subtitle = [userLocation dateAsString];
		_coordinate = CLLocationCoordinate2DMake(userLocation.latitude, userLocation.longitude);
	}
	
	return self;
}

@end
