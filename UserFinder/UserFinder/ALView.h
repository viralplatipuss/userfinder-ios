//
//  ALView.h
//
//  Created by Dom Chapman.
//  Copyright (c) 2014 Dom Chapman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALView : UIView

//Use for overriding init
-(instancetype)initWithoutComplete;

//Call after custom init (without complete) to continue view setup as usual
-(void)completeInit;

@property (nonatomic, assign, readonly) BOOL didSetupConstraints;

-(void)setupView;
-(void)setupConstraints;

//Helpers
+(NSArray *)constraintsToFillView:(UIView *)viewToFill withView:(UIView *)view;

@end
