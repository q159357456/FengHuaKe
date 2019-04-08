//
//  ZWHVisaCollectionViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/12/20.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHVisaCollectionViewCell.h"

@implementation ZWHVisaCollectionViewCell

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
    //_img.layer.cornerRadius = WIDTH_PRO(8);
    //_img.layer.masksToBounds = YES;
    _img.image = [UIImage imageNamed:PLACEHOLDER];
    
    
    [self.contentView addSubview:_img];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.right.equalTo(self.contentView);
    }];
    
    _titleL = [[UILabel alloc]init];
    _titleL.text = @"泰国";
    _titleL.font = HTFont(28);
    _titleL.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_titleL];
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-HEIGHT_PRO(8));
        make.centerX.equalTo(self.contentView);
    }];

}

-(void)setModel:(CatageModel *)model{
    _model = model;
    _titleL.text = model.title;
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,model.imgsrc]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
}








@end
