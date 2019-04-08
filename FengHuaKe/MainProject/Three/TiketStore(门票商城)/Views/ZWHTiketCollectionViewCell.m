//
//  ZWHTiketCollectionViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/17.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHTiketCollectionViewCell.h"

@implementation ZWHTiketCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


-(void)setUI{
    _img = [[UIImageView alloc]init];
    _img.backgroundColor = randomColor;
    _img.layer.cornerRadius = 5;
    _img.layer.masksToBounds = YES;
    [self.contentView addSubview:_img];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(HEIGHT_PRO(105));
        make.top.equalTo(self.contentView);
    }];
    
    _title = [[QMUILabel alloc]init];
    _title.font = HTFont(22);
    _title.text = @"-";
    [self.contentView addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(_img.mas_bottom);
    }];
    
    _price = [[QMUILabel alloc]init];
    _price.font = HTFont(28);
    _price.text = @"-";
    [self.contentView addSubview:_price];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(_title.mas_bottom);
    }];
}

-(void)setModel:(TravelListModel *)model{
    _model = model;
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,_model.url]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
    _title.text=model.proname;
    NSString *text=[NSString stringWithFormat:@"¥%@起",model.saleprice];
    NSRange range1=[text rangeOfString:[NSString stringWithFormat:@"¥%@",model.saleprice]];
    NSRange range2=[text rangeOfString:@"起"];
    _price.attributedText=[text Color:[UIColor redColor] ColorRange:range1 Font:[UIFont systemFontOfSize:10] FontRange:range2];
}



@end
