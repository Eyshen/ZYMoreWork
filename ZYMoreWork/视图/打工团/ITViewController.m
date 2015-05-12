//
//  ITViewController.m
//  ZYMoreWork
//
//  Created by qianfeng on 15/5/7.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "ITViewController.h"
#import "FindNetWork.h"
#import "Person.h"
#import <MDCSwipeToChoose/MDCSwipeDirection.h>
#import "CompanyViewController.h"

#import "MBProgressHUD.h"

//按钮
#import "DeformationButton.h"

static const CGFloat ChoosePersonButtonHorizontalPadding=80.f;
static const CGFloat ChoosePersonButtonVerticalPadding=20.f;

@interface ITViewController ()<MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *people;
@property(nonatomic,strong)NSMutableArray *jobArr;
@end

@implementation ITViewController
{
    IosjobParse *_parse;
    NSInteger _page;
    //HUD（Head-Up Display，意思是抬头显示的意思）
    MBProgressHUD *HUD;
    
    //按钮
    DeformationButton *deformationBtn;
    //关注的公司
    NSMutableArray *_companyData;
    
    CGFloat _width;
    CGFloat _height;
    
    
    UIView *_bgView;
    UITableView *_myTableView;
}
//按钮颜色 设置

- (UIColor *)getColor:(NSString *)hexColor
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
    
}



#pragma mark----UIViewController Overrides(重写)

- (void)viewDidLoad {
    [super viewDidLoad];
    _companyData=[NSMutableArray new];
//    _people =[[self defaultPeople] mutableCopy];
    
    _width=self.view.frame.size.width;
    _height=self.view.frame.size.height;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.077 green:0.262 blue:0.378 alpha:1.000]];
    
    
    
    
    // Do any additional setup after loading the view.
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.view addSubview:HUD];
    
    // Set determinate mode
    HUD.mode = MBProgressHUDModeAnnularDeterminate;
    
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    
    
    _page=2;
    [HUD show:YES];
    [FindNetWork getIosjobSuccess:^(IosjobParse *parse) {
        _parse=parse;
        NSLog(@"it下载成功%lu",(unsigned long)[_parse.data count]);
        [HUD removeFromSuperview];
        [self creatCarViewAndButton];
    } failure:^(NSString *errorMessage) {
        NSLog(@"失败%@",errorMessage);
        [HUD removeFromSuperview];
    } pageSize:@"1"];
    
    
