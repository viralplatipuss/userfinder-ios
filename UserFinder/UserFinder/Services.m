//
//  Services.m
//  UserFinder
//
//  Created by Dom Chapman on 10/23/14.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

#import "Services.h"
#import "UserFinderSampleLocationsDataSource.h"
#import "UserFinderWebLocationsDataSource.h"

//Switch between sample/web data for debugging.
static const BOOL kUseSampleData = YES;


@interface Services()

@property (nonatomic, strong, readonly) UserFinderSampleLocationsDataSource *sampleDataSource;

@property (nonatomic, strong, readonly) UserFinderWebLocationsDataSource *webDataSource;

@end

@implementation Services

@synthesize sampleDataSource = _sampleDataSource, webDataSource = _webDataSource, userFinderService = _userFinderService, preferencesService = _preferencesService;


-(UserFinderWebLocationsDataSource *)webDataSource
{
	if (!_webDataSource) {
		_webDataSource = [UserFinderWebLocationsDataSource new];
	}
	
	return _webDataSource;
}

-(UserFinderSampleLocationsDataSource *)sampleDataSource
{
	if (!_sampleDataSource) {
		_sampleDataSource = [UserFinderSampleLocationsDataSource new];
	}
	
	return _sampleDataSource;
}

-(UserFinderService *)userFinderService
{
	if (!_userFinderService) {
		
		id <UserFinderLocationsDataSource> dataSource;
		
		if (kUseSampleData) {
			dataSource = self.sampleDataSource;
		}else {
			dataSource = self.webDataSource;
		}
		
		_userFinderService = [[UserFinderService alloc] initWithUserFinderLocationsDataSource:dataSource];
	}
	
	return _userFinderService;
}

-(PreferencesService *)preferencesService
{
	if (!_preferencesService) {
		_preferencesService = [PreferencesService new];
	}
	
	return _preferencesService;
}


@end
