//
//  ZWHHotelHomeTableViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/23.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHHotelHomeTableViewCell.h"

@implementation ZWHHotelHomeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    UIView *butomLineZWH = [[UIView alloc]init];
    butomLineZWH.backgroundColor = LINECOLOR;
    [self.contentView addSubview:butomLineZWH];
    [butomLineZWH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(10));
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(8));
    }];
    
    
    _title = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:ZWHCOLOR(@"#808080")];
    [self.contentView addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(8));
    }];
    
    _name = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:[UIColor blackColor]];
    [self.contentView addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(81));
    }];
    _name.text = @"-";
    
    _Location = [[QMUIButton alloc]qmui_initWithImage:[UIImage imageNamed:@"address"] title:@"定位"];
    _Location.tintColorAdjustsTitleAndImage = ZWHCOLOR(@"#AAAAAA");
    _Location.imagePosition = QMUIButtonImagePositionLeft;
    _Location.spacingBetweenImageAndTitle = 2;
    _Location.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _Location.titleLabel.font = HTFont(24);
    [self.contentView addSubview:_Location];
    [_Location mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(15));
        make.centerY.equalTo(self.contentView);
    }];
    _Location.enabled = NO;
    
    _right = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"right_t"]];
    [self.contentView addSubview:_right];
    [_right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(15));
        make.centerY.equalTo(self.contentView);
    }];
    
    
}







@end
