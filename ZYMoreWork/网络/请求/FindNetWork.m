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
+(void)getCompanyInfoSuccess:(void (^)(XiangQIngParse *))success failure:(void (^)(NSString *))failure withCompanyID:(NSString *)companyId
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
   //wapi.chinalao.com/app/info?zhaopinid=4503
    [manager GET:@"http://wapi.chinalao.com/app/info" parameters:@{@"zhaopinid":companyId} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success([XiangQIngParse parse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error.localizedDescription);
    }];
}


#pragma mark--暂时不用(工团)
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

#pragma mark---暂时不用()
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
//www.lagou.com/custom/search.json?city=%E5%85%A8%E5%9B%BD&positionName=ios&pageNo=1&pageSize=15
+(void)getIosjobSuccess:(void (^)(IosjobParse *parse))success failure:(void (^)(NSString *errorMessage))failure pageSize:(NSString *)pageSize
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/plain"];
//    @{@"city":@"%E5%85%A8%E5%9B%BD",@"positionName":@"ios",@"pageNo":@"1",@"pageSize":pageSize}
    
    
    NSString *urlStr=@"http://www.lagou.com/custom/search.json?city=%E5%85%A8%E5%9B%BD&positionName=ios&pageNo=";
    pageSize=[NSString stringWithFormat:@"%@&pageSize=15",pageSize];
    urlStr=[urlStr stringByAppendingString:pageSize];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success([IosjobParse parse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error.localizedDescription);
    }];
}
+(void)getNewsSuccess:(void (^)(ZiXunParse *))success failure:(void (^)(NSString *))failure urlStr:(NSString *)urlStr
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"application/json"];
    //mi.zhaopin.com/iPhone/info/Infolist?d=45389FE5E07070A195009971B5A2544D&pageSize=20&key=135486907262855&channel=apple&pageIndex=1&v=4.1&t=1431240605&e=646ec20311898ccbf34d7cee524c54d9
    //mi.zhaopin.com/iPhone/info/Infolist?d=45389FE5E07070A195009971B5A2544D&pageSize=20&key=135486907262855&channel=apple&pageIndex=2&v=4.1&t=1431244455&e=8d0bf296f97cd7e783101d0cd16f6481
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        success([ZiXunParse parse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error.localizedDescription);
    }];
}


@end
