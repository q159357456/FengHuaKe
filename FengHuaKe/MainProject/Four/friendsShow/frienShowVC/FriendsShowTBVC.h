//
//  FriendsShowTBVC.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/3.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsShowTBVC : ZWHBaseViewController
@property (nonatomic, strong) NSMutableArray *dataArray;

//是否是单个朋友圈
@property (nonatomic, assign) BOOL isSingle;
@property (nonatomic, copy) NSString *singleUserid;


@end
