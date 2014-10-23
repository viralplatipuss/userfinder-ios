//
//  UserFinderSampleLocationsDataSource.m
//  UserFinder
//
//  Created by Dom Chapman on 10/23/14.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

#import "UserFinderSampleLocationsDataSource.h"


static NSString * const kSampleLocationsFileName = @"sample_locations";


@implementation UserFinderSampleLocationsDataSource

-(NSData *)getLocationDataWithError:(NSError *__autoreleasing *)error
{
	NSString *resolvedPath = [[NSBundle mainBundle] pathForResource:kSampleLocationsFileName ofType:@"xml"];
	
	NSData *data = [NSData dataWithContentsOfFile:resolvedPath options:0 error:error];
	
	return data;
}

@end
