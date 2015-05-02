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
@interface FindNetWork : NSObject

//获取第一页数据请求
+(void)getFindWorkSuccess:(void(^)(FindWorkParse *parse))success failure:(void(^)(NSString *errorMessage))failure withIDStr:(NSString *)idStr withGangID:(NSString *)gangStr withSort:(NSString *)sortStr;

+(void)getFindGongTuanSuccess:(void(^)(GongTuanParse *parse))success failure:(void(^)(NSString *errorMessage))failure;

+(void)getFIndMendianSuccess:(void(^)(MendianParse *parse))success failure:(void(^)(NSString *errorMessage))failure;
@end
