//
//  RoomBillBaseCell.m
//  ZHONGHUILAOWU
//
//  Created by 秦根 on 2018/5/9.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "RoomBillBaseCell.h"

@implementation RoomBillBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.lable=[[UILabel alloc]initWithFrame:CGRectMake(8, 10,70, 23)];
        self.lable.font=[UIFont systemFontOfSize:14];
        [self addSubview:self.lable];
        
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder]) {
        self.lable=[[UILabel alloc]initWithFrame:CGRectMake(8, 10,70, 23)];
        self.lable.font=[UIFont systemFontOfSize:14];
        [self addSubview:self.lable];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
