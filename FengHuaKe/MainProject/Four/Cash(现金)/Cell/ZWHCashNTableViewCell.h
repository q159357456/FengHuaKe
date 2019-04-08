//
//  ZWHCashNTableViewCell.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/1.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWHBillModel.h"

@interface ZWHCashNTableViewCell : UITableViewCell

//0消费记录 1积分记录 2佣金
@property(nonatomic,strong)NSString *state;

@property(nonatomic,strong)UILabel *typeL;
@property(nonatomic,strong)UILabel *timeL;
@property(nonatomic,strong)UILabel *moneyL;
@property(nonatomic,strong)ZWHBillModel *model;

@end
