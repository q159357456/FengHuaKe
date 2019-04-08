//
//  HotelListCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "HotelListCell.h"
#import "NSString+Addition.h"
@implementation HotelListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(HotelListModel *)model
{
    _model=model;
    [self.logoImaheView sd_setImageWithURL:[NSURL URLWithString:[DataProcess PicAdress:model.LogoUrl]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
   
    self.label1.text=model.ShopName;
    self.label2.text=[NSString stringWithFormat:@"%@分",model.grade];
    self.label2.textColor=MainColor;
    self.label3.text=[NSString stringWithFormat:@"评论数:%@+",model.commentnums];
    self.label3.textColor=[UIColor darkGrayColor];
    self.label4.text=[NSString stringWithFormat:@"%@%@%@",model.provName,model.cityName,model.boroName];
    NSString *text=[NSString stringWithFormat:@"¥%@起",model.minPrice];
    NSRange range1=[text rangeOfString:[NSString stringWithFormat:@"¥%@",model.minPrice]];
    NSRange range2=[text rangeOfString:@"起"];
    self.label5.attributedText=[text Color:[UIColor redColor] ColorRange:range1 Font:[UIFont systemFontOfSize:10] FontRange:range2];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
