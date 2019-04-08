//
//  AppDelegate.h
//  FengHuaKe
//
//  Created by 工博计算机 on 18/3/7.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Hyphenate/Hyphenate.h>
#import "MainTabBarController.h"
#import "LoginViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property(nonatomic,strong)MainTabBarController *mainTabBarController;
@property(nonatomic,strong)LoginViewController *loginViewController;
@property (strong, nonatomic) UIWindow *window;


@end

