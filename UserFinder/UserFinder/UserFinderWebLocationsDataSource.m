//
//  UserFinderWebLocationsDataSource.m
//  UserFinder
//
//  Created by Dom Chapman on 10/23/14.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

#import "UserFinderWebLocationsDataSource.h"


static NSString * const kLocationsURL = @"http://viralplatipuss.com/locations.xml"; //@"http://dev1.knowadozen.com/site_media/locations.xml";


@implementation UserFinderWebLocationsDataSource

-(NSData *)getLocationDataWithError:(NSError *__autoreleasing *)error
{
	NSURL *url = [NSURL URLWithString:kLocationsURL];
	
	NSData *data = [NSData dataWithContentsOfURL:url options:0 error:error];
	
	return data;
}

@end
