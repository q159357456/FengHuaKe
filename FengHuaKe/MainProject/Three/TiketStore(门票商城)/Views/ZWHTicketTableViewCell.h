//
//  ZWHTicketTableViewCell.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/20.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketListModel.h"

@interface ZWHTicketTableViewCell : UITableViewCell

@property(nonatomic,strong)QMUILabel *title;
@property(nonatomic,strong)QMUILabel *city;
@property(nonatomic,strong)QMUILabel *point;
@property(nonatomic,strong)QMUILabel *saleNum;
@property(nonatomic,strong)UIImageView *img;

@property(nonatomic,strong)QMUIFloatLayoutView *tipsView;

@property(nonatomic,strong)QMUILabel *price;

@property(nonatomic,strong)TicketListModel *model;

@property(nonatomic,strong)NSString *tipsStr;


@end
