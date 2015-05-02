//
//  MendianParse.m
//  moreWork
//
//  Created by qianfeng on 15/4/27.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "MendianParse.h"

@implementation MendianParse
-(id)init
{
    if (self=[super init]) {
        _listData=[NSMutableArray new];
    }
    return self;
}
+(instancetype)parse:(NSDictionary *)responseObj
{
    MendianParse *parse=[self new];
    for (NSDictionary *dic in responseObj[@"list"]) {
        [parse.listData addObject:[MendianInfo parse:dic]];
    }
    return parse;
}
@end
@implementation MendianInfo

+(instancetype)parse:(NSDictionary *)menDic
{
    MendianInfo *info=[MendianInfo new];
    info.address=menDic[@"address"];
    info.cityid=menDic[@"cityid"];
    info.cityinfo=menDic[@"cityinfo"];
    info.face=menDic[@"face"];
    info.workId=menDic[@"id"];
    info.juli=menDic[@"juli"];
    info.logo=menDic[@"logo"];
    info.map=menDic[@"map"];
    info.mobile=menDic[@"mobile"];
    info.name=menDic[@"name"];
    info.truename=menDic[@"truename"];
    return info;
}


@end
