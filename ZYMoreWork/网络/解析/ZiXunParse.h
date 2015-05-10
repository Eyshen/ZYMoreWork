//
//  ZiXunParse.h
//  ZYMoreWork
//
//  Created by qianfeng on 15/5/10.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZiXunParse : NSObject
@property (nonatomic,strong)NSMutableArray *infoData;
@property (nonatomic,strong)NSString *StatusCode;
@property (nonatomic,strong)NSString *StatusDescription;
@property (nonatomic,strong)NSString *TotalCount;
+(instancetype)parse:(NSDictionary *)responseObj;

@end
@interface ZiXunInfo : NSObject
@property (nonatomic,strong)NSString *myId;
@property (nonatomic,strong)NSString *PicUrl;
@property (nonatomic,strong)NSString *Title;
+(instancetype)parse:(NSDictionary *)newsDic;
@end
