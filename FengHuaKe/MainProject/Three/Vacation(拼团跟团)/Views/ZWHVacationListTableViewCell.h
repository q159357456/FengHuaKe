//
//  ZWHVacationListTableViewCell.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/27.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TravelListModel.h"

@interface ZWHVacationListTableViewCell : UITableViewCell

@property(nonatomic,strong)QMUILabel *price;
@property(nonatomic,strong)QMUILabel *title;
@property(nonatomic,strong)QMUILabel *detail;

@property(nonatomic,strong)UIImageView *img;

@property(nonatomic,strong)TravelListModel *model;



@end
