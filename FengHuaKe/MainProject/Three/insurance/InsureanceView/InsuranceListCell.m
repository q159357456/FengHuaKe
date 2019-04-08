//
//  InsuranceListCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/23.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "InsuranceListCell.h"

@implementation InsuranceListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(InsuranceModel *)model
{
    _model=model;
    [self.logoImage sd_setImageWithURL:[NSURL URLWithString:[DataProcess PicAdress:model.img]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
    self.label1.text=model.codename;
    self.label2.text=model.tips;
    self.lable4.text=[NSString stringWithFormat:@"¥%@",model.minPrice];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
