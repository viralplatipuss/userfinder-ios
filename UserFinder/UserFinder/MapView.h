//
//  MapView.h
//  UserFinder
//
//  Created by Dom Chapman on 10/23/14.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

#import "ALView.h"
#import <MapKit/MapKit.h>

@interface MapView : ALView

@property (nonatomic, strong, readonly) MKMapView *map;

@end
