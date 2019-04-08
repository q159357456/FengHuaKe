//
//  NoticeTableViewCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/22.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "NoticeTableViewCell.h"

@implementation NoticeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setLable1:(UILabel *)lable1
{
    _lable1=lable1;
    _lable1.font=[UIFont boldSystemFontOfSize:14];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
