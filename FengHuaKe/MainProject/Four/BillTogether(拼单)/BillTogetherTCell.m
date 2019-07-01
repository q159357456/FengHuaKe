//
//  BillTogetherTCell.m
//  FengHuaKe
//
//  Created by chenheng on 2019/7/1.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "BillTogetherTCell.h"

@implementation BillTogetherTCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)loadData:(BillTogetherContentModel *)model
{
    self.label1.text = [NSString stringWithFormat:@"%@",model.billno];
    self.label2.text = model.state_text;
    self.label3.text = model.remark;
    self.label4.text = [NSString stringWithFormat:@"已报名:%ld",model.used_nums];
    self.label4.textColor = MAINCOLOR;
    self.label5.text = [NSString stringWithFormat:@"发布时间:%@",model.start_use];
    ImageCacheDefine(self.headImageView, @"");
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
