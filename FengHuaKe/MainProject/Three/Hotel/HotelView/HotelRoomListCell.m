//
//  HotelRoomListCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "HotelRoomListCell.h"
#import "NSString+Addition.h"
@implementation HotelRoomListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setReserveButton:(UIButton *)reserveButton
{
    _reserveButton=reserveButton;
    [_reserveButton rounded:6];
    _reserveButton.backgroundColor=MainColor;
}
- (IBAction)reserve:(UIButton *)sender {
    if (self.resrveBlock) {
        self.resrveBlock();
    }
}
-(void)setModel:(HotelRoomListModel *)model
{
    _model=model;
    [self.logoImgeView sd_setImageWithURL:[NSURL URLWithString:[DataProcess PicAdress:[model.url URLEncodedString]]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
//     NSLog(@"DataProcess:%@",[DataProcess PicAdress:model.url]);
    self.label1.text=model.proname;
    self.label2.text=[NSString stringWithFormat:@"%@|%@|%@",model.spec,model.modelnum,model.material];
    NSString *text=[NSString stringWithFormat:@"¥%@起",model.saleprice1];
        NSRange range1=[text rangeOfString:[NSString stringWithFormat:@"¥%@",model.saleprice1]];
        NSRange range2=[text rangeOfString:@"起"];
    self.label3.attributedText=[text Color:[UIColor redColor] ColorRange:range1 Font:[UIFont systemFontOfSize:10] FontRange:range2];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
