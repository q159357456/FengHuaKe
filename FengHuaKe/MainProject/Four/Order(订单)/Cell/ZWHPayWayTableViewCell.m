//
//  ZWHPayWayTableViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/9.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHPayWayTableViewCell.h"

@implementation ZWHPayWayTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    CellLine
    _img = [[UIImageView alloc]init];
    _img.image = [UIImage imageNamed:PLACEHOLDER];
    [self.contentView addSubview:_img];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(8));
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(WIDTH_PRO(30));
        make.width.mas_equalTo(WIDTH_PRO(35));
    }];
    
    _titleL = [[UILabel alloc]init];
    _titleL.text = @"支付方式";
    _titleL.font = HTFont(28);
    [self.contentView addSubview:_titleL];
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_img);
        make.left.equalTo(_img.mas_right).offset(WIDTH_PRO(8));
    }];
    
    _select = [[UIImageView alloc]init];
    _select.image = [UIImage imageNamed:@"picture_selet"];
    [self.contentView addSubview:_select];
    [_select mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(8));
        make.top.equalTo(self.contentView).offset(HEIGHT_PRO(15));
        make.bottom.equalTo(self.contentView).offset(-HEIGHT_PRO(15));
        make.width.mas_equalTo(_select.mas_height);
    }];
    
}


@end
