//
//  MapViewController.h
//  UserFinder
//
//  Created by Dom Chapman on 10/23/14.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

#import "UFViewController.h"

@interface MapViewController : UFViewController

-(void)zoomToUserLocationWithIndex:(NSUInteger)userLocationIndex animated:(BOOL)animated;

@end
