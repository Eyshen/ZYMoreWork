//
//  GongTuanParse.h
//  moreWork
//
//  Created by qianfeng on 15/4/27.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GongTuanParse : NSObject
@property (nonatomic,strong) NSMutableArray *listData;

+(instancetype)parse:(NSDictionary *)responseObj;
@end

@interface GongTuanInfo : NSObject


@property (nonatomic,strong)NSString *age1;
@property (nonatomic,strong)NSString *age2;
@property (nonatomic,strong)NSString *baoming;
@property (nonatomic,strong)NSString *baoming_count;
@property (nonatomic,strong)NSString *baoming_type;
@property (nonatomic,strong)NSString *cityid;
@property (nonatomic,strong)NSString *gongzi1;
@property (nonatomic,strong)NSString *gongzi2;
@property (nonatomic,strong)NSString *huangyeid;
@property (nonatomic,strong)NSString *workid;
@property (nonatomic,strong)NSString *list_img_alt;
@property (nonatomic,strong)NSString *list_show_cityname;
@property (nonatomic,strong)NSString *renshu;
@property (nonatomic,strong)NSString *secondname;
@property (nonatomic,strong)NSString *seo_img;
@property (nonatomic,strong)NSString *sex;
@property (nonatomic,strong)NSString *show_img;
@property (nonatomic,strong)NSString *tags;
@property (nonatomic,strong)NSString *thirdname;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *updatedate;
@property (nonatomic,strong)NSString *xueli;

+(instancetype)parse:(NSDictionary *)jobDic;
@end