//
//  WorkViewController.m
//  ZYMoreWork
//
//  Created by qianfeng on 15/4/30.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "WorkViewController.h"

@interface WorkViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchWork;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation WorkViewController
{
    UIButton *_currentBtn;
    NSMutableArray *_isOpen;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置 每个 分区的开关;
    _isOpen=[NSMutableArray new];
    for (int i=0; i<3; i++) {
        [_isOpen addObject:[NSNumber numberWithBool:NO]];
    }
    
    
}
- (IBAction)btnClick:(UIButton *)sender {
    if (_currentBtn==sender) {
        sender.selected=!sender.selected;
        return;
    }
    _currentBtn.selected=NO;
    _currentBtn=sender;
    sender.selected=YES;
    [UIView animateWithDuration:0.2 animations:^{
        _lineView.center=CGPointMake(sender.center.x, _lineView.center.y);
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (![[_isOpen objectAtIndex:section]boolValue]) {
        return 1;
    }
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

//设置头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
//设置头部的视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSLog(@"走了几次");
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
    label.text=@"四方洁神食府公司";
    label.backgroundColor=[UIColor whiteColor];
    label.textColor=[UIColor blackColor];
    label.font=[UIFont boldSystemFontOfSize:17];
    return label;
}

//设置 foot 上的按钮
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame=CGRectMake(0, 0, self.view.frame.size.width, 35);
    [btn setTitle:@"该企业还有其他2条岗位也在招聘" forState:UIControlStateNormal];
    btn.backgroundColor=[UIColor colorWithWhite:0.961 alpha:1.000];
    btn.tintColor=[UIColor blackColor];
    //btn 的 tag 和事件;
    btn.tag=100+section;
    [btn addTarget:self action:@selector(cellBtn:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
-(void)cellBtn:(UIButton *)sender
{
    //
    BOOL now=[[_isOpen objectAtIndex:sender.tag-100] boolValue];
    [_isOpen replaceObjectAtIndex:sender.tag-100 withObject:[NSNumber numberWithBool:!now]];
    //重载某个分段, NSIndexSet 数字结合,理解成专门存放数字的数组;
    NSLog(@"分段---%ld",sender.tag-100);
    [_myTableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag-100] withRowAnimation:UITableViewRowAnimationFade];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"normalCell"forIndexPath:indexPath];
    return cell;
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
