//
//  GroupComonSetCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/22.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "GroupComonSetCell.h"

@implementation GroupComonSetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)updateCellWithData:(id)data
{
    self.titleLable.text=data;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
