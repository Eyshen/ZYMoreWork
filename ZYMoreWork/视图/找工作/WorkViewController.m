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
#import "MJRefresh.h"

@interface WorkViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate>
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
    
    float _screenWidth;
    float _screenHeight;
    
    NSInteger _searchOpen;
    NSMutableArray *_searchWorkData;
    NSMutableArray *_searchCompanyNameData;
    
    NSInteger _page;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _page=2;
    _cityID=@"4226";
    // Do any additional setup after loading the view.
    //设置 每个 分区的开关;
    _searchWorkData=[NSMutableArray new];
    _searchCompanyNameData=[NSMutableArray new];
    _searchOpen=0;
    
    _screenWidth=self.view.frame.size.width;
    _screenHeight=self.view.frame.size.height;
    _isOpen=[NSMutableArray new];
    _thirdidArr=[NSArray array];
    _diquArr=[NSArray new];
    _quyuStr=[NSString new];
    _kindStr=[NSString new];
    
    _quyuStr=@"0";
    _kindStr=@"0";
  _thirdidArr=@[@"0",@"4227",@"4253",@"4276",@"4298",@"4311",@"4334",@"4357",@"4378"];
    
//    [FindNetWork getFindWorkSuccess:^(FindWorkParse *parse) {
//        _workParse=parse;
//        NSLog(@"下载成功");
//        for (int i=0; i<_workParse.listData.count; i++) {
//            [_isOpen addObject:[NSNumber numberWithBool:NO]];
//        }
//        [_myTableView reloadData];
//    } failure:^(NSString *errorMessage) {
//        NSLog(@"下载失败");
//    }withIDStr:@"0" withGangID:@"0" withSort:@"0"];
    
    
#pragma mark---下拉刷新
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

-(void)beginRefreshing
{
    [self.myTableView.gifHeader beginRefreshing];
}
-(void)loadNewData
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    _page=2;
    [FindNetWork getFindWorkSuccess:^(FindWorkParse *parse) {
        _workParse=parse;
        NSLog(@"下载成功");
        for (int i=0; i<_workParse.listData.count; i++) {
            [_isOpen addObject:[NSNumber numberWithBool:NO]];
        }
        [_myTableView reloadData];
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        [self.myTableView.header endRefreshing];
    } failure:^(NSString *errorMessage) {
        NSLog(@"下载失败");
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        [self.myTableView.header endRefreshing];
    }withIDStr:@"0" withGangID:@"0" withSort:@"0" page:@"1" cityID:_cityID];
    
}
-(void)loadMoreData
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;

    NSString *pageStr=[NSString stringWithFormat:@"%ld",(long)_page];
    [FindNetWork getFindWorkSuccess:^(FindWorkParse *parse) {
        
        [_workParse.listData addObjectsFromArray: parse.listData];
        [_workParse.companyName addObjectsFromArray:parse.companyName];
        NSLog(@"下载成功");
        for (int i=0; i<_workParse.listData.count; i++) {
            [_isOpen addObject:[NSNumber numberWithBool:NO]];
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        [_myTableView reloadData];
        [self.myTableView.footer endRefreshing];
    } failure:^(NSString *errorMessage) {
        NSLog(@"下载失败");
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    }withIDStr:@"0" withGangID:@"0" withSort:@"0" page:pageStr cityID:_cityID];
    _page++;
}



-(void)viewDidLayoutSubviews
{
    if(!_quyuView)
    {
        [self setSelectedView];
    }
    
}

