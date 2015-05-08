//
//  WorkViewController.m
//  ZYMoreWork
//
//  Created by qianfeng on 15/4/30.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "WorkViewController.h"
#import "XiangQingViewController.h"
#import "BaomingViewController.h"
@interface WorkViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchWork;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIButton *quyuBtn;

@end

@implementation WorkViewController
{
    UIButton *_currentBtn;
    NSMutableArray *_isOpen;
    FindWorkParse *_workParse;
    NSArray *_thirdidArr;
    UIView *_quyuView;
    UIView *_gangweiView;
    UIView *_paixuView;
    NSArray *_diquArr;
    
    NSString *_quyuStr;
    NSString *_kindStr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置 每个 分区的开关;
    _isOpen=[NSMutableArray new];
    _thirdidArr=[NSArray array];
    _diquArr=[NSArray new];
    _quyuStr=[NSString new];
    _kindStr=[NSString new];
    _quyuStr=@"0";
    _kindStr=@"0";
  _thirdidArr=@[@"0",@"4227",@"4253",@"4276",@"4298",@"4311",@"4334",@"4357",@"4378"];
    [FindNetWork getFindWorkSuccess:^(FindWorkParse *parse) {
        _workParse=parse;
        NSLog(@"下载成功");
        for (int i=0; i<_workParse.listData.count; i++) {
            [_isOpen addObject:[NSNumber numberWithBool:NO]];
        }
        [_myTableView reloadData];
    } failure:^(NSString *errorMessage) {
        NSLog(@"下载失败");
    }withIDStr:@"0" withGangID:@"0" withSort:@"0"];
    
}
-(void)viewDidLayoutSubviews
{
    if(!_quyuView)
    {
        [self setSelectedView];
    }
    
}
//搜索按钮事件
- (IBAction)searchBtnClick:(UIButton *)sender {
    [_searchWork resignFirstResponder];
}
//收起键盘
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [_searchWork resignFirstResponder];
}
#pragma mark---公司详情 和 报名按钮
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"XiangQingViewController"]) {
        XiangQingViewController *xiangqingVC=segue.destinationViewController;
        NSIndexPath *indexPath=[_myTableView indexPathForCell:sender];
        NSArray *arr=_workParse.listData[indexPath.section];
        FindWorkInfo *info=arr[indexPath.row];
        xiangqingVC.zhaopinid=info.myid;
//        NSLog(@"走几次");
    }else if([segue.identifier isEqualToString:@"BaomingViewController"]){
        BaomingViewController *baomingVC=segue.destinationViewController;
        
    }
}



//三个按钮的点击事件
- (IBAction)btnClick:(UIButton *)sender {
    if (_currentBtn==sender) {
        sender.selected=!sender.selected;
        
    }else{
        _currentBtn.selected=NO;
        _currentBtn=sender;
        sender.selected=YES;
        [UIView animateWithDuration:0.2 animations:^{
            _lineView.center=CGPointMake(sender.center.x, _lineView.center.y);
        }];
    }
    
    switch (sender.tag) {
        case 30:
        {
            NSLog(@"aa");
            if (_quyuView.hidden) {
                _quyuView.hidden=NO;
                _gangweiView.hidden=YES;
                _paixuView.hidden=YES;
            }else{
                _quyuView.hidden=YES;
            }
        }
            break;
        case 31:
        {
            NSLog(@"bb");
            if (_gangweiView.hidden) {
                _gangweiView.hidden=NO;
                _quyuView.hidden=YES;
               
                _paixuView.hidden=YES;
            }else{
                _gangweiView.hidden=YES;
            }
        }
            break;
        case 32:
        {
            NSLog(@"cc");
            if (_paixuView.hidden) {
                _paixuView.hidden=NO;
                _quyuView.hidden=YES;
                _gangweiView.hidden=YES;
                
            }else{
                _paixuView.hidden=YES;
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma 设置 window
-(void)setWindow
{
    
}
#pragma mark---tableViewDelegate,tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _workParse.listData.count;
}
//section 的
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (![[_isOpen objectAtIndex:section]boolValue]) {
        return 1;
    }
    NSArray *arr=_workParse.listData[section];
    NSLog(@"每个分区多少行%lu",arr.count);
    return arr.count;
}
//每个cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

//设置头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
//设置脚部高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSArray *arr=_workParse.listData[section];
    if (arr.count==1) {
        return 5;
    }
    return 40;
}
//设置头部的视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
    label.text=_workParse.companyName[section];
    label.backgroundColor=[UIColor whiteColor];
    label.textColor=[UIColor blackColor];
    label.font=[UIFont boldSystemFontOfSize:17];
    return label;
}
//设置 foot 上的按钮
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSArray *arr=_workParse.listData[section];
    UIView *mainView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    mainView.backgroundColor=[UIColor colorWithRed:0.922 green:0.922 blue:0.945 alpha:1.000];
    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 5)];
    
    if (arr.count==1) {
        return footView;
    }else if ([[_isOpen objectAtIndex:section]boolValue]) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame=CGRectMake(0, 0, self.view.frame.size.width, 35);
        NSString *titleStr=[NSString stringWithFormat:@"向上收起"];
        [btn setTitle:titleStr forState:UIControlStateNormal];
        
        btn.backgroundColor=[UIColor colorWithWhite:0.961 alpha:1.000];
        btn.tintColor=[UIColor blackColor];
        btn.titleLabel.font=[UIFont systemFontOfSize:13];
        //btn 的 tag 和事件;
        btn.tag=100+section;
        [btn addTarget:self action:@selector(cellBtn:) forControlEvents:UIControlEventTouchUpInside];
        [mainView addSubview:btn];
        return mainView;
    }
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame=CGRectMake(0, 0, self.view.frame.size.width, 35);
    
    
    
