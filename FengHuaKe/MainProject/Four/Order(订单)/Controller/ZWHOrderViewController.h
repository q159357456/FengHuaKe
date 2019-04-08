//
//  ZWHOrderViewController.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/8.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWHOrderViewController : UIViewController

@property(nonatomic,assign)NSInteger index;

//订单类型
/*
hotel：酒店；
insure：保险；
travel：旅游；
tickets：门票；
store：商城；
all：所有的订单(酒店|旅游|商城|餐饮)
*/
@property(nonatomic,copy)NSString *poType;


@end
