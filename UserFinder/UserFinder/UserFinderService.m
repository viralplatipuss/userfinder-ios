//
//  UserFinderService.m
//  UserFinder
//
//  Created by Dom Chapman on 10/23/14.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

#import "UserFinderService.h"
#import "UserLocationsXMLParser.h"

@interface UserFinderService()

@property (nonatomic, strong, readonly) id <UserFinderLocationsDataSource> userFinderLocationsDataSource;

@property (nonatomic, strong, readonly) UserLocationsXMLParser *userLocationsParser;

@property (nonatomic, assign, readwrite) BOOL isRefreshing;

@property (nonatomic, strong, readwrite) NSArray *userLocations;

@end

@implementation UserFinderService

@synthesize userLocations = _userLocations, userLocationsParser = _userLocationsParser;



#pragma mark - Setup Methods

-(instancetype)initWithUserFinderLocationsDataSource:(id<UserFinderLocationsDataSource>)userFinderLocationsDataSource
{
	if (self = [super init]) {
		_userFinderLocationsDataSource = userFinderLocationsDataSource;
	}
	
	return self;
}



#pragma mark - Public Methods

-(void)refreshWithCompletion:(void (^)(BOOL success))completion
{
	if (self.isRefreshing) {
		if (completion) completion(NO);
		return;
	}
	
	self.isRefreshing = YES;
	
	dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(void){
		
		NSError *loadError;
		NSData *data = [self.userFinderLocationsDataSource getLocationDataWithError:&loadError];
		
		if (loadError) {
			NSLog(@"%@",loadError);
			
			dispatch_async(dispatch_get_main_queue(), ^(void){
				self.isRefreshing = NO;
				if(completion) completion(NO);
			});
			
		}else {
			
			NSArray *newLocations = [self.userLocationsParser userLocationsFromXMLData:data];
			
			if (newLocations) {
				
				dispatch_async(dispatch_get_main_queue(), ^(void){
					self.userLocations = newLocations;
					self.isRefreshing = NO;
					if(completion) completion(YES);
				});
			}else {
				
				dispatch_async(dispatch_get_main_queue(), ^(void){
					self.isRefreshing = NO;
					if(completion) completion(NO);
				});
				
			}
			
		}

	});
	
}



#pragma mark - Lazy Properties

-(NSArray *)userLocations
{
	if (!_userLocations) {
		_userLocations = @[];
	}
	
	return _userLocations;
}

-(UserLocationsXMLParser *)userLocationsParser
{
	if (!_userLocationsParser) {
		_userLocationsParser = [UserLocationsXMLParser new];
	}
	
	return _userLocationsParser;
}

@end
