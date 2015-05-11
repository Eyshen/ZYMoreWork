//
//  ZiXunViewController.m
//  ZYMoreWork
//
//  Created by qianfeng on 15/5/10.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "ZiXunViewController.h"
#import "FindNetWork.h"
#import "NewsViewController.h"
#import "MJRefresh.h"
@interface ZiXunViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;


@end

@implementation ZiXunViewController
{
    ZiXunParse *_parse;
    NSMutableArray *_strArr;
    NSInteger _page;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _page=2;
    // Do any additional setup after loading the view.
    [self updateData];
    
    
    [self.myTableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [self.myTableView.gifHeader setImages:idleImages forState:MJRefreshHeaderStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self.myTableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self.myTableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStateRefreshing];
    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    
    // 马上进入刷新状态
    [self.myTableView.gifHeader beginRefreshing];
    
    // 此时self.tableView.header == self.tableView.gifHeader
    
    
    
    
#pragma mark--上拉加载
    // 添加动画图片的上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    [self.myTableView addGifFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 设置正在刷新状态的动画图片
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    self.myTableView.gifFooter.refreshingImages = refreshingImages;
    
    // 此时self.tableView.footer == self.tableView.gifFooter
}
-(void)loadNewData
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    _page=1;
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    [FindNetWork getNewsSuccess:^(ZiXunParse *parse) {
        _parse=parse;
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        [self.myTableView.header endRefreshing];
        [_myTableView reloadData];
    } failure:^(NSString *errorMessage) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        
        NSLog(@"下载失败!!%@",errorMessage);
    } urlStr:_strArr[0]];
}

-(void)loadMoreData
{
    _page++;
    if (_page==2) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
        [FindNetWork getNewsSuccess:^(ZiXunParse *parse) {
            [_parse.infoData addObjectsFromArray: parse.infoData];
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            
            [self.myTableView.header endRefreshing];
            [_myTableView reloadData];
        } failure:^(NSString *errorMessage) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            
            NSLog(@"下载失败!!%@",errorMessage);
        } urlStr:_strArr[1]];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _parse.infoData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 59;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"normalCell" forIndexPath:indexPath];
    
    UIImageView *iv=(UIImageView *)[cell.contentView viewWithTag:27];
    UILabel *label=(UILabel *)[cell.contentView viewWithTag:28];
    ZiXunInfo *info=_parse.infoData[indexPath.row];
    
//    [iv setImageWithURL:[NSURL URLWithString:info.PicUrl]];
    
    [iv setImageWithURL:[NSURL URLWithString:info.PicUrl] placeholderImage:[UIImage imageNamed:@"fendou"]];
    
    label.text=info.Title;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Mendian" bundle:nil];
    NewsViewController *newsVC=[storyboard instantiateViewControllerWithIdentifier:@"NewsViewController"];
    ZiXunInfo *info=_parse.infoData[indexPath.row];
    newsVC.myID=info.myId;
    [self.navigationController pushViewController:newsVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateData
{
    _strArr =[NSMutableArray new];
    NSString *urlStra=@"http://mi.zhaopin.com/iPhone/info/Infolist?d=45389FE5E07070A195009971B5A2544D&pageSize=20&key=135486907262855&channel=apple&pageIndex=1&v=4.1&t=1431240605&e=646ec20311898ccbf34d7cee524c54d9";
    NSString *urlStrb=@"http://mi.zhaopin.com/iPhone/info/Infolist?d=45389FE5E07070A195009971B5A2544D&pageSize=20&key=135486907262855&channel=apple&pageIndex=2&v=4.1&t=1431244455&e=8d0bf296f97cd7e783101d0cd16f6481";
    [_strArr addObject:urlStra];
    [_strArr addObject:urlStrb];
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
