//
//  CompanyViewController.m
//  ZYMoreWork
//
//  Created by qianfeng on 15/5/8.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "CompanyViewController.h"
#import "UMSocial.h"

#import "MBProgressHUD.h"
@interface CompanyViewController ()<UIWebViewDelegate,UMSocialUIDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *CompanyWeb;
@property (weak, nonatomic) IBOutlet UILabel *titleView;


@end

@implementation CompanyViewController
{
    NSString *_urlStr;
    //HUD（Head-Up Display，意思是抬头显示的意思）
    MBProgressHUD *HUD;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titleView.text=_titleLabel;
    self.view.backgroundColor=[UIColor whiteColor];
    _urlStr=[NSString stringWithFormat:@"http://www.lagou.com/center/job_%@.html?m=1",_companyId];
    NSURL *url=[NSURL URLWithString:_urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    _CompanyWeb.delegate=self;
    [_CompanyWeb loadRequest:request];
    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    //如果设置此属性则当前的view置于后台
    HUD.dimBackground = YES;
    
    //设置对话框文字
    HUD.labelText = @"请稍等";
    
   
    
    
    
    
    [self addBackItem];
}
- (IBAction)shareClick:(UIBarButtonItem *)sender {
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatTimeline,UMShareToWechatTimeline]];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"554dd22c67e58e10ee006b55"
                                      shareText:[NSString stringWithFormat:@"%@%@",self.titleLabel,_urlStr]
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToRenren,UMShareToTencent,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ,nil]
                                       delegate:self];
    
}
#pragma mark---点击直接分享内容;
//弹出列表方法presentSnsIconSheetView需要设置delegate为self
-(BOOL)isDirectShareInIconActionSheet
{
    return YES;
}

//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        UIAlertView *av=[[UIAlertView alloc]initWithTitle:@"分享成功" message:[NSString stringWithFormat:@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]] delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [av show];
    }
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"结束");
    [HUD removeFromSuperview];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"开始");
    //显示对话框
    [HUD show:YES];
//    [HUD showAnimated:YES whileExecutingBlock:^{
//        //对话框显示时需要执行的操作
//        sleep(3);
//    } completionBlock:^{
//        //操作执行完后取消对话框
//        [HUD removeFromSuperview];
//        
//        HUD = nil;
//    }];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
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
