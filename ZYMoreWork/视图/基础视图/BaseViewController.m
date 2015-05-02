//
//  BaseViewController.m
//  ZYMoreWork
//
//  Created by qianfeng on 15/4/30.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)addBackItem
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    UIImage *img=[[UIImage imageNamed:@"backItem"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [btn setImage:img forState:UIControlStateNormal];
    
    btn.frame=CGRectMake(0, 0, 30, 30);
    [btn addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    //修改距离,距离边缘的 占位符按钮
    UIBarButtonItem *spaceItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width=-15;
    
    //解决 这个回拉的问题;
    self.navigationItem.leftBarButtonItems=@[spaceItem,item];
}
-(void)popBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
