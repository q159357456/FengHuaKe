//
//  MineTwoCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/29.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "MineTwoCell.h"

@implementation MineTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)updateCellWithData:(id)data
{
    NSArray *array=(NSArray*)data;
    self.lable.text=array[0];
    self.imageview.image=[UIImage imageNamed:array[1]];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
