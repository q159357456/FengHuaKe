//
//  ConversationListController.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/13.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EaseUI.h"
@interface ConversationListController : EaseConversationListViewController
//内存中刷新页面
- (void)refresh;
//下拉加载更多
- (void)refreshDataSource;
//网络连接断开否
- (void)isConnect:(BOOL)isConnect;
- (void)networkChanged:(EMConnectionState)connectionState;
@end
