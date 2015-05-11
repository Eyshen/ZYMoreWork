//
//  StoryViewController.m
//  ZYMoreWork
//
//  Created by qianfeng on 15/5/9.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "StoryViewController.h"
#import "ParallaxHeaderView.h"
#import "StoryViewController.h"
#import "MrEysionViewController.h"
@interface StoryViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end

@implementation StoryViewController
{
    NSArray *_imageArr;
    NSArray *_titleArr;
    NSArray *_infoArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.012 green:0.133 blue:0.242 alpha:1.000]];
    ParallaxHeaderView *headerView=[ParallaxHeaderView parallaxHeaderViewWithCGSize:CGSizeMake(self.view.frame.size.width, 168)];
    headerView.headerTitleLabel.text=@"一切都是为了梦想";
    headerView.headerImage=[UIImage imageNamed:@"dream"];
    [self setData];
    
    _mainTableView.separatorColor=[UIColor clearColor];
    [self.mainTableView setTableHeaderView:headerView];
    
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.mainTableView)
    {
        // pass the current offset of the UITableView so that the ParallaxHeaderView layouts the subViews.
        [(ParallaxHeaderView *)self.mainTableView.tableHeaderView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
    }
}
#pragma mark----tableViewCell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"normalCell" forIndexPath:indexPath];
    [self updateCell:cell indexPath:indexPath];
    return cell;
}
-(void)updateCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    cell.imageView.image=[UIImage imageNamed:_imageArr[indexPath.row]];
    CGFloat width=cell.contentView.frame.size.width;
    UILabel *label=(UILabel *)[cell.contentView viewWithTag:27];
    label.text=_titleArr[indexPath.row];
    label.font=[UIFont systemFontOfSize:15];
    if (indexPath.row==0) {
        UISwitch *sigin=[[UISwitch alloc]initWithFrame:CGRectMake(width-55, 0, 42, 20)];
        sigin.center=CGPointMake(sigin.center.x,cell.contentView.center.y);
        sigin.onTintColor=[UIColor redColor];
        [cell.contentView addSubview:sigin];
    }else if (indexPath.row==4) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(width/3, 10, width*2/3,30)];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=_infoArr[0];
        label.font=[UIFont systemFontOfSize:15];
        [cell.contentView addSubview:label];
    }else if (indexPath.row==5) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(width*2/3, 10, width/3,30)];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=_infoArr[1];
        label.font=[UIFont systemFontOfSize:15];
        [cell.contentView addSubview:label];
    } else{
        UIImageView *iv=[[UIImageView alloc]initWithFrame:CGRectMake(width-25, 19, 12, 12)];
        iv.image=[UIImage imageNamed:@"tonextpage"];
        [cell.contentView addSubview:iv];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==4)
    {
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Set" bundle:nil];
        MrEysionViewController *eysion=[storyboard instantiateViewControllerWithIdentifier:@"MrEysionViewController"];
        [self.navigationController pushViewController:eysion animated:YES];
    }
    if (indexPath.row==5) {
        NSString *telStr=@"电话:400-010-1111";
        UIAlertView *av=[[UIAlertView alloc]initWithTitle:@"客服热线" message:telStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
        [av show];
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex%u",buttonIndex);
    if (buttonIndex==1) {
        NSString *telStr=@"tel://400-010-1111";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr]];
    }
}

-(void)setData
{
_imageArr=@[@"setting1",@"setting2",@"setting3",@"setting4",@"setting5",@"setting6",@"setting7"];
    _titleArr=@[@"仅wifi网络下显示图片",@"意见反馈",@"关于我们",@"官方账号",@"官方主页",@"客服热线"];
    _infoArr=@[@"http://blog.csdn.net/mreshen",@"400-010-1111"];
    
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
