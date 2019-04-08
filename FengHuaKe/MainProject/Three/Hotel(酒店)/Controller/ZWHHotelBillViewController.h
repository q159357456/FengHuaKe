//
//  ZWHHotelBillViewController.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/24.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHBaseViewController.h"
#import "HotelRoomListModel.h"

@interface ZWHHotelBillViewController : ZWHBaseViewController

@property(nonatomic,strong)HotelRoomListModel *model;


@property(nonatomic,copy)NSString *hotelID;

@property(nonatomic,strong)NSArray *timeArr;

@end
