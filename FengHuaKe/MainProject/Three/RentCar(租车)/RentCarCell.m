//
//  RentCarCell.m
//  FengHuaKe
//
//  Created by chenheng on 2019/4/12.
//  Copyright © 2019年 gongbo. All rights reserved.
//

#import "RentCarCell.h"

@implementation RentCarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(RentCarModel *)model
{
    _model = model;
    self.label2.text = model.tips;
    self.label1.text = model.name;
    self.label4.text = [NSString stringWithFormat:@"共完后才能%ld个订单",model.quantity];
    self.label5.text = [NSString stringWithFormat:@"好评率:%02ld%%",model.evaluate_01*100/model.quantity];
    ImageCacheDefine(self.headImageView, model.logonurl);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation RentCarModel



@end
