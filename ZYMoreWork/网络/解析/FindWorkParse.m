//
//  FindWorkParse.m
//  moreWork
//
//  Created by qianfeng on 15/4/27.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "FindWorkParse.h"

@implementation FindWorkParse
+(instancetype)parse:(NSDictionary *)responseObj
{
    FindWorkParse *parse=[self new];
    
    for (NSDictionary *dic in [responseObj objectForKey:@"list"]) {
        NSArray *dataArr=[NSArray new];
        
        dataArr=dic[@"data"];
        NSMutableArray *cellData=[NSMutableArray new];
        for (NSDictionary *dataDic in dataArr) {
            [cellData addObject:[FindWorkInfo parse:dataDic]];
        }
        [parse.listData addObject:cellData];
        
        //获取公司名字
        FindWorkInfo *info=cellData[0];
        [parse.companyName addObject:info.companyname];
    }
    [parse.pagesData addObject:[FindPageInfo parse:responseObj[@"pages"]]];
    return parse;
}
-(id)init
{
    if (self=[super init]) {
        _listData=[NSMutableArray new];
        _pagesData=[NSMutableArray new];
        _companyName=[NSMutableArray new];
        
    }
    return self;
}
@end

@implementation FindWorkInfo

+(instancetype)parse:(NSDictionary *)workDic
{
    FindWorkInfo *info=[FindWorkInfo new];
    
    
    info.age1=workDic[@"age1"];
    info.age2=workDic[@"age2"];
    info.cityname=workDic[@"cityname"];
    info.companyname=workDic[@"companyname"];
    info.gongzi1=workDic[@"gongzi1"];
    info.gongzi2=workDic[@"gongzi2"];
    info.huangyeid=workDic[@"huangyeid"];
    info.myid=workDic[@"id"];
    info.jobname=workDic[@"jobname"];
    info.jobparentname=workDic[@"jobparentname"];
    info.logo=workDic[@"logo"];
    info.sex=workDic[@"sex"];
    info.thirdname=workDic[@"thirdname"];
    info.title=workDic[@"title"];
    info.update_date=workDic[@"update_date"];
    info.update_time=workDic[@"update_time"];
    return info;
}

@end
@implementation FindPageInfo

+(instancetype)parse:(NSDictionary *)pageDic
{
    FindPageInfo *info=[FindPageInfo new];
    
    info.limit=pageDic[@"limit"];
    info.limit_start=pageDic[@"limit_start"];
    info.next_page=pageDic[@"next_page"];
    info.page=pageDic[@"page"];
    info.page_count=pageDic[@"page_count"];
    info.page_size=pageDic[@"page_size"];
    info.prev_page=pageDic[@"prev_page"];
    info.total_count=pageDic[@"total_count"];
    
    return info;
}

@end