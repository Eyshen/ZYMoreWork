//
//  BaomingViewController.m
//  ZYMoreWork
//
//  Created by qianfeng on 15/5/8.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "BaomingViewController.h"
#import "BaomingSuccessViewController.h"
#import "UIViewController+KeyboardAdditions.h"
@interface BaomingViewController ()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *gongziLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateLabel;
@property (weak, nonatomic) IBOutlet UIView *yellowView;





@end

@implementation BaomingViewController
{
    UITextField *_nameText;
    UITextField *_mobileText;
    UITextField *_personID;
    
    UILabel *_nameLabel;
    UILabel *_mobilLabel;
    UILabel *_personIDlabel;
    CGFloat _width;
    CGFloat _height;
    NSInteger _cishu;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _cishu=0;
    _commitBtn.layer.masksToBounds=YES;
    _commitBtn.layer.cornerRadius=10;
    _companyLabel.text=[NSString stringWithFormat:@"  %@",self.companyName];
    if (!self.companyTitle) {
        _titleLabel.text=[NSString stringWithFormat:@"  %@",self.companyName];
    }else{
        _titleLabel.text=self.companyTitle;
    }
    if (self.gongzi) {
        _gongziLabel.text=self.gongzi;
    }
    if (self.update) {
        _updateLabel.text=self.update;
    }
    
    [self addBackItem];
}

-(void)viewDidLayoutSubviews
{
    
    if (_cishu==1) {
        _width=CGRectGetWidth(_yellowView.frame);
        _height=CGRectGetHeight(_yellowView.frame);
        NSLog(@"%f---%f",_width,_height);
        [self constructTextField];
    }
    
    _cishu++;
}

- (IBAction)commitBtnClick:(UIButton *)sender {
    if (_nameText.text.length!=0&&_mobileText.text.length==11&&_personID.text.length==18) {
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Work" bundle:nil];
        BaomingSuccessViewController *BaomingSuccessVC=[storyboard instantiateViewControllerWithIdentifier:@"BaomingSuccessViewController"];
        [self.navigationController pushViewController:BaomingSuccessVC animated:YES];
    }else{
        UIAlertView *av=[[UIAlertView alloc]initWithTitle:@"个人信息错误" message:@"请填全表格信息!" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [av show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex%u",buttonIndex);
    if (buttonIndex==0) {
        NSLog(@"知道了");
    }
}
#pragma mark---创建文档
-(void)constructTextField
{
    //name
    _nameText=[[UITextField alloc]initWithFrame:CGRectMake(_width*2/7, _height/7, _width*3/5, _height/7)];
    _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(_width*2/7-70, _height/7, 70, _height/7)];
    
    _nameText.backgroundColor=[UIColor whiteColor];
    _nameText.layer.masksToBounds=YES;
    _nameText.layer.cornerRadius=5;
    _nameLabel.text=@"真实姓名";
    _nameLabel.font=[UIFont systemFontOfSize:15];
    [_yellowView addSubview:_nameLabel];
    [_yellowView addSubview:_nameText];
    
    
    //手机
    _mobileText=[[UITextField alloc]initWithFrame:CGRectMake(_width*2/7, _height/7+_height/7+20, _width*3/5, _height/7)];
    _mobilLabel=[[UILabel alloc]initWithFrame:CGRectMake(_width*2/7-70, _height/7+_height/7+20, 70, _height/7)];
    
    _mobileText.backgroundColor=[UIColor whiteColor];
    _mobileText.layer.masksToBounds=YES;
    _mobileText.layer.cornerRadius=5;
    _mobilLabel.text=@"手机号码";
    _mobilLabel.font=[UIFont systemFontOfSize:15];
    [_yellowView addSubview:_mobilLabel];
    [_yellowView addSubview:_mobileText];
    //身份证
    
    _personID=[[UITextField alloc]initWithFrame:CGRectMake(_width*2/7, _height/7+_height/7+_height/7+20+20, _width*3/5, _height/7)];
    _personIDlabel=[[UILabel alloc]initWithFrame:CGRectMake(_width*2/7-70, _height/7+_height/7+_height/7+20+20, 70, _height/7)];
    
    _personID.backgroundColor=[UIColor whiteColor];
    _personID.layer.masksToBounds=YES;
    _personID.layer.cornerRadius=5;
    _personIDlabel.text=@"身份证号";
    _personIDlabel.font=[UIFont systemFontOfSize:15];
    [_yellowView addSubview:_personIDlabel];
    [_yellowView addSubview:_personID];
}
#pragma mark----KeyboardAdditions
-(void)viewWillAppear:(BOOL)animated
{
    [self ka_startObservingKeyboardNotifications];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self ka_stopObservingKeyboardNotifications];
    
}
- (void)ka_keyboardShowOrHideAnimationWithHeight:(CGFloat)height
                               animationDuration:(NSTimeInterval)animationDuration
                                  animationCurve:(UIViewAnimationCurve)animationCurve {
    
    if (self.view.frame.size.width==320&&height>200) {
        CGRect mobileTextFrame=CGRectMake(_width*2/7, _mobileText.frame.origin.y-17, _width*3/5,  _height/7);
        CGRect mobileLabelFrame=CGRectMake(_width*2/7-70, _mobileText.frame.origin.y-17, 70,  _height/7);
        
        CGRect personIDFrame=CGRectMake(_width*2/7, _personID.frame.origin.y-17*2, _width*3/5, _height/7);
        CGRect personIDlabelFrame=CGRectMake(_width*2/7-70, _personID.frame.origin.y-17*2, 70, _height/7);
        [UIView animateWithDuration:0.3 animations:^{
            _mobileText.frame=mobileTextFrame;
            _mobilLabel.frame=mobileLabelFrame;
            
            _personID.frame=personIDFrame;
            _personIDlabel.frame=personIDlabelFrame;
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            _mobileText.frame=CGRectMake(_width*2/7, _height/7+_height/7+20, _width*3/5, _height/7);
            _mobilLabel.frame=CGRectMake(_width*2/7-70, _height/7+_height/7+20, 70, _height/7);
            
            _personID.frame=CGRectMake(_width*2/7, _height/7+_height/7+_height/7+20+20, _width*3/5, _height/7);
            _personIDlabel.frame=CGRectMake(_width*2/7-70, _height/7+_height/7+_height/7+20+20, 70, _height/7);
        }];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
