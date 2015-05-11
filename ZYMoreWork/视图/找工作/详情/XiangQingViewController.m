//
//  XiangQingViewController.m
//  ZYMoreWork
//
//  Created by qianfeng on 15/5/2.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "XiangQingViewController.h"
#import "FindNetWork.h"
#import "BaomingViewController.h"
#import "UMSocial.h"
@interface XiangQingViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIAlertViewDelegate,UMSocialUIDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;


@end

@implementation XiangQingViewController
{
    XiangQIngParse *_parse;
    XiangQIngInfo *_info;
    UIView *_lineView;
    CGFloat cell1;
    CGFloat cell2;
    CGFloat cell3;
    CGFloat _width;
    CGFloat _height;
    NSTimer *_timer;
    UIScrollView *_scroll;
    UIPageControl *_pageView;
    
    
    UIView *_downViewa;
    UIView *_downViewb;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _info=[XiangQIngInfo new];
    _width=self.view.frame.size.width;
    _height=self.view.frame.size.height;
    // Do any additional setup after loading the view.
    [FindNetWork getCompanyInfoSuccess:^(XiangQIngParse *parse) {
        _parse=parse;
        
        _info=_parse.infoData[0];
        NSLog(@"详情下载成功,%@--%@",_info.company,_parse.cityinfo);
        [_myTableView reloadData];
    } failure:^(NSString *errorMessage) {
        NSLog(@"下载失败%@",errorMessage);
    } withCompanyID:self.zhaopinid];
    cell1=248;
    cell2=187;
    cell3=248;
    
    [self constructBaomingBtn];
    
    [self addBackItem];
}
#pragma  分享
- (IBAction)shareClick:(UIBarButtonItem *)sender {
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatTimeline,UMShareToWechatTimeline]];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"554dd22c67e58e10ee006b55"
                                      shareText:[NSString stringWithFormat:@"%@http://blog.csdn.net/mreshen",_info.title]
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


