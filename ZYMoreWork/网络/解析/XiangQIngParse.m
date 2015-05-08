//
//  XiangQIngParse.m
//  ZYMoreWork
//
//  Created by qianfeng on 15/5/8.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "XiangQIngParse.h"

@implementation XiangQIngParse
-(id)init
{
    
    if (self=[super init]) {
        _cityinfo=[NSString new];
        _content=[NSString new];
        _imgs=[NSMutableArray new];
        _infoData=[NSMutableArray new];
    }
    return self;
}
+(instancetype)parse:(NSDictionary *)responseObj
{
    XiangQIngParse *parse=[self new];
    NSDictionary *cityinfo=responseObj[@"cityinfo"];
    parse.cityinfo=[NSString stringWithFormat:@"企业地址  %@%@%@%@",cityinfo[@"firstname"],cityinfo[@"secondname"],cityinfo[@"thirdname"],cityinfo[@"fourname"]];
    NSDictionary *huangyeinfo=responseObj[@"huangyeinfo"];
    parse.content=huangyeinfo[@"content"];
    
    NSArray *imgsArr=responseObj[@"imgs"];
    [imgsArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *imageStr=obj[@"imgurl"];
        [parse.imgs addObject:imageStr];
    }];
    NSDictionary *info=responseObj[@"info"];
    
    [parse.infoData addObject:[XiangQIngInfo parse:info]];
   
    return parse;
}

@end

@implementation XiangQIngInfo

+(instancetype)parse:(NSDictionary *)infoDic
{
    
    XiangQIngInfo *info=[XiangQIngInfo new];
    
    info.title=infoDic[@"title"];
    info.gongzi1=[NSString stringWithFormat:@"¥%@-%@",infoDic[@"gongzi1"],infoDic[@"gongzi2"]];
    info.company=infoDic[@"company"];
    info.update_date=infoDic[@"update_date"];
    info.sex=[NSString stringWithFormat:@"性别要求: %@",infoDic[@"sex"]];
    info.age1=[NSString stringWithFormat:@"年龄要求:%@-%@岁",infoDic[@"age1"],infoDic[@"age2"]];
    info.xueli=[NSString stringWithFormat:@"学历要求:%@",infoDic[@"xueli"]];
    info.tags=[NSString stringWithFormat:@"岗位特色: %@",infoDic[@"tags"]];
    info.mobile=[NSString stringWithFormat:@"%@",infoDic[@"mobile"]];
    return info;
}

@end