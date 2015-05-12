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
    
    //图片编码
    NSArray *_imageArr;
    
    NSString *_imageUrlStr;
    //数据
    NSArray *_cellDataArr;
    
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
    sleep(1);
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    [self.myTableView.header endRefreshing];
    [_myTableView reloadData];
}

-(void)loadMoreData
{
    _page=2;
    if (_page==2) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
        
        sleep(1);
        
        [_myTableView reloadData];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    }
    [self.myTableView.footer endRefreshing];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_page==1) {
        return 20;
    }else{
        return 35;
    }
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
    
    
//    [iv setImageWithURL:[NSURL URLWithString:info.PicUrl]];
    NSString *urlStr=[_imageUrlStr stringByAppendingString:_imageArr[indexPath.row]];
    
    [iv setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"fendou"]];
    
    label.text=_cellDataArr[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Mendian" bundle:nil];
    
    NewsViewController *newsVC=[storyboard instantiateViewControllerWithIdentifier:@"NewsViewController"];
    
    
    newsVC.myID=_imageArr[indexPath.row];
    [self.navigationController pushViewController:newsVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateData
{
    _strArr =[NSMutableArray new];
    NSString *urlStra=@"http://mi.zhaopin.com/iPhone/info/Infolist?channel=apple&d=45389FE5E07070A195009971B5A2544D&key=135486907262855&pageIndex=1&pageSize=20&v=4.3&t=1431420178&e=b66e086c8abdfafe6a0970738a0dc3bd";
    NSString *urlStrb=@"http://mi.zhaopin.com/iPhone/info/Infolist?channel=apple&d=45389FE5E07070A195009971B5A2544D&key=135486907262855&pageIndex=2&pageSize=20&v=4.3&t=1431420293&e=4698b909b3d5b5938a75e64f5ae86fac";
    [_strArr addObject:urlStra];
    [_strArr addObject:urlStrb];
    
    _imageArr=@[@"307",@"308",@"346",@"281",@"334",@"221",@"222",@"186",@"185",@"182",@"184",@"180",@"181",@"179",@"178",@"64",@"160",@"164",@"72",@"71",@"69",@"70",@"41",@"40",@"66",@"39",@"63",@"67",@"68",@"27",@"38",@"26",@"37",@"42",@"45"];
    
    _imageUrlStr=@"http://mi.zhaopin.com/wap/info/DownloadImage?infoId=";
    
    _cellDataArr=@[@"如何在面试中回答“你最大的缺点是什么”？",@"如何进行职业定位？",@"如果兔子都在拼命奔跑，是什么给了作为乌龟的你前进的动力？",@"上级永远没有错，是你错了！",@"正式步入社会，这些为人处世的经验你需要学到",@"小公司不见得比大公司更简单愉快",@"怎么写简历自我评价合适",@"职场新人，你为何感到不安？",@"一篇很透彻的关于跳槽的文章",@"职场上如何营销自我的10个金点子",@"你需要问HR什么问题",@"如何写一份让HR眼前一亮的简历",@"过来人告诉你写邮件的九点经验",@"写邮件的小技巧：倒金字塔叙事",@"晋升的为什么是那个最“傻”的前台？",@"出彩简历及面霸的秘密武器",@"销售岗位面试：如何把产品卖给考官？",@"面试：如何从紧张派变为实力派",@"其实，多数人的英文简历都惨不忍睹",@"“屌丝”怎样写出丰富有内涵的简历",@"群面如群殴，如何杀出一条血路？",@"面试中你必须知道的语言陷阱",@"简历怎么写，才能证明你是好销售？",@"判断好公司的6条标准",@"做销售，哪款公司适合你？",@"来吧，挑个最挣钱的行业！",@"怎样在面试时谈个好身价",@"面试时如何回答“你最大的缺点是什么",@"在面试中，最优的展示自我：“自我介绍的攻略",@"面霸是这样炼成的",@"职场“老大难”如何跳槽？",@"过来人吐槽：兴趣≠工作",@"细思极恐的职场八卦",@"走出校门干点儿啥？",@"职业无规划，人生无发展"];
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
