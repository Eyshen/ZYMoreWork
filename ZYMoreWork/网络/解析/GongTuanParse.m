//
//  GongTuanParse.m
//  moreWork
//
//  Created by qianfeng on 15/4/27.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "GongTuanParse.h"

@implementation GongTuanParse

-(id)init
{
    if (self=[super init]) {
        _listData=[NSMutableArray new];
    }
    return self;
}

+(instancetype)parse:(NSDictionary *)responseObj
{
    GongTuanParse *parse=[self new];
    for (NSDictionary *dic in [responseObj objectForKey:@"list"]) {
        [parse.listData addObject:[GongTuanInfo parse:dic]];
    }
    return parse;
}
@end
@implementation GongTuanInfo

+(instancetype)parse:(NSDictionary *)jobDic
{
    GongTuanInfo *info=[GongTuanInfo new];
    
    info.age1=jobDic[@"age1"];
    info.age2=jobDic[@"age2"];
    info.baoming=jobDic[@"baoming"];
    info.baoming_count=jobDic[@"baoming_count"];
    info.baoming_type=jobDic[@"baoming_type"];
    info.cityid=jobDic[@"cityid"];
    info.gongzi1=jobDic[@"gongzi1"];
    info.gongzi2=jobDic[@"gongzi2"];
    info.huangyeid=jobDic[@"huangyeid"];
    info.workid=jobDic[@"id"];
    info.list_img_alt=jobDic[@"list_img_alt"];
    info.list_show_cityname=jobDic[@"list_show_cityname"];
    info.renshu=jobDic[@"renshu"];
    info.secondname=jobDic[@"secondname"];
    info.seo_img=jobDic[@"seo_img"];
    info.sex=jobDic[@"sex"];
    info.show_img=jobDic[@"show_img"];
    info.tags=jobDic[@"tags"];
    info.thirdname=jobDic[@"thirdname"];
    info.title=jobDic[@"title"];
    info.updatedate=jobDic[@"updatedate"];
    info.xueli=jobDic[@"xueli"];
    
    return info;
}


@end
