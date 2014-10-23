//
//  UserLocationsXMLParser.h
//  UserFinder
//
//  Created by Dom Chapman on 10/23/14.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserLocationsXMLParser : NSObject

//Synchronous - Don't call on UI thread
-(NSArray *)userLocationsFromXMLData:(NSData *)xmlData;

@end
