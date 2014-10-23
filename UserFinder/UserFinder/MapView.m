//
//  MapView.m
//  UserFinder
//
//  Created by Dom Chapman on 10/23/14.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

#import "MapView.h"

@interface MapView()

@end

@implementation MapView

@synthesize map = _map;

-(void)setupView
{
	[self addSubview:self.map];
}

-(MKMapView *)map
{
	if (!_map) {
		_map = [[MKMapView alloc] init];
	}
	
	return _map;
}

-(void)setupConstraints
{
	[self addConstraints:[ALView constraintsToFillView:self withView:self.map]];
}

@end
