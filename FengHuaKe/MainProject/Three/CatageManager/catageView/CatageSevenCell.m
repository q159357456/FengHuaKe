//
//  CatageSevenCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/12.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "CatageSevenCell.h"
#import "CatageModel.h"
@implementation CatageSevenCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)updateCellWithData:(id)data
{
    CatageModel *model=(CatageModel*)data;
    self.lable1.text=model.title;
    self.cntentTextView.text=model.content;
    self.cntentTextView.text=[NSString stringWithFormat:@"%@",model.looknum];
  
    [self.desImageview sd_setImageWithURL:[NSURL URLWithString:[DataProcess PicAdress:model.imgsrc]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
