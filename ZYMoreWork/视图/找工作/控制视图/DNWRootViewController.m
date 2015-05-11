//
//  DNWRootViewController.m
//  LoveAndPeace
//
//  Created by qianfeng on 15/4/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DNWRootViewController.h"

#import "BaseNavigationViewController.h"

#import "WorkViewController.h"

@interface DNWRootViewController ()<UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    float ScreenWidth;
    float ScreenHeight;
    float _x;
    float _y;
    BOOL _ismove;
    NSString *_nowCity;
    
    
    
}
@property(nonatomic,strong)UITapGestureRecognizer *tapRecongnizer;
@property(nonatomic,strong)UIPanGestureRecognizer *edgePan;

@end

@implementation DNWRootViewController
{
    NSArray *_cityArr;
    UIButton *_leftButton;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateData];
    // Do any additional setup after loading the view.
    self.tabBarController.tabBar.hidden=YES;
    //    self.navigationController.navigationBar.hidden=YES;
    UIImageView *iv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"citybg"]];
    
    [self.view addSubview:iv];
    _x=0;
    _y=0;
    _ismove=0;
    
    ScreenWidth=self.view.frame.size.width;
    ScreenHeight=self.view.frame.size.height;
    
    //    DNWLeftViewController * leftVC = [[DNWLeftViewController alloc] init];
    //UINavigationController * leftNC = [[UINavigationController alloc ]initWithRootViewController:leftVC];
    //    leftVC.delegate=self;
    //    DNWRightViewController * rightVC = [[DNWRightViewController alloc] init];
    //UINavigationController * rightNC = [[UINavigationController alloc] initWithRootViewController:rightVC];
    UIView *leftView=[[UIView alloc]initWithFrame:CGRectMake(-ScreenWidth,0,ScreenWidth,ScreenHeight)];
    [self.view addSubview:leftView];
    leftView.backgroundColor=[UIColor clearColor];
    
    self.leftview=leftView;
    
    
    BaseTabBarViewController *basetbc=[[BaseTabBarViewController alloc]init];
    self.midTBC=basetbc;
    
    [self.midTBC.view setAutoresizesSubviews:YES];
    self.midTBC.delegate=self;
    //    self.leftViewController=leftVC;
    //    self.rightViewController=rightVC;
    
    
    
    //    [self addChildViewController:self.leftViewController];
    //
    //
    //    [self.view addSubview:self.leftViewController.view];
    //    self.leftViewController.view.frame = CGRectMake(-ScreenWidth,0,ScreenWidth,ScreenHeight);
    
    
    //    [self addChildViewController:self.rightViewController];
    //    [self.view addSubview:self.rightViewController.view];
    
    [self addChildViewController:self.midTBC];
    [self.view addSubview:_midTBC.view];
    
    
    
    _leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _leftButton.frame = CGRectMake(0, 20, 40, 40);
    _leftButton.tag=77;
    
    [_leftButton setTitle:@"青岛" forState:UIControlStateNormal];
    [_leftButton setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *clearBtn=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    
    clearBtn.width=-15;
    [_leftButton addTarget:self action:@selector(didClickLeftBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBar=[[UIBarButtonItem alloc]initWithCustomView:_leftButton];
    //    self.navigationItem.leftBarButtonItem=leftBar;
    //
    //    self.midViewController.navigationItem.title=@"中间";
    //    self.midViewController.navigationItem.leftBarButtonItem=leftBar;
    
    BaseNavigationViewController *nc=[self.midTBC.viewControllers objectAtIndex:0];
    WorkViewController *tvc=[nc.viewControllers firstObject];
    
    _edgePan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePan:)];
    _tapRecongnizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGR:)];
    
    _edgePan.delegate=self;
    
    [self.midTBC.view addGestureRecognizer:_edgePan];
    
    //    NSLog(@"%@",tvc.title);
    tvc.navigationItem.leftBarButtonItems=@[clearBtn,leftBar];
    
    //    NSLog(@"%@",[[self.midTBC.view.gestureRecognizers lastObject] class]);
    
    //    NSLog(@"%@",nc.navigationItem.title);
    //    _leftButton.tag=1111;
    //    [nc.view addSubview:_leftButton];
    
    
    //    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    //    rightButton.frame = CGRectMake(240 ,20, 40, 40);
    //    [rightButton setTitle:@"right" forState:UIControlStateNormal];
    //    [rightButton addTarget:self action:@selector(didClickRightBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addtapGR:) name:@"istapGr" object:nil];
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"istapGr" object:[NSString stringWithFormat:@"%f",_x] userInfo:nil];
    
    [self createLeftView];
    NSLog(@"%ld",(unsigned long)self.midTBC.selectedIndex);
    
    
    [self.midTBC addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
    
    
    

    
    
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    self.midTBC.selectedIndex=tabBarController.selectedIndex;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"keyPath = %@, class = %@",keyPath,[object class]);//keyPath是观察的变量,[object class]是什么类(这里是Dog类)
    
    NSLog(@"dic = %@",[change objectForKey:@"new"]);//change 字典里属性,new,old, kind
    if ([[change objectForKey:@"new"] intValue]==0) {
        if (self.midTBC.view.gestureRecognizers.count) {
            
            return;
        }
        [self.midTBC.view addGestureRecognizer:_edgePan];
    }
    else{
        
        [self.midTBC.view removeGestureRecognizer:_edgePan];
    }
    
    
}
-(BOOL)shouldAutorotate
{
    return YES;
    
}
-(void)createLeftView
{
    
    UITableView *tableview=[[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth-240, 20, 240, ScreenHeight-20)];
    tableview.delegate=self;
    tableview.dataSource=self;
    tableview.backgroundColor=[UIColor clearColor];
    tableview.separatorColor=[UIColor clearColor];
    [self.leftview addSubview:tableview];
    
}
#pragma mark--tableView生命周期
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    return _cityArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 20;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 20;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 240, 20 )];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 230, 20)];
    label.text=@"服务城市";
    label.textColor=[UIColor blackColor];
    
    
    label.font=[UIFont systemFontOfSize:13];
    view.backgroundColor=[UIColor whiteColor];
    view.alpha=0.5;
    [view addSubview:label];
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 240, 20 )];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 230, 20)];
    label.text=@"当前城市";
    label.textColor=[UIColor blackColor];
    
    label.font=[UIFont systemFontOfSize:13];
    view.backgroundColor=[UIColor whiteColor];
    view.alpha=0.5;
    [view addSubview:label];
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *leftCellID=@"leftCell";
    if (indexPath.section==0) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:leftCellID];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftCellID];
        }
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, cell.contentView.frame.size.width-10, 20)];
        _nowCity=@"大连";
        label.text=[NSString stringWithFormat:@"当前定位城市:%@",_nowCity];
        label.textColor=[UIColor whiteColor];
        label.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview: label];
        cell.backgroundColor=[UIColor clearColor];
        return cell;
    }
    
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:leftCellID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftCellID];
    }
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, cell.contentView.frame.size.width-10, 20)];
    label.text=_cityArr[indexPath.row];
    label.textColor=[UIColor whiteColor];
    label.font=[UIFont systemFontOfSize:14];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0,29, cell.contentView.frame.size.width, 1)];
    view.backgroundColor=[UIColor whiteColor];
    [cell.contentView addSubview:view];
    [cell.contentView addSubview: label];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.midTBC.view removeGestureRecognizer:_tapRecongnizer];
    BaseNavigationViewController *nc=self.midTBC.viewControllers[0];
    WorkViewController *vc=nc.viewControllers[0];
    
    [_leftButton setTitle:_cityArr[indexPath.row] forState:UIControlStateNormal];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.leftview.frame=CGRectMake(-ScreenWidth, 0, ScreenWidth, ScreenHeight);
        
        CGAffineTransform centerTranslate = CGAffineTransformMakeTranslation(1, 0.0);
        CGAffineTransform centerScale = CGAffineTransformMakeScale(1 , 1);
        self.midTBC.view.transform = CGAffineTransformConcat(centerScale, centerTranslate);
        
        self.midTBC.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        
        _x=0;
        
        _ismove=0;
    } completion:^(BOOL finished) {
        
        if (![_cityArr[indexPath.row] isEqualToString:@"青岛"]) {
            [vc setAlterView];
        }
        
    }];
    
    
    
    
    
    
}
-(void)tapGR:(UITapGestureRecognizer *)tapGr
{
    //    NSLog(@"TapGestureRecognizer");
    
    [UIView animateWithDuration:0.3 animations:^{
        //            self.leftViewController.view.frame=CGRectMake(-ScreenWidth, 0, ScreenWidth, ScreenHeight);
        //
        //        self.leftview.frame=CGRectMake(-ScreenWidth, 0, ScreenWidth, ScreenHeight);
        //
        //        CGAffineTransform centerTranslate = CGAffineTransformMakeTranslation(1, 0.0);
        //        CGAffineTransform centerScale = CGAffineTransformMakeScale(1 , 1);
        //        self.midTBC.view.transform = CGAffineTransformConcat(centerScale, centerTranslate);
        //
        //        self.midTBC.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        
        
        
        
        
        CGAffineTransform centerTranslate = CGAffineTransformMakeTranslation(1, 0.0);
        
        CGAffineTransform centerScale = CGAffineTransformMakeScale(1, 1);
        self.midTBC.view.transform = CGAffineTransformConcat(centerScale, centerTranslate);
        
        self.midTBC.view.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        
        self.leftview.frame=CGRectMake(-ScreenWidth, 0, ScreenWidth, ScreenHeight);
        _x=0;
        _ismove=0;
        [self.midTBC.view removeGestureRecognizer:_tapRecongnizer];
        
        
        
        
        
        
        //            self.rightViewController.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        
    } completion:^(BOOL finished) {
    }];
    
    
    //
    //
    //    if (_x==240) {
    //        [UIView animateWithDuration:0.3 animations:^{
    ////            tapGr.view.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    //
    //            self.leftview.frame=CGRectMake(-ScreenWidth, 0, ScreenWidth, ScreenHeight);
    //
    //            CGAffineTransform centerTranslate = CGAffineTransformMakeTranslation(1, 0.0);
    //            CGAffineTransform centerScale = CGAffineTransformMakeScale(1 , 1);
    //            self.midTBC.view.transform = CGAffineTransformConcat(centerScale, centerTranslate);
    //
    //            self.midTBC.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    //
    //            _x=0;
    //            _ismove=0;}
    //                         completion:^(BOOL finished) {
    //
    //                         }];
    //    }
    //    [self.midTBC.view removeGestureRecognizer:_tapRecongnizer];
    //
    //
}
-(void)edgePan:(UIPanGestureRecognizer *)pansender{
    NSLog(@"dddd");
    BaseNavigationViewController *nc=[self.midTBC.viewControllers objectAtIndex:0];
    
    NSLog(@"%ld",(unsigned long)self.midTBC.selectedIndex);
    
    if (self.midTBC.selectedIndex==0&&[nc.visibleViewController isKindOfClass:[WorkViewController class]]) {
        
        
        switch (pansender.state) {
            case UIGestureRecognizerStateBegan: {
                CGPoint loaction=[pansender locationInView:pansender.view];
                //            NSLog(@"%f",loaction.x);
                if (loaction.x<100||loaction.x==100) {
                    _ismove=1;
                }
                break;
                
            }
            case UIGestureRecognizerStateChanged: {
                //                NSLog(@"%@",NSStringFromCGPoint(CGPointMake(_x, _y)));
                CGPoint translation=[pansender translationInView:self.view];
                if (translation.x>0||_x>0) {
                    if (_ismove==1) {
                        if (_x==240&&translation.x>0) {
                            return;
                        }
                        
                        
                        if (pansender.view.frame.origin.x>240.00&&translation.x>0) {
                            
                            return;
                            
                        }else{
                            CGFloat remaindistance=240-(_x);
                            if (_x+translation.x>240) {
                                translation.x=remaindistance;
                                _x=240 ;
                                self.leftview.frame=CGRectMake(-ScreenWidth+240, 0, ScreenWidth, ScreenHeight);
                            }
                            else
                            {
                                _x= pansender.view.frame.origin.x+translation.x ;
                                self.leftview.frame=CGRectMake(-ScreenWidth+_x, 0, ScreenWidth, ScreenHeight);
                            }
                            
                            CGAffineTransform centerTranslate = CGAffineTransformMakeTranslation(1, 0.0);
                            CGFloat trans=1-0.3*((_x)/240);
                            CGAffineTransform centerScale = CGAffineTransformMakeScale(trans, trans);
                            self.midTBC.view.transform = CGAffineTransformConcat(centerScale, centerTranslate);
                            
                            
                            
                            
                            pansender.view.frame=CGRectMake(_x, _y+((_x/240)*(ScreenHeight*0.15)), ScreenWidth*trans, ScreenHeight*trans);
                        }
                        
                        
                    }
                    
                    
                }
                
                
                //每次移动都需要清空手势所记录的轨迹
                //            NSLog(@"pan====%@",NSStringFromCGPoint(CGPointMake(_x, _y)));
                break;
            }
            case UIGestureRecognizerStateEnded: {
                
                NSLog(@"UIGestureRecognizerStateEnded");
                if (pansender.view.frame.origin.x>160) {
                    
                    CGAffineTransform centerTranslate = CGAffineTransformMakeTranslation(1, 0.0);
                    
                    CGAffineTransform centerScale = CGAffineTransformMakeScale(0.7, 0.7);
                    self.midTBC.view.transform = CGAffineTransformConcat(centerScale, centerTranslate);
                    
                    pansender.view.frame=CGRectMake(240, (ScreenHeight*0.15), ScreenWidth*0.7, ScreenHeight*0.7);
                    
                    self.leftview.frame=CGRectMake(240-ScreenWidth, 0, ScreenWidth, ScreenHeight);
                    _x=240;
                    _ismove=0;
                    [self.midTBC.view addGestureRecognizer:_tapRecongnizer];
                    
                }
                else
                {
                    
                    CGAffineTransform centerTranslate = CGAffineTransformMakeTranslation(1, 0.0);
                    
                    CGAffineTransform centerScale = CGAffineTransformMakeScale(1, 1);
                    self.midTBC.view.transform = CGAffineTransformConcat(centerScale, centerTranslate);
                    
                    pansender.view.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
                    
                    self.leftview.frame=CGRectMake(-ScreenWidth, 0, ScreenWidth, ScreenHeight);
                    _x=0;
                    _ismove=0;
                    [self.midTBC.view removeGestureRecognizer:_tapRecongnizer];
                    
                    
                }
                break;
            }
            default:
                break;
        }
        
        
        
        [pansender setTranslation:CGPointZero inView:self.view];
        
        
        
    }
    
    
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.view!=self.midTBC.view) {
        return NO;
    }
    return YES;
}

