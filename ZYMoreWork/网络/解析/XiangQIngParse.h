//
//  XiangQIngParse.h
//  ZYMoreWork
//
//  Created by qianfeng on 15/5/8.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XiangQIngParse : NSObject
@property (nonatomic,strong)NSString *cityinfo;
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSMutableArray *imgs;
@property (nonatomic,strong)NSMutableArray *infoData;
+(instancetype)parse:(NSDictionary *)responseObj;
@end

@interface XiangQIngInfo : NSObject
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *gongzi1;
@property (nonatomic,strong)NSString *gongzi2;
@property (nonatomic,strong)NSString *company;
@property (nonatomic,strong)NSString *update_date;
@property (nonatomic,strong)NSString *sex;
@property (nonatomic,strong)NSString *age1;
@property (nonatomic,strong)NSString *age2;
@property (nonatomic,strong)NSString *xueli;
@property (nonatomic,strong)NSString *tags;
@property (nonatomic,strong)NSString *mobile;

+(instancetype)parse:(NSDictionary *)infoDic;
@end
