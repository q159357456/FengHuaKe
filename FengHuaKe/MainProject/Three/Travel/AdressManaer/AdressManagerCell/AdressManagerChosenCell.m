//
//  AdressManagerChosenCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/14.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "AdressManagerChosenCell.h"

@implementation AdressManagerChosenCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.adressLbale=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-200, 10, 170, 20)];
        self.adressLbale.textAlignment=NSTextAlignmentRight;
        self.adressLbale.font=HTFont(28);
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        [self.contentView addSubview:self.adressLbale];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
