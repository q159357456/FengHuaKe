//
//  ZWHClassiftRightCollectionViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/27.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHClassiftRightCollectionViewCell.h"

@implementation ZWHClassiftRightCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setUI{
    _img = [[UIImageView alloc]init];
    _img.frame = CGRectMake(0, 0, WIDTH_PRO(150), HEIGHT_PRO(150));
    _img.layer.cornerRadius = WIDTH_PRO(8);
    _img.layer.masksToBounds = YES;
    _img.image = [UIImage imageNamed:PLACEHOLDER];
    
    
    
    [self.contentView addSubview:_img];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.height.mas_equalTo(HEIGHT_PRO(130));
    }];
    
    _titleL = [[UILabel alloc]init];
    _titleL.text = @"-";
    _titleL.textAlignment = NSTextAlignmentCenter;
    _titleL.font = HTFont(28);
    [self.contentView addSubview:_titleL];
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_img.mas_bottom).offset(HEIGHT_PRO(3));
        make.centerX.equalTo(_img);
    }];
}

-(void)setModel:(ClassifyModel *)model{
    _model = model;
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,_model.icon]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
    _titleL.text = _model.name;
}


@end
