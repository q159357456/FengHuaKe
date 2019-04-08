//
//  ZWHAfterListTableViewCell.h
//  FengHuaKe
//
//  Created by Syrena on 2018/9/6.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWHOrderListModel.h"

@interface ZWHAfterListTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *img;
@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UILabel *priceL;
@property(nonatomic,strong)UILabel *numL;

@property(nonatomic,strong)QMUILabel *timeL;

@property(nonatomic,strong)UIButton *aftersale;

@property(nonatomic,strong)ZWHOrderListModel *model;

@end
