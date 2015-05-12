//
//  AppDelegate.h
//  ZYMoreWork
//
//  Created by qianfeng on 15/4/30.
//  Copyright (c) 2015年 core. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "DNWRootViewController.h"

//环信
//#import "ApplyViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
//
//{
//    EMConnectionState _connectionState;
//}


@property (strong, nonatomic) UIWindow *window;
//写到.h的原因是,可以把它当成全局变量,当我们要做某些操作的时候,可以随时使用;
@property (strong,nonatomic)BaseTabBarViewController *tabbarController;

@property (strong,nonatomic)DNWRootViewController *menuViewController;
//获取全局的简单模式
+(AppDelegate *)shareDelegate;



@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