#pragma mark----按钮
    deformationBtn = [[DeformationButton alloc]initWithFrame:CGRectMake(20, 10, 90, 36)];
    deformationBtn.contentColor = [self getColor:@"52c332"];
    deformationBtn.progressColor = [UIColor whiteColor];
    [self.view addSubview:deformationBtn];
    
    [deformationBtn.forDisplayButton setTitle:@"看过的公司" forState:UIControlStateNormal];
    
    [deformationBtn.forDisplayButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [deformationBtn.forDisplayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deformationBtn.forDisplayButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
    
    [deformationBtn.forDisplayButton setImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
    UIImage *bgImage = [UIImage imageNamed:@"button_bg"];
    [deformationBtn.forDisplayButton setBackgroundImage:[bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
    
    [deformationBtn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

#pragma mark----小表格
- (void)btnEvent:(DeformationButton *)sender{
    sender.selected=!sender.selected;
    NSLog(@"btnEvent-----%d",sender.selected);
    
    if (_bgView==nil) {
        
        
        _bgView=[[UIView alloc]initWithFrame:CGRectMake(20, 60+_height, _width-40, 7*53)];
        _bgView.backgroundColor=[UIColor colorWithRed:0.929 green:0.949 blue:0.976 alpha:1.000];
        _myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,_width-40, 7*53)];
        _myTableView.delegate=self;
        _myTableView.dataSource=self;
        
        //    _bgView.backgroundColor=[UIColor yellowColor];
        [_bgView addSubview:_myTableView];
        
        [self.view addSubview:_bgView];
    }
    if (sender.selected==1) {
        [_myTableView reloadData];
        if (_companyData.count==0) {
            UIAlertView *av=[[UIAlertView alloc]initWithTitle:@"提示" message:@"你还没有查看哪家公司的详情" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            [av show];
        }else{
            CGRect frame=_bgView.frame;
            frame.origin.y-=_height+15;
            CGRect framea=frame;
            framea.origin.y+=15;
            [UIView animateWithDuration:1 animations:^{
                _bgView.frame=frame;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.8 animations:^{
                    _bgView.frame=framea;
                }];
            }];
            
        }
    }else
    {
        CGRect frame=_bgView.frame;
        frame.origin.y+=_height;
        [UIView animateWithDuration:0.5 animations:^{
            _bgView.frame=frame;
        }];
    }
    
}
#pragma mark----小表格lifecyle
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _companyData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifiter=@"cellID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifiter];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifiter];
        
        UIImageView *iv=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
        iv.tag=70;
        
        UILabel *companyLabel=[[UILabel alloc]initWithFrame:CGRectMake(55, 0,cell.contentView.frame.size.width-55, 30)];
        companyLabel.font=[UIFont systemFontOfSize:15];
        companyLabel.tag=71;
        
        UILabel *gongziLabel=[[UILabel alloc]initWithFrame:CGRectMake(55, 30,cell.contentView.frame.size.width-55, 20)];
        gongziLabel.font=[UIFont systemFontOfSize:13];
        gongziLabel.tag=72;
        [cell.contentView addSubview:iv];
        [cell.contentView addSubview:companyLabel];
        [cell.contentView addSubview:gongziLabel];
    }
    
    UIImageView *iv=(UIImageView *)[cell.contentView viewWithTag:70];
    UILabel *comLabel=(UILabel *)[cell.contentView viewWithTag:71];
    UILabel *gongziLabel=(UILabel *)[cell.contentView viewWithTag:72];
    
    
    IosjobInfo *info=_companyData[indexPath.row];
    NSString *logoStr=[NSString stringWithFormat:@"http://www.lagou.com/%@",info.companyLogo];
    [iv setImageWithURL:[NSURL URLWithString:logoStr]];
    
    comLabel.text=info.companyName;
    
    gongziLabel.text=info.salary;
    NSLog(@"cell 走吗?%@",info.companyLogo);
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Gongtuan" bundle:nil];
    IosjobInfo *info=_companyData[indexPath.row];
    
    CompanyViewController *companyVC=[storyboard instantiateViewControllerWithIdentifier:@"CompanyViewController"];
    companyVC.titleLabel=info.companyName;
    companyVC.companyId=info.positionId;
    
    
    [self.navigationController pushViewController:companyVC animated:YES];
}

-(void)creatCarViewAndButton
{
    // Display the first ChoosePersonView in front. Users can swipe to indicate
    // whether they like or dislike the person displayed.
    if (!_frontCardView) {
        self.frontCardView=[self popPersonViewWithFrame:[self frontCardViewFrame]];
        [self.view addSubview:self.frontCardView];
    }
    // Display the second ChoosePersonView in back. This view controller uses
    // the MDCSwipeToChooseDelegate protocol methods to update the front and
    // back views after each user swipe.
    //显示第二ChoosePersonView回来。这个视图控制器使用
    //更新前和MDCSwipeToChooseDelegate协议方法
    //每个用户刷卡后返回意见。
    if (!_backCardView) {
        self.backCardView=[self popPersonViewWithFrame:[self backCardViewFrame]];
        [self.view insertSubview:self.backCardView belowSubview:self.frontCardView];
        
        // Add buttons to programmatically swipe the view left or right.
        // See the `nopeFrontCardView` and `likeFrontCardView` methods.
        //添加按钮以编程方式刷左边或右边的视图。
        //查看“nopeFrontCardView”和“likeFrontCardView”方法。
        [self constructNopeButton];
        [self constructLikedButton];
    }

}
/*
-(void)viewDidLayoutSubviews
{
    // Display the first ChoosePersonView in front. Users can swipe to indicate
    // whether they like or dislike the person displayed.
    if (!_frontCardView) {
        self.frontCardView=[self popPersonViewWithFrame:[self frontCardViewFrame]];
        [self.view addSubview:self.frontCardView];
    }
    // Display the second ChoosePersonView in back. This view controller uses
    // the MDCSwipeToChooseDelegate protocol methods to update the front and
    // back views after each user swipe.
    //显示第二ChoosePersonView回来。这个视图控制器使用
    //更新前和MDCSwipeToChooseDelegate协议方法
    //每个用户刷卡后返回意见。
    if (!_backCardView) {
        self.backCardView=[self popPersonViewWithFrame:[self backCardViewFrame]];
        [self.view insertSubview:self.backCardView belowSubview:self.frontCardView];
        
        // Add buttons to programmatically swipe the view left or right.
        // See the `nopeFrontCardView` and `likeFrontCardView` methods.
        //添加按钮以编程方式刷左边或右边的视图。
        //查看“nopeFrontCardView”和“likeFrontCardView”方法。
        [self constructNopeButton];
        [self constructLikedButton];
    }
}
 */

//控制器判断接口方向的;(搞不懂)
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark---MDCSwipToChooseDelegate Protocol Methods
//这个方法是当用户没有做向左或向右滑动的时候
- (void)viewDidCancelSwipe:(UIView *)view {
    
    NSLog(@"You couldn't decide on %@.",_currentInfo.companyName);
}
//这个方法是当用户在做向左或向右滑动的时候
-(void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction
{
    //MDCSwipeDirectionView 显示 NOPE 当向左滑动;
    //显示like 当向右滑动
    if (direction == MDCSwipeDirectionLeft) {
        NSLog(@"You noped %@.", _currentInfo.companyName);
    } else {
        NSLog(@"You liked %@.", _currentInfo.companyName);
        
        
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Gongtuan" bundle:nil];
        CompanyViewController *companyVC=[storyboard instantiateViewControllerWithIdentifier:@"CompanyViewController"];
        companyVC.titleLabel=_currentInfo.companyName;
        companyVC.companyId=_currentInfo.positionId;
        
        [_companyData addObject:_currentInfo];
        
        
        [self.navigationController pushViewController:companyVC animated:YES];
    }
    //MDCSwipeToChooseView removes the view from the view hierarchy--MD 移除View 从 View的层级里
    //滑动结束后(这个行为 可以通过 MDCSwipeOptions类来自定义).从前面的 card 被移除, 我们要将后边的 card 移到前面来,并且 创建一个新的下面的 card
    
    self.frontCardView=self.backCardView;
    if ((self.backCardView=[self popPersonViewWithFrame:[self backCardViewFrame]])) {
        // Fade the back card into view.//褪色的卡片
        self.backCardView.alpha=0.f;
        [self.view insertSubview:self.backCardView belowSubview:self.frontCardView];
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.backCardView.alpha=1.f;
        } completion:nil];
    }
    
}
#pragma mark---Internal Methods
-(void)setFrontCardView:(ChoosePersonView *)frontCardView
{
    //记录 person 为当前选择的 person
    _frontCardView=frontCardView;
    
//    self.currentPerson=frontCardView.person;
    self.currentInfo=frontCardView.info;
}

//可以理解为下载的数据

-(ChoosePersonView *)popPersonViewWithFrame:(CGRect)frame
{
    if ([_parse.data count]==0) {
        
        [FindNetWork getIosjobSuccess:^(IosjobParse *parse) {
            _parse=parse;
            NSLog(@"it下载成功%lu",(unsigned long)[_parse.data count]);
            
            [self creatCarViewAndButton];
        } failure:^(NSString *errorMessage) {
            NSLog(@"失败%@",errorMessage);
        } pageSize:[NSString stringWithFormat:@"%ld",(long)_page]];
        _page++;
        return nil;
    }
    

    
    
    
    
    
    // UIView+MDCSwipeToChoose and MDCSwipeToChooseView是高度可自定的
    // Each take an "options" argument. Here, we specify the view controller as
    // a delegate, and provide a custom callback that moves the back card view
    // based on how far the user has panned the front card view.
    //每一个“选项”参数。在这里,我们指定的视图控制器
    //　　一个委托,并提供一个自定义的回调,卡背面视图
    //　　基于用户移动多远前面卡视图
    MDCSwipeToChooseViewOptions *options=[MDCSwipeToChooseViewOptions new];
    options.delegate=self;
    //位置的临界值
    options.threshold=160.f;
    options.onPan=^(MDCPanState *state){
        CGRect frame=[self backCardViewFrame];
        self.backCardView.frame=CGRectMake(frame.origin.x, frame.origin.y-(state.thresholdRatio *10.f), CGRectGetWidth(frame), CGRectGetHeight(frame));
    };
    
    // Create a personView with the top person in the people array, then pop
    // that person off the stack.
//    ChoosePersonView *personView=[[ChoosePersonView alloc]initWithFrame:frame person:_parse.data[0] options:options];
    ChoosePersonView *personView=[[ChoosePersonView alloc]initWithFrame:frame IosjobInfo:_parse.data[0] options:options];
    [_parse.data removeObjectAtIndex:0];
    return personView;
    
}
#pragma mark  view Contruction 实施
- (CGRect)frontCardViewFrame {
    CGFloat horizontalPadding = 20.f;
    CGFloat topPadding = 60.f;
    CGFloat bottomPadding = 200.f;
    return CGRectMake(horizontalPadding,
                      topPadding,
                      CGRectGetWidth(self.view.frame) - (horizontalPadding * 2),
                      CGRectGetHeight(self.view.frame) - bottomPadding);
}
- (CGRect)backCardViewFrame {
    CGRect frontFrame = [self frontCardViewFrame];
    return CGRectMake(frontFrame.origin.x,
                      frontFrame.origin.y + 10.f,
                      CGRectGetWidth(frontFrame),
                      CGRectGetHeight(frontFrame));
}

//Create and add the "nope" button
//创建一个nope 按钮
-(void)constructNopeButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *image = [UIImage imageNamed:@"btnLeft副本"];
    button.frame = CGRectMake(ChoosePersonButtonHorizontalPadding,
                              CGRectGetMaxY(self.backCardView.frame) + ChoosePersonButtonVerticalPadding,
                              image.size.width,
                              image.size.height);
    [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
//    [button setTintColor:[UIColor colorWithRed:247.f/255.f
//                                         green:91.f/255.f
//                                          blue:37.f/255.f
//                                         alpha:1.f]];
    
    [button addTarget:self
               action:@selector(nopeFrontCardView)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}
// Create and add the "like" button.
- (void)constructLikedButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *image = [UIImage imageNamed:@"btnRight"];
    button.frame = CGRectMake(CGRectGetMaxX(self.view.frame) - image.size.width - ChoosePersonButtonHorizontalPadding,
                              CGRectGetMaxY(self.backCardView.frame) + ChoosePersonButtonVerticalPadding,
                              image.size.width,
                              image.size.height);
    [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
//    [button setTintColor:[UIColor colorWithRed:29.f/255.f
//                                         green:245.f/255.f
//                                          blue:106.f/255.f
//                                         alpha:1.f]];
    [button addTarget:self
               action:@selector(likeFrontCardView)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0,
                                                           CGRectGetMaxY(self.backCardView.frame) + ChoosePersonButtonVerticalPadding+60,
                                                           170,
                                                           25)];
    CGPoint point=label.center;
    point.x=self.view.center.x;
    label.center=point;
    label.textAlignment=NSTextAlignmentCenter;
    
    label.text=@"向右滑动查看公司详情";
    label.font=[UIFont boldSystemFontOfSize:13];
    label.tag=100;
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    btn.tintColor=[UIColor blackColor];
    [btn setTitle:@"x" forState:UIControlStateNormal];
    btn.frame=CGRectMake(150, 0, 20, 20);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    label.userInteractionEnabled=YES;
    
    [label addSubview:btn];
    
    
    
    [self.view addSubview:label];
    
    
    
    
    
    
    
}
-(void)btnClick
{
    UILabel *label=(UILabel *)[self.view viewWithTag:100];
    [label removeFromSuperview];
}
#pragma mark Control Events 控制事件

// Programmatically "nopes" the front card view.
- (void)nopeFrontCardView {
    [self.frontCardView mdc_swipe:MDCSwipeDirectionLeft];
}

// Programmatically "likes" the front card view.
- (void)likeFrontCardView {
    [self.frontCardView mdc_swipe:MDCSwipeDirectionRight];
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
