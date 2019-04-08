//
//  ZWHMyinsuranceTableViewCell.h
//  FengHuaKe
//
//  Created by Syrena on 2018/9/7.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InsuranceModel.h"
#import "ZWHOrderListModel.h"

@interface ZWHMyinsuranceTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *img;
@property(nonatomic,strong)QMUILabel *title;
@property(nonatomic,strong)QMUILabel *price;

@property(nonatomic,strong)InsuranceModel *model;

@end
