//
//  ZWHHistoryCollectionViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/6.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHHistoryCollectionViewCell.h"

@implementation ZWHHistoryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setUI{
    _img = [[UIImageView alloc]init];
    _img.image = [UIImage imageNamed:@"WechatIMG2"];
    [self.contentView addSubview:_img];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(HEIGHT_PRO(115));
    }];
    
    _titleL = [[UILabel alloc]init];
    _titleL.text = @"-";
    _titleL.font = HTFont(28);
    _titleL.textColor = ZWHCOLOR(@"#E51C23");
    [self.contentView addSubview:_titleL];
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-HEIGHT_PRO(5));
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(8));
    }];
}

-(void)setModel:(ZWHCollectModel *)model{
    _model = model;
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,_model.url]] placeholderImage:[UIImage imageNamed:@"WechatIMG2"]];
    _titleL.text = [NSString stringWithFormat:@"¥ %@",_model.minPrice];
}


@end
