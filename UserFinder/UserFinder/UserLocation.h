//
//  UserLocation.h
//  UserFinder
//
//  Created by Dom Chapman on 10/23/14.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserLocation : NSObject

@property (nonatomic, strong, readwrite) NSString *address;

@property (nonatomic, strong, readwrite) NSDate *date;

@property (nonatomic, assign, readwrite) double latitude;

@property (nonatomic, assign, readwrite) double longitude;

-(NSString *)dateAsString;

@end
