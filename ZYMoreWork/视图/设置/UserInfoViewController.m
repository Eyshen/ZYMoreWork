//
//  UserInfoViewController.m
//  ZYMoreWork
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UIViewController+KeyboardAdditions.h"
#import "JSImagePickerViewController.h"
@interface UserInfoViewController ()<JSImagePickerViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UIButton *setBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *workLabel;
@property (weak, nonatomic) IBOutlet UILabel *beiyongLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@end

@implementation UserInfoViewController
{
    UIView *_bgView;
    CGFloat _width;
    CGFloat _height;
    
    UITextField *_nameTF;
    UITextField *_workerTF;
    UITextView *_detailView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.setBtn.layer.masksToBounds=YES;
    self.setBtn.layer.cornerRadius=10;
    
    self.userImg.layer.masksToBounds=YES;
    self.userImg.layer.cornerRadius=10;
    
    
    //取缓存
    UIImage *huancunImage=[UIImage imageWithContentsOfFile:[self imagePath:@"userImage"]];
    if (huancunImage) {
        self.userImg.image=huancunImage;
    }
    NSString *nameStr=[NSString stringWithContentsOfFile:[self imagePath:@"name"] encoding:NSUTF8StringEncoding error:nil];
    if (nameStr) {
        _nameLabel.text=nameStr;
    }
    NSString *workStr=[NSString stringWithContentsOfFile:[self imagePath:@"work"] encoding:NSUTF8StringEncoding error:nil];
    if (workStr) {
        _workLabel.text=workStr;
    }
    NSString *detailStr=[NSString stringWithContentsOfFile:[self imagePath:@"detail"] encoding:NSUTF8StringEncoding error:nil];
    if (detailStr) {
        _beiyongLabel.text=detailStr;
    }
#pragma mark----创建文用户信息文件夹
    NSFileManager *manager=[NSFileManager defaultManager];
    
    [manager createDirectoryAtPath:[self imagePackagePath] withIntermediateDirectories:NO attributes:nil error:nil];
    [self addBackItem];
}

//缓存操作
-(void)downLoad
{
    
}



//缓存操作

-(NSString *)imagePackagePath{
    //存放图片的文件夹
    NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *userInfoPath=[path stringByAppendingPathComponent:@"userInfo"];
    return userInfoPath;
}

-(NSString *)imagePath:(NSString *)imageName
{
    return [[self imagePackagePath]  stringByAppendingPathComponent:[imageName stringByAppendingPathExtension:@"png"]];
}
                           

