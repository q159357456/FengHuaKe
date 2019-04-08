//
//  ZWHOrderAdressTableViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/9.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHOrderAdressTableViewCell.h"

@implementation ZWHOrderAdressTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    UIImageView *img = [[UIImageView alloc]init];
    img.image = [UIImage imageNamed:@"address"];
    [self.contentView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(8));
        make.width.height.mas_equalTo(WIDTH_PRO(30));
    }];
    
    _manL = [[UILabel alloc]init];
    _manL.text = @"收货人:";
    _manL.textColor = ZWHCOLOR(@"#4BA4FF");
    _manL.font = HTFont(28);
    [self.contentView addSubview:_manL];
    [_manL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(HEIGHT_PRO(8));
        make.left.equalTo(img.mas_right).offset(WIDTH_PRO(8));
    }];
    
    _adressL = [[UILabel alloc]init];
    _adressL.text = @"收货地址:";
    _adressL.textColor = ZWHCOLOR(@"#676D7A");
    _adressL.font = HTFont(24);
    [self.contentView addSubview:_adressL];
    [_adressL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-HEIGHT_PRO(8));
        make.left.equalTo(img.mas_right).offset(WIDTH_PRO(8));
    }];
    
    
    _phoneL = [[UILabel alloc]init];
    _phoneL.text = @"1888";
    //_phoneL.textColor = ZWHCOLOR(@"4BA4FF");
    _phoneL.font = HTFont(28);
    _phoneL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_phoneL];
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(HEIGHT_PRO(8));
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(8));
    }];
}


@end
