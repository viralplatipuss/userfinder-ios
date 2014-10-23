//
//  UserLocation.m
//  UserFinder
//
//  Created by Dom Chapman on 10/23/14.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

#import "UserLocation.h"

@implementation UserLocation

-(NSString *)description
{
	return [NSString stringWithFormat:@"UserLocation:\raddress: %@\rlat: %f lon: %f\rdate: %@",self.address,self.latitude,self.longitude,self.date];
}

-(NSString *)dateAsString
{
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	
	return [dateFormatter stringFromDate:self.date];
}

@end
