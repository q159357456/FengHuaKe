//
//  ZWHNewsTableViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/10.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHNewsTableViewCell.h"

@implementation ZWHNewsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}


-(void)setUI{
    CellLine;
    
    
    
    _img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:PLACEHOLDER]];
    [self.contentView addSubview:_img];
    
    
    _titleL = [[UILabel alloc]init];
    _titleL.text = @"-";
    _titleL.font = HTFont(32);
    [self.contentView addSubview:_titleL];
    
    
    _detailL = [[UILabel alloc]init];
    _detailL.text = @"666";
    _detailL.font = HTFont(28);
    [self.contentView addSubview:_detailL];
    
    
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WIDTH_PRO(100));
        make.height.mas_equalTo(HEIGHT_PRO(65));
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(8));
        make.top.equalTo(self.contentView).offset(HEIGHT_PRO(8));
    }];
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_img.mas_right).offset(WIDTH_PRO(8));
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(8));
        make.top.equalTo(_img.mas_top);
    }];
    
    
    [_detailL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(8));
        make.left.equalTo(_img.mas_right).offset(WIDTH_PRO(8));
        make.top.equalTo(_titleL.mas_bottom).offset(HEIGHT_PRO(8));
        make.bottom.equalTo(_img.mas_bottom).offset(-WIDTH_PRO(3));
    }];
    _detailL.numberOfLines = 0;
    
}


-(void)setModel:(CatageModel *)model{
    _model = model;
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,_model.imgsrc]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
    _titleL.text = _model.title;
    _detailL.text = _model.content;
}

@end