//    [btn setTitle:str forState:UIControlStateNormal];
    
    btn.backgroundColor=[UIColor colorWithWhite:0.961 alpha:1.000];
    btn.tintColor=[UIColor blackColor];
//    btn.titleLabel.font=[UIFont systemFontOfSize:13];
    //btn 的 tag 和事件;
    btn.tag=100+section;
    [btn addTarget:self action:@selector(cellBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSString *titleStr=[NSString stringWithFormat:@"该企业还有其他%lu条岗位也在招聘",arr.count-1];
    NSString *numStr=[NSString stringWithFormat:@"%lu条",arr.count-1];
    NSMutableAttributedString *attribut=[[NSMutableAttributedString alloc]initWithString:titleStr];
    NSDictionary *attributType=@{NSForegroundColorAttributeName:[UIColor redColor]};
    NSRange range=[titleStr rangeOfString:numStr];
    [attribut setAttributes:attributType range:range];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
    label.attributedText=attribut;
    label.font=[UIFont systemFontOfSize:14];
    label.textAlignment=NSTextAlignmentCenter;
    [mainView addSubview:btn];
    [mainView addSubview:label];
    
    return mainView;
}

-(void)cellBtn:(UIButton *)sender
{
    [sender setTitle:@"向上收起" forState:UIControlStateNormal];
    BOOL now=[[_isOpen objectAtIndex:sender.tag-100] boolValue];
    [_isOpen replaceObjectAtIndex:sender.tag-100 withObject:[NSNumber numberWithBool:!now]];
    //重载某个分段, NSIndexSet 数字结合,理解成专门存放数字的数组;
    [_myTableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag-100] withRowAnimation:UITableViewRowAnimationFade];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"normalCell"forIndexPath:indexPath];
    [self updateTableViewCell:cell andIndexPath:indexPath];
    return cell;
}

