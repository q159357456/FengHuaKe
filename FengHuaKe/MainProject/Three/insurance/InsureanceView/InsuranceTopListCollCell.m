//
//  InsuranceTopListCollCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/23.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "InsuranceTopListCollCell.h"
#import "NSString+Addition.h"
@implementation InsuranceTopListCollCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(InsuranceModel *)model
{
    _model=model;
    [self.logoImage rounded:6];
    [self.logoImage sd_setImageWithURL:[NSURL URLWithString:[DataProcess PicAdress:model.img]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
    self.lable1.text=model.codename;
    NSString *text=[NSString stringWithFormat:@"¥%@起",model.minPrice];
    NSRange range1=[text rangeOfString:[NSString stringWithFormat:@"¥%@",model.minPrice]];
    NSRange range2=[text rangeOfString:@"起"];
    self.lable2.attributedText=[text Color:[UIColor redColor] ColorRange:range1 Font:[UIFont systemFontOfSize:10] FontRange:range2];
}
@end
