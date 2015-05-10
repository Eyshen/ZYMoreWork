//
//  MrEysionViewController.m
//  ZYMoreWork
//
//  Created by qianfeng on 15/5/9.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "MrEysionViewController.h"

@interface MrEysionViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *myDream;

@end

@implementation MrEysionViewController
{
    NSString *_urlStr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    _urlStr=@"http://www.lagou.com";
    NSURL *url=[NSURL URLWithString:_urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [_myDream loadRequest:request];
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
