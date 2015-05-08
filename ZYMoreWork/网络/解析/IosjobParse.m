//
//  IosjobParse.m
//  ZYMoreWork
//
//  Created by qianfeng on 15/5/7.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "IosjobParse.h"

@implementation IosjobParse
-(id)init
{
    if (self=[super init]) {
        _data=[NSMutableArray new];
    }
    return self;
}
+(instancetype)parse:(NSDictionary *)responseObj
{

    IosjobParse *parse=[self new];
    
    NSDictionary *contentDic=responseObj[@"content"];
    
    NSDictionary *dataDic=contentDic[@"data"];
    
    NSDictionary *pageDic=dataDic[@"page"];
    
    NSArray *resultArr=[NSArray new];
    resultArr=[pageDic[@"result"] mutableCopy];
    [resultArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [parse.data addObject:[IosjobInfo parse:obj]];
    }];
    return parse;
}
@end
@implementation IosjobInfo

+(instancetype)parse:(NSDictionary *)jobDic
{
    IosjobInfo *info=[IosjobInfo new];
    info.city=jobDic[@"city"];
    info.companyId=jobDic[@"companyId"];
    info.companyLogo=jobDic[@"companyLogo"];
    info.companyName=jobDic[@"companyName"];
    info.createTime=jobDic[@"createTime"];
    info.positionFirstType=jobDic[@"positionFirstType"];
    info.positionId=jobDic[@"positionId"];
    info.positionName=jobDic[@"positionName"];
    info.salary=jobDic[@"salary"];
    return info;
}

@end
