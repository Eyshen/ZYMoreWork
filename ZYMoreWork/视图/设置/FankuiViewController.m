//
//  FankuiViewController.m
//  ZYMoreWork
//
//  Created by qianfeng on 15/5/11.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "FankuiViewController.h"
#import "UIViewController+KeyboardAdditions.h"
@interface FankuiViewController ()<UITextViewDelegate>

@end

@implementation FankuiViewController

{
    CGFloat _width;
    CGFloat _height;
    UIView *_bgView;
    UIImageView *yijian;
    NSInteger cishu;
    CGFloat _keyheight;
    NSInteger cishuFUCK;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    NSLog(@"%ld,key=%f",(long)cishu,_keyheight);
    if (cishuFUCK==7) {
        CGRect frame=_bgView.frame;
        frame.origin.y+=(_keyheight-80);
        [UIView animateWithDuration:0.2 animations:^{
            _bgView.frame=frame;
        }];
        cishuFUCK=2;
    }
    cishu=0;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    cishu=0;
    // Do any additional setup after loading the view.
    _width=self.view.frame.size.width;
    _height=self.view.frame.size.width;
    
    _bgView=[[UIView alloc]initWithFrame:self.view.frame];
    
    UIImageView *iv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _width, 150)];
    [iv setImage:[UIImage imageNamed:@"fankuitupian"]];
    
    [_bgView addSubview:iv];
    
    UITextView *textView=[[UITextView alloc]initWithFrame:CGRectMake(15,165, _width-30, 145)];
    textView.backgroundColor=[UIColor whiteColor];
    textView.delegate=self;
    textView.font=[UIFont systemFontOfSize:15];
    
    yijian=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [yijian setImage:[UIImage imageNamed:@"baoguiyijian"]];
    [textView addSubview:yijian];
    [_bgView addSubview:textView];
    
    
    UIView *mobileView=[[UIView alloc]initWithFrame:CGRectMake(15, 325, _width-30, 40)];
    
    UILabel *shoujiLabel=[[UILabel alloc]initWithFrame:CGRectMake(5,0 , 80, 40)];
    shoujiLabel.text=@"您的手机号:";
    shoujiLabel.font=[UIFont systemFontOfSize:15];
    [mobileView addSubview:shoujiLabel];
    UITextField *shoujiTextf=[[UITextField alloc]initWithFrame:CGRectMake(85, 0, _width-85-30, 40)];
    [mobileView addSubview:shoujiTextf];
    mobileView.backgroundColor=[UIColor whiteColor];
    [_bgView addSubview:mobileView];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame=CGRectMake(0, 380, _width/2, 40);
    btn.center=CGPointMake(_width/2, btn.center.y);
    [btn setTitle:@"反馈" forState:UIControlStateNormal];
    btn.layer.masksToBounds=YES;
    btn.layer.cornerRadius=20;
    btn.backgroundColor=[UIColor colorWithRed:0.733 green:0.000 blue:0.055 alpha:1.000];
    btn.tintColor=[UIColor whiteColor];
    
    [_bgView addSubview:btn];
    
    [self addBackItem];
    
    
    
    _bgView.backgroundColor=[UIColor colorWithWhite:0.937 alpha:1.000];
    
    
    [self.view addSubview:_bgView];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"开始写了");
    [yijian removeFromSuperview];
    
}

#pragma mark----KeyboardAdditions
-(void)viewWillAppear:(BOOL)animated
{
    [self ka_startObservingKeyboardNotifications];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self ka_stopObservingKeyboardNotifications];
    
}

- (void)ka_keyboardShowOrHideAnimationWithHeight:(CGFloat)height
                               animationDuration:(NSTimeInterval)animationDuration
                                  animationCurve:(UIViewAnimationCurve)animationCurve {
    cishu++;
    if (cishu==1) {
        CGRect frame=_bgView.frame;
        if (self.view.frame.size.width==320&&height>200) {
            frame.origin.y-=(height-80);
            _keyheight=height;
            cishuFUCK=7;
        }
        [UIView animateWithDuration:0.2 animations:^{
            _bgView.frame=frame;
        }];
    }
    
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
