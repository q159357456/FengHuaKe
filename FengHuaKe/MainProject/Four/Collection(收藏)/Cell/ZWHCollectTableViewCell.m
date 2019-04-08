//
//  ZWHCollectTableViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/6.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHCollectTableViewCell.h"

@implementation ZWHCollectTableViewCell

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
    _img.image = [UIImage imageNamed:@"WechatIMG2"];
    [self.contentView addSubview:_img];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(WIDTH_PRO(8));
        make.top.mas_equalTo(self.contentView).offset(HEIGHT_PRO(8));
        make.bottom.mas_equalTo(self.contentView).offset(-HEIGHT_PRO(8));
        make.width.mas_equalTo(_img.mas_height);
    }];
    
    _nameL = [[UILabel alloc]init];
    _nameL.font =HTFont(28);
    _nameL.textColor = [UIColor blackColor];
    _nameL.text = @"标题";
    [self.contentView addSubview:_nameL];
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_img.mas_top);
        make.left.equalTo(_img.mas_right).offset(WIDTH_PRO(15));
    }];
    
    _priceL = [[UILabel alloc]init];
    _priceL.font =HTFont(26);
    _priceL.textColor = [UIColor redColor];
    _priceL.text = @"¥ 39.4";
    [self.contentView addSubview:_priceL];
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_img.mas_bottom);
        make.left.equalTo(_img.mas_right).offset(WIDTH_PRO(15));
    }];
}

-(void)setModel:(ZWHCollectModel *)model{
    _model = model;
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,_model.url]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
    _nameL.text = _model.proname;
    _priceL.text = [NSString stringWithFormat:@"¥ %@",_model.minPrice];
}


@end
