//
//  ZWHHotelRoomTableViewCell.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/23.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HotelRoomListModel.h"

@interface ZWHHotelRoomTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *img;

@property(nonatomic,strong)QMUILabel *title;
@property(nonatomic,strong)QMUILabel *detail;
@property(nonatomic,strong)QMUILabel *price;

@property(nonatomic,strong)QMUIButton *collect;
@property(nonatomic,strong)QMUIButton *pay;


@property(nonatomic,strong)HotelRoomListModel *model;



@end
