//
//  FindNetWork.h
//  moreWork
//
//  Created by qianfeng on 15/4/27.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "FindWorkParse.h"
#import "GongTuanParse.h"
#import "MendianParse.h"
#import "IosjobParse.h"
#import "XiangQIngParse.h"
#import "ZiXunParse.h"
@interface FindNetWork : NSObject

//获取第一页数据请求
+(void)getFindWorkSuccess:(void(^)(FindWorkParse *parse))success failure:(void(^)(NSString *errorMessage))failure withIDStr:(NSString *)idStr withGangID:(NSString *)gangStr withSort:(NSString *)sortStr page:(NSString *)page cityID:(NSString *)cityID;

#pragma mark----第一页公司详情
+(void)getCompanyInfoSuccess:(void(^)(XiangQIngParse *parse))success failure:(void(^)(NSString *errorMessage))failure withCompanyID:(NSString *)companyId;


+(void)getFindGongTuanSuccess:(void(^)(GongTuanParse *parse))success failure:(void(^)(NSString *errorMessage))failure;

+(void)getFIndMendianSuccess:(void(^)(MendianParse *parse))success failure:(void(^)(NSString *errorMessage))failure;

//第二页请求;
+(void)getIosjobSuccess:(void (^)(IosjobParse *parse))success failure:(void (^)(NSString *errorMessage))failure pageSize:(NSString *)pageSize;

+(void)getNewsSuccess:(void (^)(ZiXunParse *parse))success failure:(void (^)(NSString *errorMessage))failure urlStr:(NSString *)urlStr;




@end
