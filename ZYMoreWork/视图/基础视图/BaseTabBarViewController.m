//
//  BaseTabBarViewController.m
//  ZYMoreWork
//
//  Created by qianfeng on 15/4/30.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "BaseTabBarViewController.h"

@interface BaseTabBarViewController ()

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //tabbar 改为不透明
    self.tabBar.translucent=NO;
    //设置背景图
    self.tabBar.backgroundImage=[[UIImage imageNamed:@"tabBar_ip6"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    //找工作
    //初始化故事板
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Work" bundle:nil];
    UINavigationController *workNavi=[storyboard instantiateInitialViewController];
//    [UIImage imageNamed:@"打工团-灰"
    workNavi.tabBarItem=[self tabBarItemWithName:@"传统行业" imageName:@"找工作-灰" selectedImageName:@"找工作-红"];
    //打工团
    UINavigationController *gongtuanNavi=[[UIStoryboard storyboardWithName:@"Gongtuan" bundle:nil]instantiateInitialViewController];
    
     gongtuanNavi.tabBarItem=[self tabBarItemWithName:@"互联网" imageName:@"打工团-灰" selectedImageName:@"打工团-红"];
    //找门店
    UINavigationController *mendianNavi=[[UIStoryboard storyboardWithName:@"Mendian" bundle:nil]instantiateInitialViewController];
    
    mendianNavi.tabBarItem=[self tabBarItemWithName:@"找门店" imageName:@"找门店-灰" selectedImageName:@"找门店-红"];
    //设置
    
    UINavigationController *setNavi=[[UIStoryboard storyboardWithName:@"Set" bundle:nil]instantiateInitialViewController];
    setNavi.tabBarItem=[self tabBarItemWithName:@"设置" imageName:@"设置-灰" selectedImageName:@"设置-红"];
    
    self.viewControllers=@[workNavi,gongtuanNavi,mendianNavi,setNavi];
}
-(UITabBarItem *)tabBarItemWithName:(NSString *)name imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    UIImage *aimage=[[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *bimage=[[UIImage imageNamed:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item=[[UITabBarItem alloc]initWithTitle:name image:aimage selectedImage:bimage];
    
    //调整字体大小的位置
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.522 alpha:1.000]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:11],NSForegroundColorAttributeName:[UIColor colorWithRed:0.804 green:0.000 blue:0.094 alpha:1.000]} forState:UIControlStateSelected];
    
    return item;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