/*
#pragma mark---城市按钮
- (IBAction)cityBtnClick:(UIButton *)sender {
    NSLog(@"aaaa");
    
    if (self.tabBarController.view.frame.origin.x == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.tabBarController.view.frame = CGRectMake(_screenWidth/2, 0, _screenWidth, _screenHeight);
            //点击手势
            UITapGestureRecognizer *tapGR=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGR:)];
//            tapGR.delegate=self;
            [self.tabBarController.view addGestureRecognizer:tapGR];
            //清扫手势
            UISwipeGestureRecognizer *swipeGR=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGR:)];
            [self.tabBarController.view addGestureRecognizer:swipeGR];
            //设置清扫方向
//            swipeGR.delegate=self;
            swipeGR.direction=UISwipeGestureRecognizerDirectionLeft;
            [self.tabBarController.view addGestureRecognizer:swipeGR];
            
            
        } completion:^(BOOL finished) {
        }];
        
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.tabBarController.view.frame = CGRectMake(0, 0, _screenWidth, _screenHeight);
        } completion:^(BOOL finished) {
            
        }];
    }
    
}

-(void)tapGR:(UITapGestureRecognizer *)tapGR
{
    if (tapGR.view.frame.origin.x!=0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.tabBarController.view.frame = CGRectMake(0, 0, _screenWidth, _screenHeight);
        } completion:^(BOOL finished) {
        }];
        [self.tabBarController.view removeGestureRecognizer:tapGR];
    }
    
}
-(void)swipeGR:(UISwipeGestureRecognizer *)swipeGR
{
    if (swipeGR.direction==UISwipeGestureRecognizerDirectionLeft) {
        if (swipeGR.view.frame.origin.x!=0) {
            [UIView animateWithDuration:0.5 animations:^{
                self.tabBarController.view.frame = CGRectMake(0, 0, _screenWidth, _screenHeight);
            } completion:^(BOOL finished) {
            }];
            
            [self.tabBarController.view removeGestureRecognizer:swipeGR];
        }
    }
}
 
 */
#pragma mark---提示
-(void)setAlterView
{
    UIAlertView *av=[[UIAlertView alloc]initWithTitle:@"城市信息" message:@"对不起,目前还没有开通这个城市的信息" delegate: self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    
    [av show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        UIButton *btn=(UIButton *)[self.view viewWithTag:77];
        [btn setTitle:@"青岛" forState: UIControlStateNormal];
    }
}

#pragma mark--搜索按钮事件
- (IBAction)searchBtnClick:(UIButton *)sender {
    [_searchWork resignFirstResponder];
    if (_searchWork.text.length==0) {
        NSLog(@"搜索");
        
        _searchOpen=0;
        [_myTableView reloadData];
    }else{
        NSLog(@"%@",_searchWork.text);
        [_searchCompanyNameData removeAllObjects];
        [_searchWorkData removeAllObjects];
        for (int i=0; i<_workParse.companyName.count; i++) {
            
            if ([_workParse.companyName[i] rangeOfString:_searchWork.text].length!=0) {
                NSLog(@"%@",_workParse.companyName[i]);
//                NSLog(@"长度%u",[_workParse.companyName[i] rangeOfString:_searchWork.text].length);
                [_searchWorkData addObject:_workParse.listData[i]];
                [_searchCompanyNameData addObject:_workParse.companyName[i]];
            }
        }
        _searchOpen=1;
        [_myTableView reloadData];
    }
    
}
//收起键盘
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [_searchWork resignFirstResponder];
}
#pragma mark---公司详情 和 报名按钮
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.view endEditing:YES];
    if ([segue.identifier isEqualToString:@"XiangQingViewController"]) {
        XiangQingViewController *xiangqingVC=segue.destinationViewController;
        NSIndexPath *indexPath=[_myTableView indexPathForCell:sender];
        
        NSArray *arr=[NSArray new];
        if (_searchOpen==1) {
            arr=_searchWorkData[indexPath.section];
        }else{
            arr=_workParse.listData[indexPath.section];
        }
        FindWorkInfo *info=arr[indexPath.row];
        xiangqingVC.zhaopinid=info.myid;
//        NSLog(@"走几次");
        
    }else if([segue.identifier isEqualToString:@"BaomingViewController"]){
        BaomingViewController *baomingVC=segue.destinationViewController;
        UIButton *btn=(UIButton *)sender;
//        NSLog(@"--------%u",btn.tag);
        if (_searchOpen==1) {
            baomingVC.companyName=_searchCompanyNameData[btn.tag-1000];
        }else{
            baomingVC.companyName=_workParse.companyName[btn.tag-1000];
        }
        
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
    
    if (_searchOpen==1) {
        return _searchWorkData.count;
    }
    return _workParse.listData.count;
}
//section 的
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (![[_isOpen objectAtIndex:section]boolValue]) {
        return 1;
    }
    if (_searchOpen==1) {
        NSArray *arr=_searchWorkData[section];
//        NSLog(@"搜索的每个分区多少行%u",arr.count);
        return arr.count;
    }
    
    NSArray *arr=_workParse.listData[section];
