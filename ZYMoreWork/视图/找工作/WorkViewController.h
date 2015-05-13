//
//  WorkViewController.h
//  ZYMoreWork
//
//  Created by qianfeng on 15/4/30.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "BaseViewController.h"
#import "FindNetWork.h"
@interface WorkViewController : BaseViewController

@property (nonatomic,strong)NSString *cityID;

-(void)beginRefreshing;
-(void)setAlterView;
@end
