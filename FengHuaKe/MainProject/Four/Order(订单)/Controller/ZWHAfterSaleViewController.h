//
//  ZWHAfterSaleViewController.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/29.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHBaseViewController.h"
#import "ZWHOrderListModel.h"

@interface ZWHAfterSaleViewController : ZWHBaseViewController

@property(nonatomic,strong)ZWHOrderListModel *model;

//售后详情数据 //若不为空 则是展示申请售后信息
@property(nonatomic,strong)ZWHOrderListModel *Aftermodel;

@end
