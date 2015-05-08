//
//  CompanyViewController.m
//  ZYMoreWork
//
//  Created by qianfeng on 15/5/8.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "CompanyViewController.h"

@interface CompanyViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *CompanyWeb;
@property (weak, nonatomic) IBOutlet UILabel *titleView;


@end

@implementation CompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titleView.text=_titleLabel;
    self.view.backgroundColor=[UIColor whiteColor];
    NSString *urlStr=[NSString stringWithFormat:@"http://www.lagou.com/center/job_%@.html?m=1",_companyId];
    NSURL *url=[NSURL URLWithString:urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [_CompanyWeb loadRequest:request];
    [self addBackItem];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
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
