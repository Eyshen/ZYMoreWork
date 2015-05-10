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
@interface ZiXunViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;


@end

@implementation ZiXunViewController
{
    ZiXunParse *_parse;
    NSMutableArray *_strArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateData];
    [FindNetWork getNewsSuccess:^(ZiXunParse *parse) {
        _parse=parse;
        
        [_myTableView reloadData];
    } failure:^(NSString *errorMessage) {
        
        NSLog(@"下载失败!!%@",errorMessage);
    } urlStr:_strArr[0]];
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
    [iv setImageWithURL:[NSURL URLWithString:info.PicUrl]];
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
