//
//  RoomBillCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "RoomBillCell.h"
#define PublishFont [UIFont systemFontOfSize:14]
@implementation RoomBillCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat inputWith=ScreenWidth-8-self.lable.width-10-20;
        self.inputTextField=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.lable.frame)+10, 4, inputWith, 35)];
        [self.contentView addSubview:self.inputTextField];
        self.inputTextField.textAlignment=NSTextAlignmentLeft;
        self.inputTextField.font=PublishFont;
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