-(void)constructBaomingBtn
{
    UIButton *baomingBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    UIButton *callBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    
    baomingBtn.frame=CGRectMake(_width-80, _height-220, 60, 60);
    callBtn.frame=CGRectMake(_width-80, _height-150,60, 60);
    
    baomingBtn.backgroundColor=[UIColor colorWithRed:0.808 green:0.114 blue:0.173 alpha:1.000];
    callBtn.backgroundColor=[UIColor colorWithRed:0.808 green:0.114 blue:0.173 alpha:1.000];
    [baomingBtn setTitle:@"报名" forState: UIControlStateNormal];
    [callBtn setTitle:@"Call" forState: UIControlStateNormal];
    
    baomingBtn.tintColor=[UIColor whiteColor];
    callBtn.tintColor=[UIColor whiteColor];
    
    baomingBtn.layer.masksToBounds=YES;
    baomingBtn.layer.cornerRadius=30;
    
    callBtn.layer.masksToBounds=YES;
    callBtn.layer.cornerRadius=30;
    
    baomingBtn.tag=40;
    callBtn.tag=41;
    [baomingBtn addTarget:self action:@selector(baomingBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [callBtn addTarget:self action:@selector(baomingBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:baomingBtn];
    [self.view addSubview:callBtn];
}
#pragma mark---报名和打电话
-(void)baomingBtnClick:(UIButton *)sender
{
    if (sender.tag==40) {
        NSLog(@"报名");
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Work" bundle:nil];
        BaomingViewController *baomingVC=[storyboard instantiateViewControllerWithIdentifier:@"BaomingViewController"];
        
        baomingVC.companyTitle=[NSString stringWithFormat:@"  %@",_info.title];
        baomingVC.gongzi=[NSString stringWithFormat:@"  %@元/月",_info.gongzi1];
        baomingVC.companyName=[NSString stringWithFormat:@"%@",_info.company];
        baomingVC.update=_info.update_date;
        NSLog(@"?????????");
        [self.navigationController pushViewController:baomingVC animated:YES];
    }else{
        NSLog(@"打电话");
        NSString *telStr=[NSString stringWithFormat:@"电话: %@",_info.mobile];
        UIAlertView *av=[[UIAlertView alloc]initWithTitle:@"拨打电话" message:telStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
        [av show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex%u",buttonIndex);
    if (buttonIndex==1) {
        NSString *telStr=[NSString stringWithFormat:@"tel://%@",_info.mobile];
        NSLog(@"%@",telStr);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr]];
    }
}
-(void)viewDidLayoutSubviews
{
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return cell1;
    }else if(indexPath.row==1)
    {
        return cell2;
    }else{
        return cell3;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"headCell" forIndexPath:indexPath];
        _scroll=(UIScrollView *)[cell.contentView viewWithTag:10];
        UILabel *titleLabel=(UILabel *)[cell.contentView viewWithTag:11];
        UILabel *gongzi=(UILabel *)[cell.contentView viewWithTag:12];
        UILabel *company=(UILabel *)[cell.contentView viewWithTag:13];
        UILabel *updateLabel=(UILabel *)[cell.contentView viewWithTag:14];
        titleLabel.text=[NSString stringWithFormat:@"  %@",_info.title];
        NSString *gongziStr=[NSString stringWithFormat:@"  %@元/月",_info.gongzi1];
        NSMutableAttributedString *attribute=[[NSMutableAttributedString alloc]initWithString:gongziStr];
        NSDictionary *typeDic=@{NSForegroundColorAttributeName:[UIColor redColor]};
        NSRange range=[_info.gongzi1 rangeOfString:gongziStr];
        [attribute setAttributes:typeDic range:range];
        gongzi.attributedText=attribute;
        company.text=[NSString stringWithFormat:@"  %@",_info.company];
        updateLabel.text=_info.update_date;
        
        
        _width=self.view.frame.size.width;
        _scroll.contentSize=CGSizeMake(_width*6,170);
        _scroll.delegate=self;
        if (_parse.imgs[0]!=nil) {
            NSLog(@"周几次???????%@",_parse.imgs[0]);
            NSLog(@"width===%f",_width);
            for (int i=0; i<_parse.imgs.count; i++) {
                UIImageView *iv=[[UIImageView alloc]initWithFrame:CGRectMake(i*_width, 0, _width, 170)];
                [iv setImageWithURL:[NSURL URLWithString:_parse.imgs[i]]];
                
                [_scroll addSubview:iv];
            }
            UIImageView *iv=[[UIImageView alloc]initWithFrame:CGRectMake(5*_width, 0, _width, 170)];
            [iv setImageWithURL:[NSURL URLWithString:_parse.imgs[0]]];
            [_scroll addSubview:iv];
            _timer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(imageRun) userInfo:nil repeats:YES];
        }
        
        _pageView=[[UIPageControl alloc]initWithFrame:CGRectMake(0, 160, 50, 10)];
        _pageView.center=CGPointMake(cell.contentView.center.x, _pageView.center.y);
        _pageView.numberOfPages=_parse.imgs.count-1;
        [cell.contentView addSubview:_pageView];
        return cell;
    }else if(indexPath.row==1)
    {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"midCell" forIndexPath:indexPath];
        UILabel *sexLabel=(UILabel *)[cell.contentView viewWithTag:20];
        UILabel *ageLabel=(UILabel *)[cell.contentView viewWithTag:21];
        UILabel *xueliLabel=(UILabel *)[cell.contentView viewWithTag:22];
        UILabel *gangweiLabel=(UILabel *)[cell.contentView viewWithTag:23];
        UILabel *qiyeLabel=(UILabel *)[cell.contentView viewWithTag:24];
        UILabel *mobile=(UILabel *)[cell.contentView viewWithTag:25];
        
        sexLabel.text=[NSString stringWithFormat:@"  %@",_info.sex];
        ageLabel.text=[NSString stringWithFormat:@"  %@",_info.age1];
        xueliLabel.text=[NSString stringWithFormat:@"  %@",_info.xueli];
        gangweiLabel.text=[NSString stringWithFormat:@"  %@",_info.tags];
        qiyeLabel.text=[NSString stringWithFormat:@"  %@",_parse.cityinfo];
        mobile.text=[NSString stringWithFormat:@"  联系电话  %@",_info.mobile];
        return cell;
    }else{
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"downCell" forIndexPath:indexPath];
        UIButton *gangBtn=(UIButton *)[cell.contentView viewWithTag:30];
        UIButton *qiyeBtn=(UIButton *)[cell.contentView viewWithTag:31];
        _lineView=[cell.contentView viewWithTag:32];
        _downViewa=[cell.contentView viewWithTag:33];
        _downViewb=[cell.contentView viewWithTag:37];
        
        [gangBtn addTarget:self action:@selector(gangBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [qiyeBtn addTarget:self action:@selector(qiyeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _downViewa.frame.size.width, _downViewa.frame.size.height)];
        label.text=_parse.content;
        label.font=[UIFont systemFontOfSize:13];
        label.numberOfLines=0;
        [_downViewa addSubview: label];
        
        UILabel *labelb=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _downViewa.frame.size.width, _downViewa.frame.size.height)];
        labelb.text=[NSString stringWithFormat:@"  %@",_info.title];
        labelb.font=[UIFont systemFontOfSize:15];
        labelb.numberOfLines=0;
        [_downViewb addSubview: labelb];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark----scrollviewDelegate
//滑动结束
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x==_width*5) {
        scrollView.contentOffset=CGPointMake(0, 0);
    }
}
-(void)imageRun
{
    [UIView animateWithDuration:0.3 animations:^{
        _scroll.contentOffset=CGPointMake(_scroll.contentOffset.x+_width, 0);
    }];
    _pageView.currentPage=(_scroll.contentOffset.x/_width);
}
// 拖拽
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x==_width*5) {
        scrollView.contentOffset=CGPointMake(0, 0);
    }
    
    
}
#pragma mark----手势

-(void)gangBtnClick:(UIButton *)sender
{
    NSLog(@"岗位");
    [UIView animateWithDuration:0.3 animations:^{
        _lineView.center=CGPointMake(sender.center.x, _lineView.center.y);
    }];
    
}
-(void)qiyeBtnClick:(UIButton *)sender
{
    NSLog(@"企业");
    [UIView animateWithDuration:0.3 animations:^{
        _lineView.center=CGPointMake(sender.center.x, _lineView.center.y);
    }];
    
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
