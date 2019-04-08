//
//  HotelListCell.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelListModel.h"
@interface HotelListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoImaheView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property(nonatomic,strong)HotelListModel *model;
@end
