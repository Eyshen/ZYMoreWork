//
//  Person.h
//  tantanDemo
//
//  Created by qianfeng on 15/5/6.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic,copy)NSString *name;
@property (nonatomic,strong)UIImage *image;
@property (nonatomic,assign)NSUInteger age;
@property (nonatomic,assign)NSUInteger numberOfSharedFriends;
@property (nonatomic,assign)NSUInteger numberOfSharedInterests;
@property (nonatomic,assign)NSUInteger numberOfPhotos;

-(instancetype)initWithName:(NSString *)name image:(UIImage *)image age:(NSUInteger)age numberOfSharedFriends:(NSUInteger)numberOfSharedFriends numberOfSharedInterests:(NSUInteger)numberOfSharedInterests numberOfPhotos:(NSUInteger)numberOfPhotos;

@end
