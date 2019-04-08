//
//  BillFooterCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "BillFooterCell.h"

@implementation BillFooterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)topay:(UIButton *)sender {
    if (self.gopayBlock) {
        self.gopayBlock();
    }
}
-(void)setButton:(UIButton *)button
{
    _button=button;
    [_button rounded:5];
    _button.backgroundColor=MainColor;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