-(void)updateTableViewCell:(UITableViewCell *)cell andIndexPath:(NSIndexPath *)indexPath
{
    UIImageView *logoIV=(UIImageView *)[cell.contentView viewWithTag:20];
    UILabel *titleLabel=(UILabel *)[cell.contentView viewWithTag:21];
    UILabel *citynameLabel=(UILabel *)[cell.contentView viewWithTag:22];
    UILabel *gongziLabel=(UILabel *)[cell.contentView viewWithTag:23];
    UIButton *baomingBtn=(UIButton *)[cell.contentView viewWithTag:25];
    UILabel *sexageLabel=(UILabel *)[cell.contentView viewWithTag:24];
    NSArray *arr=_workParse.listData[indexPath.section];
    FindWorkInfo *info=arr[indexPath.row];
    
    [logoIV setImageWithURL:[NSURL URLWithString:info.logo]];
    titleLabel.text=[NSString stringWithFormat:@" %@",info.title];
    citynameLabel.text=[NSString stringWithFormat:@"%@-%@",info.thirdname,info.cityname];
    gongziLabel.text=[NSString stringWithFormat:@"  ¥%@-%@",info.gongzi1,info.gongzi2];
    baomingBtn.layer.masksToBounds=YES;
    baomingBtn.layer.cornerRadius=15;
    baomingBtn.layer.borderWidth=1;
    baomingBtn.layer.borderColor=[[UIColor grayColor]CGColor];
    sexageLabel.text=[NSString stringWithFormat:@" %@ %@-%@岁",info.sex,info.age1,info.age2];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置三个按钮的功能
-(void)setSelectedView
{
    _quyuView=[[UIView alloc]initWithFrame:_myTableView.frame];
    _gangweiView=[[UIView alloc]initWithFrame:_myTableView.frame];
    _paixuView=[[UIView alloc]initWithFrame:_myTableView.frame];
    _quyuView.backgroundColor=[UIColor colorWithRed:0.949 green:0.953 blue:1.000 alpha:1.000];
    _gangweiView.backgroundColor=[UIColor colorWithRed:0.949 green:0.953 blue:1.000 alpha:1.000];
    _paixuView.backgroundColor=[UIColor colorWithRed:0.949 green:0.953 blue:1.000 alpha:1.000];
    [self.view addSubview:_quyuView];
    [self.view addSubview:_gangweiView];
    [self.view addSubview:_paixuView];
    _quyuView.hidden=YES;
    _gangweiView.hidden=YES;
    _paixuView.hidden=YES;
    
    UIScrollView *ascroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _quyuView.frame.size.width, _quyuView.frame.size.height-32)];
    UIScrollView *bscroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _quyuView.frame.size.width, _quyuView.frame.size.height-32)];
    UIScrollView *cscroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _quyuView.frame.size.width, _quyuView.frame.size.height-32)];
    
    ascroll.contentSize=CGSizeMake(_paixuView.frame.size.width, _paixuView.frame.size.height+1);
    ascroll.backgroundColor=[UIColor whiteColor];
    bscroll.contentSize=CGSizeMake(_paixuView.frame.size.width, _paixuView.frame.size.height+1);
    bscroll.backgroundColor=[UIColor whiteColor];
    cscroll.contentSize=CGSizeMake(_paixuView.frame.size.width, _paixuView.frame.size.height+1);
    cscroll.backgroundColor=[UIColor whiteColor];
    
    UIView *asView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ascroll.frame.size.width, ascroll.frame.size.height+1)];
    asView.backgroundColor=[UIColor colorWithRed:0.960 green:0.963 blue:1.000 alpha:1.000];
    ascroll.contentSize=asView.frame.size;
    _diquArr=@[@"  所有",@"  市南",@"  市北",@"  四方",@"  黄岛",@"  崂山",@"  李沧",@"  城阳",@"  青岛周边"];
    for (int i=0; i<9; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.tag=200+i;
        btn.frame=CGRectMake(0,i*32, asView.frame.size.width, 30);
        [btn setTitle:_diquArr[i] forState:UIControlStateNormal];
        btn.backgroundColor=[UIColor whiteColor];
        btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        btn.tintColor=[UIColor colorWithWhite:0.267 alpha:1.000];
        btn.titleLabel.font=[UIFont boldSystemFontOfSize:13];
        [btn addTarget:self action:@selector(quyuBtn:) forControlEvents:UIControlEventTouchUpInside];
        [asView addSubview:btn];
    }
    [ascroll addSubview:asView];
    
    
    UIView *bsView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ascroll.frame.size.width,28*32)];
    bsView.backgroundColor=[UIColor colorWithRed:0.960 green:0.963 blue:1.000 alpha:1.000];
    bscroll.contentSize=bsView.frame.size;
    NSArray *gangArr=@[@"  所有",@"  普工",@"  常用技工",@"  机械/机床",@"  食品/饮料",@"  橡胶/塑料",@"  服装/纺织/印染",@"  皮革/鞋帽/箱包",@"  陶瓷/玻璃",@"  太阳能/光伏",@"  医药/保健品",@"  造纸/印刷/包装",@"  木器/家具",@"  建筑/工程",@"  质检/测试/安全",@"  主管/班组长",@"  厨师/餐饮",@"  服务员/收银员",@"  零售/导购",@"  快递/物流",@"  汽修/汽配",@"  美容/美发/保健",@"  家政/护理/物业",@"  司机",@"  销售/采购",@"  客服/行政",@"  农林牧渔类",@"  其他"];
    for (int i=0; i<28; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.tag=300+i;
        btn.frame=CGRectMake(0,i*32, asView.frame.size.width, 30);
        [btn setTitle:gangArr[i] forState:UIControlStateNormal];
        btn.backgroundColor=[UIColor whiteColor];
        btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        btn.tintColor=[UIColor colorWithWhite:0.267 alpha:1.000];
        btn.titleLabel.font=[UIFont boldSystemFontOfSize:13];
        [btn addTarget:self action:@selector(gangBtn:) forControlEvents:UIControlEventTouchUpInside];
        [bsView addSubview:btn];
    }
    [bscroll addSubview:bsView];
    
    
    UIView *csView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ascroll.frame.size.width, ascroll.frame.size.height+1)];
    csView.backgroundColor=[UIColor colorWithRed:0.960 green:0.963 blue:1.000 alpha:1.000];
    cscroll.contentSize=asView.frame.size;
    NSArray *paixunArr=@[@"  所有",@"  按时间排序",@"  按工资排序"];
    for (int i=0; i<3; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.tag=400+i;
        btn.frame=CGRectMake(0,i*32, asView.frame.size.width, 30);
        [btn setTitle:paixunArr[i] forState:UIControlStateNormal];
        btn.backgroundColor=[UIColor whiteColor];
        btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        btn.tintColor=[UIColor colorWithWhite:0.267 alpha:1.000];
        btn.titleLabel.font=[UIFont boldSystemFontOfSize:13];
        [btn addTarget:self action:@selector(paixuBtn:) forControlEvents:UIControlEventTouchUpInside];
        [csView addSubview:btn];
    }
    [cscroll addSubview:csView];
    
    
    //设置
    [_quyuView addSubview:ascroll];
    [_gangweiView addSubview:bscroll];
    [_paixuView addSubview:cscroll];
}
-(void)quyuBtn:(UIButton *)sender
{
    for (int i=0; i<9; i++) {
        UIButton *btn=(UIButton *)[self.view viewWithTag:200+i];
        btn.backgroundColor=[UIColor whiteColor];
    }
    sender.backgroundColor=[UIColor colorWithRed:0.949 green:0.953 blue:1.000 alpha:1.000];
    
    
    [FindNetWork getFindWorkSuccess:^(FindWorkParse *parse) {
        _workParse=parse;
        NSLog(@"下载成功");
        for (int i=0; i<_workParse.listData.count; i++) {
            [_isOpen addObject:[NSNumber numberWithBool:NO]];
        }
        [_myTableView reloadData];
    } failure:^(NSString *errorMessage) {
        NSLog(@"下载失败");
    }withIDStr:_thirdidArr[sender.tag-200] withGangID:@"0" withSort:@"0"];
    _quyuStr=_thirdidArr[sender.tag-200];
    
    if (sender.tag==200) {
        [_quyuBtn setTitle:@"区域" forState: UIControlStateNormal];
    }else{
        [_quyuBtn setTitle:_diquArr[sender.tag-200] forState:UIControlStateNormal];
    }
    _quyuView.hidden=YES;
    
}

