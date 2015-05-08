//
//  IosjobParse.h
//  ZYMoreWork
//
//  Created by qianfeng on 15/5/7.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IosjobParse : NSObject

@property (nonatomic,strong)NSMutableArray *data;

+(instancetype)parse:(NSDictionary *)responseObj;


@end
@interface IosjobInfo : NSObject

@property (nonatomic,strong)NSString *city;
@property (nonatomic,strong)NSString *companyId;
@property (nonatomic,strong)NSString *companyLogo;
@property (nonatomic,strong)NSString *companyName;
@property (nonatomic,strong)NSString *createTime;
@property (nonatomic,strong)NSString *positionFirstType;
@property (nonatomic,strong)NSString *positionId;
@property (nonatomic,strong)NSString *positionName;
@property (nonatomic,strong)NSString *salary;

+(instancetype)parse:(NSDictionary *)jobDic;
@end