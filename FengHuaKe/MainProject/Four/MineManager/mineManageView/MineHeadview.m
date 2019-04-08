//
//  MineHeadview.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/29.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "MineHeadview.h"


@implementation MineHeadview

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)outLogin:(UIButton *)sender {
    if (self.funBlock) {
        self.funBlock(nil);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
