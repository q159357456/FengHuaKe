//
//  CatageFourCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/28.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "CatageFourCell.h"
#import "CatageModel.h"
@implementation CatageFourCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    // Initialization code
}

-(void)updateCellWithData:(id)data
{
   
     CatageModel *model=(CatageModel*)data;
  
    self.tileLable.text=model.title;
    self.contentLable.text=model.content;
    self.lable2.text=[NSString stringWithFormat:@"%@",model.looknum];
    NSArray *array=[model.fromdate componentsSeparatedByString:@"T"];
    if (array) {
         self.lable3.text=array[0];
    }
   
    [self.desImageView sd_setImageWithURL:[NSURL URLWithString:[DataProcess PicAdress:model.imgsrc]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
    
}
-(void)getRowHeight
{
    NSLog(@"CatageFourCell");
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
