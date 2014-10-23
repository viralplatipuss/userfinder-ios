//
//  MainTabBarController.m
//  UserFinder
//
//  Created by Dom Chapman on 10/23/14.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

#import "MainTabBarController.h"
#import "ListViewController.h"
#import "MapViewController.h"

typedef NS_ENUM(NSUInteger, ViewPage) {
	ViewPageList,
	ViewPageMap
};

@interface MainTabBarController() <ListViewControllerDelegate>

@property (nonatomic, strong, readonly) UIBarButtonItem *refreshButton;

@property (nonatomic, strong, readonly) UISegmentedControl *segmentedControl;

@property (nonatomic, strong, readonly) ListViewController *listViewController;

@property (nonatomic, strong, readonly) MapViewController *mapViewController;

@end

@implementation MainTabBarController

@synthesize refreshButton = _refreshButton, segmentedControl = _segmentedControl, listViewController = _listViewController, mapViewController = _mapViewController;



#pragma mark - Setup Methods

-(void)servicesDidLoad
{
	//Setup
	self.tabBar.hidden = YES;
	self.tabBar.translucent = NO;
	self.edgesForExtendedLayout = UIRectEdgeNone;

	[self setupNavBar];
	
	self.viewControllers = @[self.listViewController, self.mapViewController];
	
	[self showDefaultPage];
	
	//KVO
	[self addObserver:self forKeyPath:[self isRefreshingKeyPath] options:NSKeyValueObservingOptionNew context:NULL];
	
	//First data call
	[self refresh];
}

-(void)setupNavBar
{
	self.navigationItem.titleView = self.segmentedControl;
	self.navigationItem.rightBarButtonItem = self.refreshButton;
}



#pragma mark - Refresh Method

-(void)refresh
{
	[self.services.userFinderService refreshWithCompletion:^(BOOL success) {
		
		if (!success) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Refresh Failed" message:@"Unable to refresh user locations. Sorry about that. :(" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			[alert show];
		}
		
	}];
}



#pragma mark - Change View Methods

-(void)showDefaultPage
{
	if (self.services.preferencesService.startOnMapView) {
		[self showViewPage:ViewPageMap];
	}else {
		[self showViewPage:ViewPageList];
	}
}

-(void)showViewPage:(ViewPage)viewPage
{
	[self.segmentedControl setSelectedSegmentIndex:viewPage];
	[self updateViewPage];
}

-(void)updateViewPage
{
	if (self.segmentedControl.selectedSegmentIndex == ViewPageList) {
		self.services.preferencesService.startOnMapView = NO;
		self.selectedViewController = self.listViewController;
		[self.listViewController updateViewConstraints];
	}else {
		self.services.preferencesService.startOnMapView = YES;
		self.selectedViewController = self.mapViewController;
		[self.mapViewController updateViewConstraints];
	}
}



#pragma mark - ListViewController Delegate Methods

-(void)listViewController:(ListViewController *)listViewController selectedUserLocationIndex:(NSUInteger)userLocationIndex
{
	[self showViewPage:ViewPageMap];
	[self.mapViewController zoomToUserLocationWithIndex:userLocationIndex animated:NO];
}



#pragma mark - KVO

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	self.refreshButton.enabled = !self.services.userFinderService.isRefreshing;
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:self.services.userFinderService.isRefreshing];
}



#pragma mark - Lazy Properties

-(UIBarButtonItem *)refreshButton
{
	if (!_refreshButton) {
		_refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
	}
	
	return _refreshButton;
}

-(UISegmentedControl *)segmentedControl
{
	if (!_segmentedControl) {
		_segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"List",@"Map"]];
		[_segmentedControl addTarget:self action:@selector(updateViewPage) forControlEvents:UIControlEventValueChanged];
	}
	
	return _segmentedControl;
}

-(ListViewController *)listViewController
{
	if (!_listViewController) {
		_listViewController = [[ListViewController alloc] initWithServices:self.services];
		_listViewController.delegate = self;
	}
	
	return _listViewController;
}

-(MapViewController *)mapViewController
{
	if (!_mapViewController) {
		_mapViewController = [[MapViewController alloc] initWithServices:self.services];
	}
	
	return _mapViewController;
}

@end
