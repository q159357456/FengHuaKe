//
//  TicketViewCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/20.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "TicketViewCell.h"
#import "NSString+Addition.h"
@implementation TicketViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(TicketListModel *)model
{
    _model=model;
    [self.logoImage rounded:6];
    [self.logoImage sd_setImageWithURL:[NSURL URLWithString:[DataProcess PicAdress:model.url]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
    self.label1.text=model.proname;
    self.label2.text=[NSString stringWithFormat:@"%@%@%@",model.brand,model.fitsex,model.material];
    self.label3.text=[NSString stringWithFormat:@"%@",model.grade];
    self.label3.textColor=MainColor;
    NSString *text=[NSString stringWithFormat:@"¥%@起",model.minPrice];
    NSRange range1=[text rangeOfString:[NSString stringWithFormat:@"¥%@",model.minPrice]];
    NSRange range2=[text rangeOfString:@"起"];
    self.lable4.attributedText=[text Color:[UIColor redColor] ColorRange:range1 Font:[UIFont systemFontOfSize:10] FontRange:range2];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
