//
//  ZiXunParse.m
//  ZYMoreWork
//
//  Created by qianfeng on 15/5/10.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "ZiXunParse.h"

@implementation ZiXunParse
-(id)init
{
    if (self=[super init]) {
        _infoData=[NSMutableArray new];
        _StatusCode=[NSString new];
        _StatusDescription=[NSString new];
        _TotalCount=[NSString new];
    }
    return self;
}
+(instancetype)parse:(NSDictionary *)responseObj
{
   
    ZiXunParse *parse=[self new];
    NSArray *dataArr=[NSArray new];
    dataArr=responseObj[@"Info"];
    [dataArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [parse.infoData addObject:[ZiXunInfo parse:obj]];
    }];
    parse.StatusCode=responseObj[@"StatusCode"];
    parse.StatusDescription=responseObj[@"StatusDescription"];
    parse.TotalCount=responseObj[@"TotalCount"];
    return parse;
}
@end
@implementation ZiXunInfo

+(instancetype)parse:(NSDictionary *)newsDic
{
    ZiXunInfo *info=[ZiXunInfo new];
    info.myId=newsDic[@"Id"];
    info.PicUrl=newsDic[@"PicUrl"];
    info.Title=newsDic[@"Title"];
    
    return info;
}

@end