//-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognize{
//
//    if (self.midTBC.selectedIndex==0){
//
//    //end
//
//    if (gestureRecognizer.state==UIGestureRecognizerStateEnded) {
//        NSLog(@"ffff");
//            if (gestureRecognizer.view.frame.origin.x>160) {
//
//            gestureRecognizer.view.frame=CGRectMake(240, 0, ScreenWidth, ScreenHeight);
//
//            self.leftview.frame=CGRectMake(240-ScreenWidth, 0, ScreenWidth, ScreenHeight);
//                _x=240;
//                _ismove=0;
//                [self.midTBC.view addGestureRecognizer:_tapRecongnizer];
//
//        }
//        else
//        {
//            gestureRecognizer.view.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
//
//            self.leftview.frame=CGRectMake(-ScreenWidth, 0, ScreenWidth, ScreenHeight);
//            _x=0;
//            _ismove=0;
//            [self.midTBC.view removeGestureRecognizer:_tapRecongnizer];
//
//
//        }
////        CGPoint translation=[gestureRecognizer locationInView:self.view];
//
//        NSLog(@"%ld",gestureRecognizer.state);
//        return NO;
//    }
//    }
// return YES;
//
//}






//网易侧边栏效果
- (void)didClickLeftBarButtonAction:(UIBarButtonItem *)_leftButton{
    //用这个判断条件是为了左边视图出来后,再点击按钮能够回去
    //    NSLog(@"ClickLeftBarButton");
    if (self.midTBC.view.frame.origin.x == 0) {
        
        
        
        [UIView animateWithDuration:0.3 animations:^{
            
            //ScreenWidthScreenHeight屏幕实际大小宏
            //            self.leftViewController.view.frame = CGRectMake(240-ScreenWidth, 0, ScreenWidth, ScreenHeight);
            //也可以通过这种方式来实现
            //self.midViewController.view.transform = CGAffineTransformTranslate(self.midViewController.view.transform, 240,(ScreenHeight*0.15) );
            self.leftview.frame=CGRectMake(240-ScreenWidth, 0, ScreenWidth, ScreenHeight);
            CGAffineTransform centerTranslate = CGAffineTransformMakeTranslation(1, 0.0);
            
            CGAffineTransform centerScale = CGAffineTransformMakeScale(0.7 , 0.7);
            self.midTBC.view.transform = CGAffineTransformConcat(centerScale, centerTranslate);
            
            
            self.midTBC.view.frame = CGRectMake(240, (ScreenHeight*0.15), ScreenWidth*0.7, ScreenHeight*0.7);
            
            _x=240;
            _ismove=0;
            [self.midTBC.view addGestureRecognizer:_tapRecongnizer];
            //            self.rightViewController.view.frame = CGRectMake(240, (ScreenHeight*0.15), ScreenWidth, ScreenHeight-(ScreenHeight*0.15)*2);
            
        } completion:^(BOOL finished) {
            
        }];
        
        
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            //            self.leftViewController.view.frame=CGRectMake(-ScreenWidth, 0, ScreenWidth, ScreenHeight);
            
            self.leftview.frame=CGRectMake(-ScreenWidth, 0, ScreenWidth, ScreenHeight);
            
            CGAffineTransform centerTranslate = CGAffineTransformMakeTranslation(1, 0.0);
            CGAffineTransform centerScale = CGAffineTransformMakeScale(1 , 1);
            self.midTBC.view.transform = CGAffineTransformConcat(centerScale, centerTranslate);
            
            self.midTBC.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
            
            _x=0;
            _ismove=0;
            //            self.rightViewController.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
            
        } completion:^(BOOL finished) {
        }];
        
    }
    
}
//-(void)leftPushIndex:(NSInteger)indexrow
//{
//
//    NSLog(@"leftViewController====%ld",indexrow);
//    [UIView animateWithDuration:0.3 animations:^{
//        self.leftview.frame=CGRectMake(-ScreenWidth, 0, ScreenWidth, ScreenHeight);
//
//        self.midTBC.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
//        self.rightview.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
//
//    } completion:^(BOOL finished) {
//    }];
//
//    BaseNavigationController *nc=[self.midTBC.viewControllers objectAtIndex:0];
//    ToolViewController *ttvc=[[ToolViewController alloc]init];
//    //    ttvc.labelname=[NSString stringWithFormat:@"%ld",indexrow];
//    [nc pushViewController:ttvc animated:YES];
//
//
//}

//标准侧边栏效果

- (void)didClickRightBarButtonAction:(UIBarButtonItem *)rightButton{
    
    if (_midTBC.view.frame.origin.x == 0) {
        [UIView animateWithDuration:1.1 animations:^{
            _midTBC.view.frame = CGRectMake(-240, 0, ScreenWidth, ScreenHeight);
            _rightview.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
            
        } completion:^(BOOL finished) {
        }];
        
    }else{
        [UIView animateWithDuration:1.1 animations:^{
            _midTBC.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
            _rightview.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        } completion:^(BOOL finished) {
        }];
    }
    
}
-(void)updateData
{
    _cityArr=@[@"北京",@"长沙",@"重庆",@"东莞",@"福州",@"济南",@"兰州",@"南京",@"青岛",@"上海",@"天津",@"武汉",@"西安",@"郑州"];
}


-(void)viewWillAppear:(BOOL)animated
{
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    
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
