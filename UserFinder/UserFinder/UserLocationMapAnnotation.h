//
//  UserLocationMapAnnotation.h
//  UserFinder
//
//  Created by Dom Chapman on 10/23/14.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "UserLocation.h"

@interface UserLocationMapAnnotation : NSObject <MKAnnotation>

-(instancetype)initWithUserLocation:(UserLocation *)userLocation;

@end
