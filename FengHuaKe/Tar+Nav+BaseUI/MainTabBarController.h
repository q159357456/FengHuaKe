//
//  MainTabBarController.h
//  Restaurant
//
//  Created by 张帆 on 16/8/15.
//  Copyright © 2016年 工博计算机. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import "GBNavigationController.h"
#import "ContactListViewController.h"
#import "CatageManagerVC.h"
#import "ConversationListController.h"
#import "MineViewController.h"
#import "ZWHSystemHomeViewController.h"
@interface MainTabBarController : UITabBarController
@property (nonatomic, strong) ConversationListController *chatListVC;
@property (nonatomic, strong) ContactListViewController *contactsVC;
@property (nonatomic, strong) CatageManagerVC *catageManagerVC;
@property (nonatomic, strong) MineViewController *mineViewController;

@property (nonatomic, strong) ZWHSystemHomeViewController *systemHome;

//跳转到回话列表
- (void)jumpToChatList;
//设置未处理的好友申请
- (void)setupUntreatedApplyCount;
//设置未处理的消息
- (void)setupUnreadMessageCount;
//网络发生变化
- (void)networkChanged:(EMConnectionState)connectionState;
//收到本地通知
- (void)didReceiveLocalNotification:(UILocalNotification *)notification;
//收到通知
- (void)didReceiveUserNotification:(UNNotification *)notification;
//播放声音
- (void)playSoundAndVibration;
//展示消息通知
- (void)showNotificationWithMessage:(EMMessage *)message;
@end
