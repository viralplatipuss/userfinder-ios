//
//  MapViewController.m
//  UserFinder
//
//  Created by Dom Chapman on 10/23/14.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

#import "MapViewController.h"
#import "MapView.h"
#import "UserLocation.h"
#import "UserLocationMapAnnotation.h"

@interface MapViewController()

@property (nonatomic, strong, readonly) MapView *mapView;

@property (nonatomic, strong, readwrite) NSArray *annotations;

@end

@implementation MapViewController

@synthesize mapView = _mapView, annotations = _annotations;



#pragma mark - Setup Methods

-(void)loadView
{
	self.view = self.mapView;
}

-(void)servicesDidLoad
{
	[self addObserver:self forKeyPath:[self userLocationsKeyPath] options:NSKeyValueObservingOptionNew context:NULL];
}



#pragma mark - Public Methods

-(void)zoomToUserLocationWithIndex:(NSUInteger)userLocationIndex animated:(BOOL)animated
{
	//Make use of the fact the annotations array matches the service's userLocation array
	UserLocationMapAnnotation *annotation = self.annotations[userLocationIndex];
	
	[self.mapView.map showAnnotations:@[annotation] animated:animated];
}



#pragma mark - KVO

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:[self userLocationsKeyPath]]) {
		
		[self refreshMap];
		
		return;
	}
}



#pragma mark - Map Methods

-(void)refreshMap
{
	[self.mapView.map removeAnnotations:self.annotations];
	[self updateAnnotations];
	[self.mapView.map addAnnotations:self.annotations];
	
	[self.mapView.map showAnnotations:self.annotations animated:YES];
}

-(void)updateAnnotations
{
	NSMutableArray *array = [NSMutableArray array];
	
	for (UserLocation *userLocation in self.services.userFinderService.userLocations) {
		UserLocationMapAnnotation *annotation = [[UserLocationMapAnnotation alloc] initWithUserLocation:userLocation];
		[array addObject:annotation];
	}
	
	self.annotations = [array copy];
}



#pragma mark - Lazy Properties

-(MapView *)mapView
{
	if (!_mapView) {
		_mapView = [MapView new];
	}
	
	return _mapView;
}

-(NSArray *)annotations
{
	if (!_annotations) {
		_annotations = @[];
	}
	
	return _annotations;
}

@end
