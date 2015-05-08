//
//  Person.m
//  tantanDemo
//
//  Created by qianfeng on 15/5/6.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "Person.h"

@implementation Person
#pragma mark---object LifeCycle 项目生命周期
-(instancetype)initWithName:(NSString *)name image:(UIImage *)image age:(NSUInteger)age numberOfSharedFriends:(NSUInteger)numberOfSharedFriends numberOfSharedInterests:(NSUInteger)numberOfSharedInterests numberOfPhotos:(NSUInteger)numberOfPhotos
{
    if (self=[super init]) {
        _name=name;
        _image=image;
        _age=age;
        _numberOfSharedFriends=numberOfSharedFriends;
        _numberOfSharedInterests=numberOfSharedInterests;
        _numberOfPhotos=numberOfPhotos;
    }
    return self;
}
@end
