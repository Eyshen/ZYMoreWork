//
//  ITViewController.h
//  ZYMoreWork
//
//  Created by qianfeng on 15/5/7.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import "BaseViewController.h"
#import "ChoosePersonView.h"

@interface ITViewController : BaseViewController<MDCSwipeToChooseDelegate>

//@property (nonatomic,strong)Person *currentPerson;
@property (nonatomic,strong)IosjobInfo *currentInfo;

@property (nonatomic,strong)ChoosePersonView *frontCardView;
@property (nonatomic,strong)ChoosePersonView *backCardView;
@end
