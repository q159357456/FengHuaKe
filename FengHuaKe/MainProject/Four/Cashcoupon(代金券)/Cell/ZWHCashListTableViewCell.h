//
//  ZWHCashListTableViewCell.h
//  FengHuaKe
//
//  Created by Syrena on 2018/7/30.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWHCashcoupon.h"

@interface ZWHCashListTableViewCell : UITableViewCell

//0 未使用 1 已使用 2 已过期
@property(nonatomic,assign)NSInteger stateIndex;
@property(nonatomic,strong)QMUILabel *moneyL;
@property(nonatomic,strong)QMUILabel *explainL;
@property(nonatomic,strong)UILabel *detailL;
@property(nonatomic,strong)QMUILabel *dayL;
@property(nonatomic,strong)UILabel *tagMoney;
@property(nonatomic,strong)QMUILabel *dashPhaseLab;
@property(nonatomic,strong)UIView *topBackView;
@property(nonatomic,strong)UILabel *typeMoney;

@property(nonatomic,strong)ZWHCashcoupon *model;

@end
