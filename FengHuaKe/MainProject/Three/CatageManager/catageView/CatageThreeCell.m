//
//  CatageThreeCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/28.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "CatageThreeCell.h"

@implementation CatageThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setBiaoji:(UILabel *)biaoji
{
    _biaoji=biaoji;
    _biaoji.backgroundColor=MainColor;
}
-(void)updateCellWithData:(id)data
{
    self.lable.text=(NSString*)data;
}
-(void)getRowHeight
{
    NSLog(@"CatageThreeCell");
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