//    NSLog(@"每个分区多少行%u",arr.count);
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
    
    NSArray *arr=[NSArray new];
    if (_searchOpen==1) {
        arr=_searchWorkData[section];
        
    }else{
        arr=_workParse.listData[section];
    }
    if (arr.count==1) {
        return 5;
    }
    return 40;
}
//设置头部的视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
    if (_searchOpen==1) {
        label.text=_searchCompanyNameData[section];
    }else{
        label.text=_workParse.companyName[section];
    }
    
    label.backgroundColor=[UIColor whiteColor];
    label.textColor=[UIColor blackColor];
    label.font=[UIFont boldSystemFontOfSize:17];
    return label;
}
//设置 foot 上的按钮
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    
    
    NSArray *arr=[NSArray new];
    if (_searchOpen==1) {
        arr=_searchWorkData[section];
    }else{
        arr=_workParse.listData[section];
    }
    
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
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"normalCell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"normalCell"];
    }
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
    NSArray *arr=[NSArray new];
    if (_searchOpen==1) {
        arr=_searchWorkData[indexPath.section];
    }else{
        arr=_workParse.listData[indexPath.section];
    }
    
    FindWorkInfo *info=arr[indexPath.row];
    
    [logoIV setImageWithURL:[NSURL URLWithString:info.logo]];
    titleLabel.text=[NSString stringWithFormat:@" %@",info.title];
    citynameLabel.text=[NSString stringWithFormat:@"%@-%@",info.thirdname,info.cityname];
    gongziLabel.text=[NSString stringWithFormat:@"  ¥%@-%@",info.gongzi1,info.gongzi2];
    
    baomingBtn.tag=1000+indexPath.section;
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
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    [FindNetWork getFindWorkSuccess:^(FindWorkParse *parse) {
        _workParse=parse;
        NSLog(@"下载成功");
        for (int i=0; i<_workParse.listData.count; i++) {
            [_isOpen addObject:[NSNumber numberWithBool:NO]];
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        [_myTableView reloadData];
    } failure:^(NSString *errorMessage) {
        NSLog(@"下载失败");
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    }withIDStr:_thirdidArr[sender.tag-200] withGangID:@"0" withSort:@"0" page:@"1" cityID:_cityID];
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
        gangweiStr=[NSString stringWithFormat:@"%ld",8430+sender.tag-300];
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    [FindNetWork getFindWorkSuccess:^(FindWorkParse *parse) {
        NSLog(@"gang下载成功");
        _workParse=parse;
        for (int i=0; i<_workParse.listData.count; i++) {
            [_isOpen addObject:[NSNumber numberWithBool:NO]];
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        [_myTableView reloadData];
    } failure:^(NSString *errorMessage) {
        NSLog(@"下载失败%@",errorMessage);
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    } withIDStr:_quyuStr withGangID:gangweiStr withSort:@"0" page:@"1" cityID:_cityID];
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
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    NSString *sort=[NSString stringWithFormat:@"%ld",sender.tag-400+1];
    [FindNetWork getFindWorkSuccess:^(FindWorkParse *parse) {
        NSLog(@"paixun下载成功");
        _workParse=parse;
        for (int i=0; i<_workParse.listData.count; i++) {
            [_isOpen addObject:[NSNumber numberWithBool:NO]];
        }
        [_myTableView reloadData];
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    } failure:^(NSString *errorMessage) {
        NSLog(@"下载失败%@",errorMessage);
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    } withIDStr:_quyuStr withGangID:_kindStr withSort:sort page:@"1" cityID:_cityID];
    
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
