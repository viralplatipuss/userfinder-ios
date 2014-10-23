//
//  UserFinderLocationsDataSource.h
//  UserFinder
//
//  Created by Dom Chapman on 10/23/14.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

@protocol UserFinderLocationsDataSource <NSObject>

//Synchronous - Don't call on UI thread
-(NSData *)getLocationDataWithError:(NSError *__autoreleasing *)error;

@end