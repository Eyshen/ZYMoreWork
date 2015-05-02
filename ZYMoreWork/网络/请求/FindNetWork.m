//
//  FindNetWork.m
//  moreWork
//
//  Created by qianfeng on 15/4/27.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "FindNetWork.h"

@implementation FindNetWork
+(void)getFindWorkSuccess:(void (^)(FindWorkParse *))success failure:(void (^)(NSString *))failure withIDStr:(NSString *)idStr withGangID:(NSString *)gangStr withSort:(NSString *)sortStr
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    
    //wapi.chinalao.com/app/index20150401?city_id=4226&sort=0&page=1&page_size=10&thirdid=0&gangweiid=0
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    [manager GET:@"http://wapi.chinalao.com/app/index20150401" parameters:@{@"city_id":@"4226",@"sort":sortStr,@"page":@"1",@"page_size":@"10",@"thirdid":idStr,@"gangweiid":gangStr} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        success([FindWorkParse parse:responseObject]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error.localizedDescription);
    }];
}


+(void)getFindGongTuanSuccess:(void (^)(GongTuanParse *))success failure:(void (^)(NSString *))failure
{
    //wapi.chinalao.com/tuan/index?cityid=0
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    
    [manager GET:@"http://wapi.chinalao.com/tuan/index" parameters:@{@"cityid":@"0"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        success([GongTuanParse parse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error.localizedDescription);
    }];
}


+(void)getFIndMendianSuccess:(void(^)(MendianParse *parse))success failure:(void(^)(NSString *errorMessage))failure
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    //wapi.chinalao.com/mendian/index?city_id=4226&location=121.539797,38.893955&page=1&page_size=10
    [manager GET:@"http://wapi.chinalao.com/mendian/index" parameters:@{@"city_id":@"4226",@"location":@"121.539797,38.893955",@"page":@"1",@"page_size":@"10"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        success([MendianParse parse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error.localizedDescription);
    }];
}


@end