-(void)viewDidLayoutSubviews
{
    _width=self.view.frame.size.width;
    _height=self.view.frame.size.height;
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}
- (IBAction)rightBtn:(UIButton *)sender {
    sender.selected=!sender.selected;
    NSLog(@"btnEvent-----%d",sender.selected);
    
    if (_bgView==nil) {
        
        NSLog(@"1111");
        _bgView=[[UIView alloc]initWithFrame:CGRectMake(20, 60+_height, _width-40, 7*53)];
        _bgView.backgroundColor=[UIColor colorWithRed:0.929 green:0.949 blue:0.976 alpha:1.000];
        _nameTF=[[UITextField alloc]initWithFrame:CGRectMake(20, 30, _bgView.frame.size.width-40, 30)];
        _nameTF.backgroundColor=[UIColor whiteColor];
        _nameTF.layer.masksToBounds=YES;
        _nameTF.layer.cornerRadius=10;
        _nameTF.placeholder=@"用户姓名";
        _workerTF=[[UITextField alloc]initWithFrame:CGRectMake(20, 90, _bgView.frame.size.width-40, 30)];
        _workerTF.backgroundColor=[UIColor whiteColor];
        _workerTF.layer.masksToBounds=YES;
        _workerTF.layer.cornerRadius=10;
        _workerTF.placeholder=@"用户职业";
        _detailView=[[UITextView alloc]initWithFrame:CGRectMake(20, 150, _bgView.frame.size.width-40, 100)];
        
        UIButton *commitBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        commitBtn.frame=CGRectMake(_bgView.frame.size.width/2.0-45, 280, 90, 30);
        
        commitBtn.layer.masksToBounds=YES;
        commitBtn.layer.cornerRadius=15;
        [commitBtn setTitle:@"提交" forState: UIControlStateNormal];
        commitBtn.backgroundColor=[UIColor colorWithRed:0.183 green:0.250 blue:0.333 alpha:1.000];
        [commitBtn setTintColor:[UIColor whiteColor]];
        [commitBtn addTarget:self action:@selector(commitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_bgView addSubview:_nameTF];
        [_bgView addSubview:_workerTF];
        [_bgView addSubview:_detailView];
        [_bgView addSubview:commitBtn];
        [self.view addSubview:_bgView];
    }
    if (sender.selected==1) {
        
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
        
        
    }else
        
    {
        
        
        [self.view endEditing:YES];
#pragma mark---数据存入沙盒
        if (_nameLabel.text.length>1) {
            _nameLabel.text=_nameTF.text;
            NSString *namePath=[self imagePath:@"name"];
            NSData *nameData=[_nameTF.text dataUsingEncoding:NSUTF8StringEncoding];
            [nameData writeToFile:namePath atomically:YES];
        }
        
        if (_workerTF.text.length>1) {
            _workLabel.text=_workerTF.text;
            NSString *workPath=[self imagePath:@"work"];
            NSData *workData=[_workerTF.text dataUsingEncoding:NSUTF8StringEncoding];
            [workData writeToFile:workPath atomically:YES];
            
        }
        
        if (_detailView.text.length>1) {
            _beiyongLabel.text=_detailView.text;
            NSString *beiyongPath=[self imagePath:@"detail"];
            NSData *beiyongData=[_detailView.text dataUsingEncoding:NSUTF8StringEncoding];
            [beiyongData writeToFile:beiyongPath atomically:YES];
        }
        
        

        
        CGRect frame=_bgView.frame;
        frame.origin.y+=_height;
        [UIView animateWithDuration:0.5 animations:^{
            _bgView.frame=frame;
        }];
    }

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
        CGRect workerTFrame=CGRectMake(20, 90-25, _bgView.frame.size.width-40,  30);
        CGRect detailTView=CGRectMake(20, 150-50,_bgView.frame.size.width-40,  100);
        
        
        [UIView animateWithDuration:0.3 animations:^{
            _workerTF.frame=workerTFrame;
            _detailView.frame=detailTView;
            
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            _workerTF.frame=CGRectMake(20, 90, _bgView.frame.size.width-40, 30);
            _detailView.frame=CGRectMake(20, 150, _bgView.frame.size.width-40, 100);
            
        }];
    }
}

-(void)commitBtnClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    
    _rightBtn.selected=NO;
    
#pragma mark---数据存入沙盒
    if (_nameTF.text.length>1) {
        _nameLabel.text=_nameTF.text;
        NSString *namePath=[self imagePath:@"name"];
        NSData *nameData=[_nameTF.text dataUsingEncoding:NSUTF8StringEncoding];
        [nameData writeToFile:namePath atomically:YES];
    }
    
    if (_workerTF.text.length>1) {
        _workLabel.text=_workerTF.text;
        NSString *workPath=[self imagePath:@"work"];
        NSData *workData=[_workerTF.text dataUsingEncoding:NSUTF8StringEncoding];
        [workData writeToFile:workPath atomically:YES];
        
    }
    
    if (_detailView.text.length>1) {
        _beiyongLabel.text=_detailView.text;
        NSString *beiyongPath=[self imagePath:@"detail"];
        NSData *beiyongData=[_detailView.text dataUsingEncoding:NSUTF8StringEncoding];
        [beiyongData writeToFile:beiyongPath atomically:YES];
    }

    
    
    
    CGRect frame=_bgView.frame;
    frame.origin.y+=_height;
    [UIView animateWithDuration:0.5 animations:^{
        _bgView.frame=frame;
    }];
    
}
- (IBAction)setBtnClick:(UIButton *)sender {
    NSLog(@"aaa");
    JSImagePickerViewController *imagePick=[[JSImagePickerViewController alloc]init];
    imagePick.delegate=self;
    [imagePick showImagePickerInController:self animated:YES];
}
#pragma mark-----JSImagePikcerViewControllerDelegate

-(void)imagePickerDidSelectImage:(UIImage *)image
{
    self.userImg.image=image;
    NSString *path=[self imagePath:@"userImage"];
    NSData *userImageData=UIImagePNGRepresentation(image);
    [userImageData writeToFile:path atomically:YES];
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
