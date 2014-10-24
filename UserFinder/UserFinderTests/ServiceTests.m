//
//  ServiceTests.m
//  UserFinder
//
//  Created by Dom Chapman on 10/24/14.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UserFinderSampleLocationsDataSource.h"
#import "UserLocationsXMLParser.h"
#import "UserLocation.h"
#import "UserFinderService.h"

@interface ServiceTests : XCTestCase

@end

@implementation ServiceTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testSampleLocationsDataSource
{
	UserFinderSampleLocationsDataSource *dataSource = [UserFinderSampleLocationsDataSource new];
	NSError *error;
	NSData *data = [dataSource getLocationDataWithError:&error];
	
	XCTAssertNil(error, @"Fetching sample locations returned error");
	XCTAssertNotNil(data, @"Fetching sample locations returned no data.");
}

-(void)testUserLocationsXMLParser
{
	UserFinderSampleLocationsDataSource *dataSource = [UserFinderSampleLocationsDataSource new];
	NSData *data = [dataSource getLocationDataWithError:nil];
	
	//Should have viable data at this point, else sample locations test would fail.
	
	UserLocationsXMLParser *xmlParser = [UserLocationsXMLParser new];
	
	NSArray *locations = [xmlParser userLocationsFromXMLData:data];
	
	XCTAssertNotNil(locations, @"No locations parsed from sample XML data.");
	
	XCTAssertEqual([locations count], 7, @"XML parser did not find exactly 7 locations in sample data.");
	
	UserLocation *firstLocation = locations[0];
	
	XCTAssertNotNil(firstLocation.address, @"XML parser did not find address for first location.");
	XCTAssertNotNil(firstLocation.date, @"XML parser did not find date for first location.");
}

-(void)testUserFinderService
{
	UserFinderSampleLocationsDataSource *dataSource = [UserFinderSampleLocationsDataSource new];
	UserFinderService *service = [[UserFinderService alloc] initWithUserFinderLocationsDataSource:dataSource];
	
	XCTAssertFalse(service.isRefreshing, @"UserFinderService thinks it's refreshing before refresh has been called.");
	
	[service refreshWithCompletion:^(BOOL success) {
		
		XCTAssertTrue(success, @"UserFinderService fails to refresh successfully with sample data.");
		XCTAssertFalse(service.isRefreshing, @"UserFinderService still thinks it's refreshing after calling completion block.");

		XCTAssertNotNil(service.userLocations,@"UserFinderService has no locations after refresh with sample data.");
		
	}];
	
	XCTAssertTrue(service.isRefreshing, @"UserFinderService does not correctly set isRefreshing after calling refresh.");
}


@end
