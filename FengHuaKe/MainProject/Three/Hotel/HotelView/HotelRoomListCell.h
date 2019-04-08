//
//  HotelRoomListCell.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelRoomListModel.h"
@interface HotelRoomListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoImgeView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UIView *storeView;
@property (weak, nonatomic) IBOutlet UIButton *reserveButton;
@property(nonatomic,strong)HotelRoomListModel *model;
@property(nonatomic,copy)void(^resrveBlock)();
@end
