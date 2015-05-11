//
//  DNWRootViewController.h
//  LoveAndPeace
//
//  Created by qianfeng on 15/4/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseTabBarViewController.h"

@interface DNWRootViewController : UIViewController<UITabBarControllerDelegate>



@property(nonatomic,strong)BaseTabBarViewController *midTBC;


@property(nonatomic,strong)UIView *leftview;
@property(nonatomic,strong)UIView *rightview;


@end
