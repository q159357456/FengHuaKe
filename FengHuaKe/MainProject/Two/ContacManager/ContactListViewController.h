//
//  ContactListViewController.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/13.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EaseUI.h"
@interface ContactListViewController : ZWHBaseViewController
//好友请求变化时，更新好友请求未处理的个数
- (void)reloadApplyView;

//群组变化时，更新群组页面
- (void)reloadGroupView;

//好友个数变化时，重新获取数据
- (void)reloadDataSource;

//添加好友的操作被触发
- (void)addFriendAction;

//好友关系建立
-(void)addFriendReationshipWithuserID:(NSString*)userid FriendType:(NSString*)freindType;
//删除好友后 mysever删除
-(void)deletReationshipWithuserID:(NSString*)userid FriendType:(NSString*)freindType;

@end
