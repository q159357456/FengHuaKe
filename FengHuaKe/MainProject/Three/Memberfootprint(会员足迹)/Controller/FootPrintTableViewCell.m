//
//  FootPrintTableViewCell.m
//  FengHuaKe
//
//  Created by chenheng on 2019/4/23.
//  Copyright © 2019年 gongbo. All rights reserved.
//

#import "FootPrintTableViewCell.h"

@implementation FootPrintTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(FootPtintSearchModel *)model
{
    _model = model;
    ImageCacheDefine(self.headImageView, model.logo);
    self.label1.text = model.name;
    self.label2.text = [NSString stringWithFormat:@"人数:%@",model.scale];
    self.label3.text = [NSString stringWithFormat:@"入驻时间:%@",model.registerdate];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
@implementation FootPtintModel



@end

@implementation FootPtintSearchModel



@end
