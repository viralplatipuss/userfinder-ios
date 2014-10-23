//
//  ListView.m
//  UserFinder
//
//  Created by Dom Chapman on 10/23/14.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

#import "ListView.h"

@interface ListView()

@end

@implementation ListView

@synthesize table = _table;

-(void)setupView
{	
	[self addSubview:self.table];
}

-(UITableView *)table
{
	if (!_table) {
		_table = [UITableView new];
	}
	
	return _table;
}

-(void)setupConstraints
{
	[self addConstraints:[ALView constraintsToFillView:self withView:self.table]];
}

@end
