//
//  ChoosePersonView.m
//  tantanDemo
//
//  Created by qianfeng on 15/5/6.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "ChoosePersonView.h"
#import "UIKit+AFNetworking.h"
#import "ImageLabelView.h"
#import "Person.h"
#import "IosjobParse.h"


@interface ChoosePersonView ()

//内容
@property (nonatomic,strong)UIView  *informationView;
@property (nonatomic,strong)UILabel *nameLabel;

@property (nonatomic,strong)ImageLabelView *cameraImageLabelView;
@property (nonatomic,strong)ImageLabelView *interestsImageLabelView;
@property (nonatomic,strong)ImageLabelView *friendsImageLabelView;

//info
@property (nonatomic,strong)UILabel *positionNameLabel;
@property (nonatomic,strong)UILabel *companyNameLabel;
@property (nonatomic,strong)UILabel *createTimeLabel;
@property (nonatomic,strong)UILabel *salaryLabel;
@property (nonatomic,strong)UILabel *cityLabel;

@end

@implementation ChoosePersonView
{
    CGFloat _width;
    CGFloat _height;
}
#pragma mark---object Lifecycle
//autoresizingMask  属性的意思就是自动调整子控件与父控件中间的位置，宽高.
/*
 UIViewAutoresizingNone就是不自动调整。
 UIViewAutoresizingFlexibleLeftMargin 自动调整与superView左边的距离，保证与superView右边的距离不变。
 UIViewAutoresizingFlexibleRightMargin 自动调整与superView的右边距离，保证与superView左边的距离不变。
 UIViewAutoresizingFlexibleTopMargin 自动调整与superView顶部的距离，保证与superView底部的距离不变。
 UIViewAutoresizingFlexibleBottomMargin 自动调整与superView底部的距离，也就是说，与superView顶部的距离不变。
 UIViewAutoresizingFlexibleWidth 自动调整自己的宽度，保证与superView左边和右边的距离不变。
 UIViewAutoresizingFlexibleHeight 自动调整自己的高度，保证与superView顶部和底部的距离不变。
 UIViewAutoresizingFlexibleLeftMargin  |UIViewAutoresizingFlexibleRightMargin 自动调整与superView左边的距离，保证与左边的距离和右边的距离和原来距左边和右边的距离的比例不变。比如原来距离为20，30，调整后的距离应为68，102，即68/20=102/30。
 */
/*
-(instancetype)initWithFrame:(CGRect)frame person:(Person *)person options:(MDCSwipeToChooseViewOptions *)options
{
    self=[super initWithFrame:frame options:options];
    if (self) {
        
        _person=person;
        self.imageView.image=_person.image;
                self.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin;
        self.imageView.autoresizingMask=self.autoresizingMask;
        //创建信息视图
        [self constructInformationView];
    }
    return self;
}
 */
-(instancetype)initWithFrame:(CGRect)frame IosjobInfo:(IosjobInfo *)info options:(MDCSwipeToChooseViewOptions *)options
{
    
    self=[super initWithFrame:frame options:options];
    if (self) {
        _info=info;
        NSString *logoUrl=[@"http://www.lagou.com/" stringByAppendingString:_info.companyLogo];
        [self.imageView setImageWithURL:[NSURL URLWithString:logoUrl]];
        self.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin;
        self.imageView.autoresizingMask=self.autoresizingMask;
        //创建信息视图
        [self constructInformationView];
    }
    return self;
}

#pragma mark--Internal Methods
-(void)constructInformationView
{
    
    CGFloat bottmoHeight=self.bounds.size.height/2;
    CGRect bottomFrame=CGRectMake(0, CGRectGetHeight(self.bounds)-bottmoHeight, CGRectGetWidth(self.bounds), bottmoHeight);
    _informationView=[[UIView alloc]initWithFrame:bottomFrame];
    _width=_informationView.bounds.size.width;
    _height=_informationView.bounds.size.height;
    
    _informationView.backgroundColor=[UIColor colorWithRed:0.947 green:0.962 blue:0.980 alpha:1.000];
    _informationView.clipsToBounds=YES;
    _informationView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:_informationView];
    
    //创建 name   image   imagelabel  朋友 imageLabelview;
    [self constructpositionNameLabel];
    [self constructCompanyNameLabel];
    [self constructCreateTimeLabel];
    [self constructSalaryLabel];
    [self constructCityLabel];
    
}
- (void)constructpositionNameLabel {

    CGRect frame = CGRectMake(_width/5.f,
                              10,
                              _width*3/4,
                              _height/5.f);
    _positionNameLabel = [[UILabel alloc] initWithFrame:frame];
//    _nameLabel.text = [NSString stringWithFormat:@"%@, %@", _person.name, @(_person.age)];//@(_person.age)是将int 转换成 NSNumnber 类型;
    _positionNameLabel.text=@"IOS 开发工程师";
    _positionNameLabel.font=[UIFont boldSystemFontOfSize:18];
    
    [_informationView addSubview:_positionNameLabel];
}
- (void)constructCompanyNameLabel {
    CGRect frame=CGRectMake(_width/5.f, 10+_height/5.f,_width*3/4 , _height/5.f);
    _companyNameLabel=[[UILabel alloc]initWithFrame:frame];
    _companyNameLabel.text=[NSString stringWithFormat:@"公司:  %@",_info.companyName];
    
    _companyNameLabel.font=[UIFont systemFontOfSize:15];
    [_informationView addSubview:_companyNameLabel];
}


- (void)constructCreateTimeLabel {
    CGRect frame=CGRectMake(_width/2.f,_height-20, _width/2.f, 20);
    _createTimeLabel=[[UILabel alloc]initWithFrame:frame];
    _createTimeLabel.text=[NSString stringWithFormat:@"发布时间: %@",_info.createTime];
    
    _createTimeLabel.font=[UIFont boldSystemFontOfSize:12];
    _createTimeLabel.textColor=[UIColor colorWithWhite:0.553 alpha:1.000];
    [_informationView addSubview:_createTimeLabel];
}
-(void)constructCityLabel
{
    CGRect frame=CGRectMake(_width/2.f,_height-40, _width/2.f, 20);
    _cityLabel=[[UILabel alloc]initWithFrame:frame];
    _cityLabel.text=[NSString stringWithFormat:@"工作地: %@",_info.city];
    
    _cityLabel.font=[UIFont systemFontOfSize:13];
    [_informationView addSubview:_cityLabel];
}
- (void)constructSalaryLabel{
    CGRect frame=CGRectMake(_width/5.f, 10+_height*2/5.f,_width*3/4 , _height/5.f);
    _salaryLabel=[[UILabel alloc]initWithFrame:frame];
    _salaryLabel.text=[NSString stringWithFormat:@"工资待遇: %@",_info.salary];
    _salaryLabel.font=[UIFont boldSystemFontOfSize:15];
    [_informationView addSubview:_salaryLabel];
    
}



@end
