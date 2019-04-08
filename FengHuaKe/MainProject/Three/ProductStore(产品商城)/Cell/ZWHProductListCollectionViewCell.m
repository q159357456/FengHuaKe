//
//  ZWHProductListCollectionViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/9.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHProductListCollectionViewCell.h"

@implementation ZWHProductListCollectionViewCell

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
    _img.frame = CGRectMake(0, 0, WIDTH_PRO(150), HEIGHT_PRO(150));
    _img.layer.cornerRadius = WIDTH_PRO(8);
    _img.layer.masksToBounds = YES;
    _img.image = [UIImage imageNamed:PLACEHOLDER];
    
    
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT_PRO(150), WIDTH_PRO(150), HEIGHT_PRO(50))];
    backview.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backview];
    [backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(HEIGHT_PRO(70));
    }];
    
    [self.contentView addSubview:_img];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-HEIGHT_PRO(50));
    }];
    
    _titleL = [[UILabel alloc]init];
    _titleL.text = @"某某商品";
    _titleL.font = HTFont(28);
    [backview addSubview:_titleL];
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backview).offset(WIDTH_PRO(8));
        make.top.equalTo(backview).offset(HEIGHT_PRO(25));
        make.right.equalTo(backview).offset(-WIDTH_PRO(8));
    }];
    
    _priceL = [[UILabel alloc]init];
    _priceL.text = @"某某商品";
    _priceL.font = HTFont(28);
    _priceL.textColor = [UIColor redColor];
    [backview addSubview:_priceL];
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backview).offset(WIDTH_PRO(8));
        make.bottom.equalTo(backview).offset(-HEIGHT_PRO(5));
        make.right.equalTo(backview).offset(-WIDTH_PRO(8));
    }];
}

-(void)setModel:(ProductModel *)model{
    _model = model;
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,_model.url]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
    _titleL.text = _model.proname;
    _priceL.text = _model.saleprice;
}

@end
