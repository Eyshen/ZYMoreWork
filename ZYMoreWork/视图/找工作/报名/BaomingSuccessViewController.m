//
//  BaomingSuccessViewController.m
//  ZYMoreWork
//
//  Created by qianfeng on 15/5/8.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "BaomingSuccessViewController.h"

@interface BaomingSuccessViewController ()

@end

@implementation BaomingSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackItem];
}
- (IBAction)backBtnClick:(UIButton *)sender {
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
