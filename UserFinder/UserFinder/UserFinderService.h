//
//  UserFinderService.h
//  UserFinder
//
//  Created by Dom Chapman on 10/23/14.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserFinderLocationsDataSource.h"

@interface UserFinderService : NSObject

-(instancetype)initWithUserFinderLocationsDataSource:(id <UserFinderLocationsDataSource>)userFinderLocationsDataSource;


-(void)refreshWithCompletion:(void (^)(BOOL success))completion;


@property (nonatomic, assign, readonly) BOOL isRefreshing;

@property (nonatomic, strong, readonly) NSArray *userLocations;

@end
