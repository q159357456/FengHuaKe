//
//  ZWHOrderDetailViewController.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/8.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWHOrderModel.h"
#import "ZWHOrderListModel.h"

@interface ZWHOrderDetailViewController : UIViewController

//0全部 1待付款 2待发货 3待收货 4待评价
@property(nonatomic,assign)NSInteger state;

@property(nonatomic,strong)ZWHOrderModel *model;

@end
