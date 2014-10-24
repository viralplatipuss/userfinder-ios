//
//  ListViewController.m
//  UserFinder
//
//  Created by Dom Chapman on 10/23/14.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

#import "ListViewController.h"
#import "ListView.h"
#import "UserLocation.h"


//KVO Context
static int kIsRefreshingKVOContext;
static int kUserLocationsKVOContext;


@interface ListViewController() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong, readonly) ListView *listView;

@end

@implementation ListViewController

@synthesize listView = _listView;



#pragma mark - Setup Methods

-(void)loadView
{
	self.view = self.listView;
}

-(void)servicesDidLoad
{
	self.listView.table.dataSource = self;
	self.listView.table.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self startKVO];
}

-(void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	[self stopKVO];
}



#pragma mark - KVO

-(void)startKVO
{
	[self addObserver:self forKeyPath:[self userLocationsKeyPath] options:NSKeyValueObservingOptionNew context:&kUserLocationsKVOContext];
	[self addObserver:self forKeyPath:[self isRefreshingKeyPath] options:NSKeyValueObservingOptionNew context:&kIsRefreshingKVOContext];}

-(void)stopKVO
{
	[self removeObserver:self forKeyPath:[self userLocationsKeyPath] context:&kUserLocationsKVOContext];
	[self removeObserver:self forKeyPath:[self isRefreshingKeyPath] context:&kIsRefreshingKVOContext];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if (context == &kIsRefreshingKVOContext || context == &kUserLocationsKVOContext) {
		[self performSelectorOnMainThread:@selector(updateTable) withObject:nil waitUntilDone:NO];
	}else {
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}



#pragma mark - UITableView Methods

-(void)updateTable
{
	[self.listView.table reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 70;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSUInteger userLocations = [self.services.userFinderService.userLocations count];
	
	if (userLocations > 0) {
		return [self.services.userFinderService.userLocations count];
	}else {
		
		return 1;
		
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *identifier = @"ListViewTableViewCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
	}
	
	
	//Setup Cell
	
	if ([self.services.userFinderService.userLocations count]) {
		
		UserLocation *userLocation = self.services.userFinderService.userLocations[indexPath.row];
		
		cell.textLabel.text = userLocation.address;
		
		cell.detailTextLabel.text = [userLocation dateAsString];
		
	}else {
		
		if (self.services.userFinderService.isRefreshing) {
			cell.textLabel.text = @"Loading...";
		}else {
			cell.textLabel.text = @"";
		}
		
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if ([self.services.userFinderService.userLocations count]) {
		if (self.delegate && [self.delegate respondsToSelector:@selector(listViewController:selectedUserLocationIndex:)]) {
			[self.delegate listViewController:self selectedUserLocationIndex:indexPath.row];
		}
	}
}



#pragma mark - Lazy Properties

-(ListView *)listView
{
	if (!_listView) {
		_listView = [ListView new];
	}
	
	return _listView;
}

@end
