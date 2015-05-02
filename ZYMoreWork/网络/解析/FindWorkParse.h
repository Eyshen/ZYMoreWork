//
//  FindWorkParse.h
//  moreWork
//
//  Created by qianfeng on 15/4/27.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindWorkParse : NSObject

@property (nonatomic,strong)NSMutableArray *listData;
@property (nonatomic,strong)NSMutableArray *pagesData;
@property (nonatomic,strong)NSMutableArray *companyName;

+(instancetype)parse:(NSDictionary *)responseObj;
@end

@interface FindWorkInfo : NSObject

@property (nonatomic,strong)NSString *age1;
@property (nonatomic,strong)NSString *age2;
@property (nonatomic,strong)NSString *cityname;
@property (nonatomic,strong)NSString *companyname;
@property (nonatomic,strong)NSString *gongzi1;
@property (nonatomic,strong)NSString *gongzi2;
@property (nonatomic,strong)NSString *huangyeid;
@property (nonatomic,strong)NSString *myid;
@property (nonatomic,strong)NSString *jobname;
@property (nonatomic,strong)NSString *jobparentname;
@property (nonatomic,strong)NSString *logo;
@property (nonatomic,strong)NSString *sex;
@property (nonatomic,strong)NSString *thirdname;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *update_date;
@property (nonatomic,strong)NSString *update_time;

+(instancetype)parse:(NSDictionary *)workDic;
@end

@interface FindPageInfo : NSObject
@property (nonatomic,strong)NSString *limit;
@property (nonatomic,strong)NSString *limit_start;
@property (nonatomic,strong)NSString *next_page;
@property (nonatomic,strong)NSString *page;
@property (nonatomic,strong)NSString *page_count;
@property (nonatomic,strong)NSString *page_size;
@property (nonatomic,strong)NSString *prev_page;
@property (nonatomic,strong)NSString *total_count;

+(instancetype)parse:(NSDictionary *)pageDic;
@end



