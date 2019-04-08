//
//  ScroChildViewController.h
//  FengHuaKe
//
//  Created by Syrena on 2018/9/21.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHBaseViewController.h"
#import "ScroWeboViewController.h"
#import "ZWHBaseTableView.h"

@interface ScroChildViewController : ZWHBaseViewController


@property(nonatomic,strong)ScroWeboViewController *parentVc;

//页标识
@property (nonatomic, assign) NSInteger index;


@property(nonatomic,strong)ZWHBaseTableView *ticketTable;


@end
