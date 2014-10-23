//
//  UserLocationsXMLParser.m
//  UserFinder
//
//  Created by Dom Chapman on 10/23/14.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

#import "UserLocationsXMLParser.h"
#import "UserLocation.h"

static NSString * const kLocationStartName = @"last_seen_at";
static NSString * const kLocationAddressName = @"address";
static NSString * const kLocationLatitudeName = @"lat";
static NSString * const kLocationLongitudeName = @"lon";
static NSString * const kLocationTimestampName = @"timestamp";


@interface UserLocationsXMLParser() <NSXMLParserDelegate>

@property (nonatomic, strong, readwrite) UserLocation *currentUserLocation;

@property (nonatomic, strong, readwrite) NSMutableString *currentCharacters;

@property (nonatomic, strong, readwrite) NSMutableArray *userLocations;

@end

@implementation UserLocationsXMLParser

-(NSArray *)userLocationsFromXMLData:(NSData *)xmlData
{
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
	[parser setDelegate:self];
	
	if([parser parse]) {
		NSArray *userLocations = [self.userLocations copy];
		self.userLocations = nil;
		self.currentCharacters = nil;
		self.currentUserLocation = nil;
		return userLocations;
	}else {
		return nil;
	}
}

-(void)parserDidStartDocument:(NSXMLParser *)parser
{
	self.userLocations = [NSMutableArray array];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	
	if ([elementName isEqualToString:kLocationStartName]) {
		self.currentUserLocation = [UserLocation new];
		return;
	}
	
	if ([elementName isEqualToString:kLocationAddressName] || [elementName isEqualToString:kLocationLatitudeName] || [elementName isEqualToString:kLocationLongitudeName] || [elementName isEqualToString:kLocationTimestampName]) {
		self.currentCharacters = [NSMutableString string];
		return;
	}
	
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	if ([elementName isEqualToString:kLocationStartName]) {
		[self.userLocations addObject:self.currentUserLocation];
		return;
	}
	
	if ([elementName isEqualToString:kLocationAddressName]) {
		self.currentUserLocation.address = [self.currentCharacters copy];
		return;
	}
	
	if ([elementName isEqualToString:kLocationLatitudeName]) {
		self.currentUserLocation.latitude = [self.currentCharacters doubleValue];
		return;
	}
	
	if ([elementName isEqualToString:kLocationLongitudeName]) {
		self.currentUserLocation.longitude = [self.currentCharacters doubleValue];
		return;
	}
	
	if ([elementName isEqualToString:kLocationTimestampName]) {
		NSTimeInterval timestamp = [self.currentCharacters doubleValue];
		self.currentUserLocation.date = [NSDate dateWithTimeIntervalSince1970:timestamp];
		return;
	}
	
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	[self.currentCharacters appendString:string];
}

@end