-(void)gangBtn:(UIButton *)sender
{
    for (int i=0; i<28; i++) {
        UIButton *btn=(UIButton *)[self.view viewWithTag:300+i];
        btn.backgroundColor=[UIColor whiteColor];
    }
    sender.backgroundColor=[UIColor colorWithRed:0.949 green:0.953 blue:1.000 alpha:1.000];
    _gangweiView.hidden=YES;
    NSString *gangweiStr=[NSString new];
    if (sender.tag==300) {
        gangweiStr=@"0";
    }else{
        gangweiStr=[NSString stringWithFormat:@"%lu",8430+sender.tag-300];
    }
    
    [FindNetWork getFindWorkSuccess:^(FindWorkParse *parse) {
        NSLog(@"gang下载成功");
        _workParse=parse;
        for (int i=0; i<_workParse.listData.count; i++) {
            [_isOpen addObject:[NSNumber numberWithBool:NO]];
        }
        [_myTableView reloadData];
    } failure:^(NSString *errorMessage) {
        NSLog(@"下载失败%@",errorMessage);
    } withIDStr:_quyuStr withGangID:gangweiStr withSort:@"0"];
    _kindStr=gangweiStr;
    NSLog(@"地区%@",gangweiStr);
}
-(void)paixuBtn:(UIButton *)sender
{
    for (int i=0; i<3; i++) {
        UIButton *btn=(UIButton *)[self.view viewWithTag:400+i];
        btn.backgroundColor=[UIColor whiteColor];
    }
    sender.backgroundColor=[UIColor colorWithRed:0.949 green:0.953 blue:1.000 alpha:1.000];
    _paixuView.hidden=YES;
    
    NSString *sort=[NSString stringWithFormat:@"%lu",sender.tag-400+1];
    [FindNetWork getFindWorkSuccess:^(FindWorkParse *parse) {
        NSLog(@"paixun下载成功");
        _workParse=parse;
        for (int i=0; i<_workParse.listData.count; i++) {
            [_isOpen addObject:[NSNumber numberWithBool:NO]];
        }
        [_myTableView reloadData];
    } failure:^(NSString *errorMessage) {
        NSLog(@"下载失败%@",errorMessage);
    } withIDStr:_quyuStr withGangID:_kindStr withSort:sort];
    
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
