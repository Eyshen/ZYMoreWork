//
//  ImageLabelView.m
//  tantanDemo
//
//  Created by qianfeng on 15/5/6.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "ImageLabelView.h"

@interface ImageLabelView ()

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *label;
@end


@implementation ImageLabelView

#pragma mark---项目生命周期
-(id)initWithFrame:(CGRect)frame image:(UIImage *)image text:(NSString *)text
{
    self=[super initWithFrame:frame];
    if (self) {
        [self constructImageView:image];
        [self constructLabel:text];
    }
    return self;
}
#pragma mark---Internal Methods  内部方法
-(void)constructImageView:(UIImage *)image
{
    CGFloat topPadding=10.f;
    //floorf 是向下取整;
    CGRect frame=CGRectMake(floorf(CGRectGetWidth(self.bounds)-image.size.width/2), topPadding, image.size.width, image.size.height);
    self.imageView=[[UIImageView alloc]initWithFrame:frame];
    self.imageView.image=image;
    [self addSubview:self.imageView];
    
}

-(void)constructLabel:(NSString *)text
{
    CGFloat height=18.f;
    CGRect frame=CGRectMake(0, CGRectGetMaxY(self.imageView.frame), CGRectGetWidth(self.bounds), height);
    self.label=[[UILabel alloc]initWithFrame:frame];
    self.label.text=text;
    self.label.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.label];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
