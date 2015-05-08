//
//  ChoosePersonView.h
//  tantanDemo
//
//  Created by qianfeng on 15/5/6.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "MDCSwipeToChooseView.h"
#import <MDCSwipeToChoose/MDCSwipeToChoose.h>
@class Person;
@class IosjobInfo;
@interface ChoosePersonView : MDCSwipeToChooseView

@property (nonatomic,strong,readonly)Person *person;

@property (nonatomic,strong,readonly)IosjobInfo *info;
//-(instancetype)initWithFrame:(CGRect)frame person:(Person *)person  options:(MDCSwipeToChooseViewOptions *)options;
-(instancetype)initWithFrame:(CGRect)frame IosjobInfo:(IosjobInfo *)info options:(MDCSwipeToChooseViewOptions *)options;

@end
