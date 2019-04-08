//
//  SearchFriendCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "SearchFriendCell.h"

@implementation SearchFriendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (IBAction)agreen:(UIButton *)sender {
    if (self.addFriendsBlock) {
         self.addFriendsBlock();
    }
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
