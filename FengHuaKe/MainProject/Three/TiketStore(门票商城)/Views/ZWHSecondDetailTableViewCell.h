//
//  ZWHSecondDetailTableViewCell.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/21.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TicketSingleModel.h"

@interface ZWHSecondDetailTableViewCell : UITableViewCell

@property(nonatomic,strong)QMUILabel *title;
@property(nonatomic,strong)QMUILabel *price;
@property(nonatomic,strong)QMUILabel *explan;
@property(nonatomic,strong)QMUILabel *saleNum;

@property(nonatomic,strong)QMUIButton *payExplan;
@property(nonatomic,strong)QMUIButton *payNow;

@property(nonatomic,strong)TicketSubSonModel *model;



@end
