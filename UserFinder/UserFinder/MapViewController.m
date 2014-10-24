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


//KVO Context
static int kUserLocationsKVOContext;


@interface MapViewController()

@property (nonatomic, strong, readonly) MapView *mapView;

@property (nonatomic, strong, readwrite) NSArray *annotations;

@property (nonatomic, assign, readwrite) BOOL hasAppearedBefore;

@end

@implementation MapViewController

@synthesize mapView = _mapView, annotations = _annotations;



#pragma mark - Setup Methods

-(void)loadView
{
	self.view = self.mapView;
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self startKVO];
	
	if (!self.hasAppearedBefore) {
		self.hasAppearedBefore = YES;
		[self refreshMap];
	}
	
}

-(void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	[self stopKVO];
}



#pragma mark - Public Methods

-(void)zoomToUserLocationWithIndex:(NSUInteger)userLocationIndex animated:(BOOL)animated
{
	//Make use of the fact the annotations array matches the service's userLocation array
	UserLocationMapAnnotation *annotation = self.annotations[userLocationIndex];
	
	[self.mapView.map showAnnotations:@[annotation] animated:animated];
}



#pragma mark - KVO

-(void)startKVO
{
	[self addObserver:self forKeyPath:[self userLocationsKeyPath] options:NSKeyValueObservingOptionNew context:&kUserLocationsKVOContext];
}

-(void)stopKVO
{
	[self removeObserver:self forKeyPath:[self userLocationsKeyPath] context:&kUserLocationsKVOContext];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if (context == &kUserLocationsKVOContext) {
		[self refreshMap];
	}else {
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}



#pragma mark - Map Methods

-(void)refreshMap
{
	[self.mapView.map removeAnnotations:self.annotations];
	[self updateAnnotations];
	[self.mapView.map addAnnotations:self.annotations];
	
	[self zoomToFitAllAnnotations];
}

-(void)zoomToFitAllAnnotations
{
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
