//
//  RoomBillHeaderCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "RoomBillHeaderCell.h"

@implementation RoomBillHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.lable removeFromSuperview];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
