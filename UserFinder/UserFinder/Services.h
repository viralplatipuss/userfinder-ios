//
//  Services.h
//  UserFinder
//
//  Created by Dom Chapman on 10/23/14.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserFinderService.h"
#import "PreferencesService.h"

@interface Services : NSObject

@property (nonatomic, strong, readonly) UserFinderService *userFinderService;

@property (nonatomic, strong, readonly) PreferencesService *preferencesService;

@end
