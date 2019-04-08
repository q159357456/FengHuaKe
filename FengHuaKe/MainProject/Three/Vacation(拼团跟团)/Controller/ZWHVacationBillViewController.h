//
//  ZWHVacationBillViewController.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/28.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHBaseViewController.h"
#import "ZWHTravelModel.h"

@interface ZWHVacationBillViewController : ZWHBaseViewController

@property(nonatomic,strong)ZWHTravelModel *model;

@property(nonatomic,copy)NSString *InsuranceCode;

@property(nonatomic,copy)NSString *prospec;


@end
