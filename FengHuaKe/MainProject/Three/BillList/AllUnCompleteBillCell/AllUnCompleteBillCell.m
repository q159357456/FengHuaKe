//
//  AllUnCompleteBillCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "AllUnCompleteBillCell.h"

@implementation AllUnCompleteBillCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(OrderDetailModel *)model
{
//    ￥
    _model=model;
    self.label1.text=model.billno;
    self.label2.text=model.proname;
    self.label3.text=[NSString stringWithFormat:@"￥%@",model.price];
    self.label4.text=[NSString stringWithFormat:@"X%@",model.num];
    [self.proImage sd_setImageWithURL:[NSURL URLWithString:[DataProcess PicAdress:model.url]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
