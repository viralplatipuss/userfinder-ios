//
//  ALView.m
//
//  Created by Dom Chapman.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

#import "ALView.h"

@interface ALView()

@property (readwrite) BOOL didSetupConstraints;

@end

@implementation ALView

-(instancetype)init
{
  self = [self initWithoutComplete];
  if (self) {
		[self completeInit];
  }
  return self;
}

-(instancetype)initWithoutComplete
{
	return [super init];
}

-(void)completeInit
{
	[self setupView];
	[self disableTranslatesAutoresizingMaskIntoConstraintsForSubviews];
	[self setNeedsUpdateConstraints];
}

-(void)setupView
{
  //Override me
}

-(void)setupConstraints
{
  //Override me
}

-(void)updateConstraints
{
  [super updateConstraints];
  
  if (!self.didSetupConstraints) {
    self.didSetupConstraints = YES;
    [self setupConstraints];
  }
}

#pragma mark - Private

-(void)disableTranslatesAutoresizingMaskIntoConstraintsForSubviews
{
  for (UIView *view in self.subviews) {
    view.translatesAutoresizingMaskIntoConstraints = NO;
  }
}

#pragma mark - Private Helpers

+(NSArray *)constraintsToFillView:(UIView *)viewToFill withView:(UIView *)view
{
	return @[
		[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:viewToFill attribute:NSLayoutAttributeLeft multiplier:1 constant:0],
		[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:viewToFill attribute:NSLayoutAttributeRight multiplier:1 constant:0],
		[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:viewToFill attribute:NSLayoutAttributeTop multiplier:1 constant:0],
		[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:viewToFill attribute:NSLayoutAttributeBottom multiplier:1 constant:0]
		];
}


@end
