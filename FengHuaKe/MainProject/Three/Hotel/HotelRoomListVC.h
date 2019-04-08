//
//  HotelRoomListVC.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FreshViewController.h"
#import "HotelListModel.h"
@interface HotelRoomListVC : FreshViewController
@property(nonatomic,copy)NSString *hotelID;
@property(nonatomic,strong)HotelListModel *model;
@end
