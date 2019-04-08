//
//  ZWHAfterListTableViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/9/6.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHAfterListTableViewCell.h"

@implementation ZWHAfterListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    CellLine;
    
    _img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"WechatIMG2"]];
    _img.layer.cornerRadius = 6;
    _img.layer.masksToBounds = YES;
    [self.contentView addSubview:_img];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(WIDTH_PRO(60));
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(8));
    }];
    
    _titleL = [[UILabel alloc]init];
    _titleL.text =@"adasd";
    _titleL.font = HTFont(28);
    [self.contentView addSubview:_titleL];
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_img.mas_right).offset(WIDTH_PRO(8));
        make.top.equalTo(_img.mas_top);
    }];
    
    _priceL = [[UILabel alloc]init];
    _priceL.text =@"¥36.5";
    _priceL.font = HTFont(24);
    [self.contentView addSubview:_priceL];
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_img.mas_right).offset(WIDTH_PRO(8));
        make.top.equalTo(_titleL.mas_bottom).offset(HEIGHT_PRO(8));
    }];
    
    _timeL = [[QMUILabel alloc]qmui_initWithFont:HTFont(24) textColor:[UIColor blackColor]];
    _timeL.text =@"";
    _timeL.font = HTFont(24);
    [self.contentView addSubview:_timeL];
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_img.mas_right).offset(WIDTH_PRO(8));
        make.bottom.equalTo(_img.mas_bottom);
    }];
    
    _numL = [[UILabel alloc]init];
    _numL.text =@"×5";
    _numL.font = HTFont(24);
    [self.contentView addSubview:_numL];
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(8));
        make.top.equalTo(_titleL.mas_bottom);
    }];
    
    _aftersale = [UIButton buttonWithType:UIButtonTypeCustom];
    [_aftersale setTitle:@"申请售后" forState:0];
    [self setblueBtnWith:_aftersale];
    [self.contentView addSubview:_aftersale];
    [_aftersale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-HEIGHT_PRO(3));
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(8));
        make.height.mas_equalTo(HEIGHT_PRO(30));
        make.width.mas_equalTo(WIDTH_PRO(70));
    }];
    
    _aftersale.hidden = YES;
}

-(void)setModel:(ZWHOrderListModel *)model{
    _model=model;
    self.titleL.text=model.proname;
    self.priceL.text=[NSString stringWithFormat:@"￥%@",model.price];
    self.numL.text=[NSString stringWithFormat:@"×%@",model.num];
    //_timeL.text = _model.
    [self.img sd_setImageWithURL:[NSURL URLWithString:[DataProcess PicAdress:model.url]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
}

//蓝色设置
-(void)setblueBtnWith:(UIButton *)btn{
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [ZWHCOLOR(@"#4BA4FF") CGColor];
    btn.titleLabel.font = HTFont(28);
    btn.backgroundColor = ZWHCOLOR(@"#4BA4FF");
}

@end
