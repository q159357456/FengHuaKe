//
//  ZWHHotelHomeSectionTableViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/23.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHHotelHomeSectionTableViewCell.h"

@implementation ZWHHotelHomeSectionTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    _title = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:ZWHCOLOR(@"#808080")];
    [self.contentView addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(8));
    }];
    
    _name = [[QMUITextField alloc]init];
    _name.font = HTFont(28);
    _name.textColor = [UIColor blackColor];
    [self.contentView addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(81));
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(15));
        make.top.equalTo(self.contentView).offset(3);
        make.bottom.equalTo(self.contentView).offset(-3);
    }];
    _name.layer.cornerRadius = 5;
    _name.layer.masksToBounds = YES;
    _name.layer.borderColor = LINECOLOR.CGColor;
    _name.layer.borderWidth = 1;
}



@end
