//
//  TiketHotCollecCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/20.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "TiketHotCollecCell.h"
#import "NSString+Addition.h"
@implementation TiketHotCollecCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(TravelListModel *)model
{
    _model=model;
    [self.logoImage rounded:6];
    [self.logoImage sd_setImageWithURL:[NSURL URLWithString:[DataProcess PicAdress:model.url]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
    self.lable1.text=model.proname;
    NSString *text=[NSString stringWithFormat:@"¥%@起",model.saleprice];
    NSRange range1=[text rangeOfString:[NSString stringWithFormat:@"¥%@",model.saleprice]];
    NSRange range2=[text rangeOfString:@"起"];
    self.lable2.attributedText=[text Color:[UIColor redColor] ColorRange:range1 Font:[UIFont systemFontOfSize:10] FontRange:range2];
}
@end
