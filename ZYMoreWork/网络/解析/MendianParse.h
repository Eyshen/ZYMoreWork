//
//  MendianParse.h
//  moreWork
//
//  Created by qianfeng on 15/4/27.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MendianParse : NSObject

@property (nonatomic, strong)NSMutableArray *listData;

+(instancetype)parse:(NSDictionary *)responseObj;
@end

@interface MendianInfo : NSObject

/*
"cityinfo": {
				"firstid": "4007",
				"firstname": "山东",
				"firstshowname": "shandong",
				"id": "4226",
				"idcard": "3702",
				"name": "青岛",
				"parentid": "4007",
				"secondid": "4226",
				"secondname": "青岛",
				"secondshowname": "qingdao",
				"showname": "qingdao",
				"thirdid": "0",
				"thirdname": "",
				"thirdshowname": ""
},
*/

@property (nonatomic,strong)NSString *address;
@property (nonatomic,strong)NSString *cityid;
@property (nonatomic,strong)NSDictionary *cityinfo;
@property (nonatomic,strong)NSString *face;
@property (nonatomic,strong)NSString *workId;
@property (nonatomic,strong)NSString *juli;
@property (nonatomic,strong)NSString *logo;
@property (nonatomic,strong)NSString *map;
@property (nonatomic,strong)NSString *mobile;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *truename;

+(instancetype)parse:(NSDictionary *)menDic;

@end