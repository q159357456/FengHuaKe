//
//  ZWHSecondDetailTableViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/21.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHSecondDetailTableViewCell.h"

@implementation ZWHSecondDetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    CellLine;
    
    _title = [[QMUILabel alloc]qmui_initWithFont:HTFont(24) textColor:ZWHCOLOR(@"#676D7A")];
    [self.contentView addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(8));
        make.top.equalTo(self.contentView).offset(HEIGHT_PRO(3));
        make.height.mas_equalTo(HEIGHT_PRO(25));
    }];
    
    _explan = [[QMUILabel alloc]qmui_initWithFont:HTFont(24) textColor:MAINCOLOR];
    [self.contentView addSubview:_explan];
    [_explan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(8));
        make.top.equalTo(_title.mas_bottom).offset(HEIGHT_PRO(3));
        //make.height.mas_equalTo(HEIGHT_PRO(25));
    }];
    
    _saleNum = [[QMUILabel alloc]qmui_initWithFont:HTFont(24) textColor:ZWHCOLOR(@"#676D7A")];
    [self.contentView addSubview:_saleNum];
    [_saleNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(8));
        make.top.equalTo(_explan.mas_bottom).offset(HEIGHT_PRO(3));
        make.bottom.equalTo(self.contentView).offset(-WIDTH_PRO(8));
        //make.height.mas_equalTo(HEIGHT_PRO(25));
    }];
    
    _price = [[QMUILabel alloc]qmui_initWithFont:HTFont(32) textColor:[UIColor redColor]];
    [self.contentView addSubview:_price];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(20));
        make.centerY.equalTo(_title);
    }];
    
    _payExplan = [[QMUIButton alloc]init];
    _payExplan.titleLabel.font = HTFont(24);
    [_payExplan setTitleColor:ZWHCOLOR(@"#676D7A") forState:0];
    [_payExplan setTitle:@"购买须知>" forState:0];
    [self.contentView addSubview:_payExplan];
    [_payExplan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_saleNum.mas_right).offset(WIDTH_PRO(15));
        make.centerY.equalTo(_saleNum);
    }];
    
    _payNow = [[QMUIButton alloc]init];
    _payNow.titleLabel.font = HTFont(24);
    [_payNow setTitleColor:[UIColor whiteColor] forState:0];
    [_payNow setTitle:@"立即预定" forState:0];
    _payNow.backgroundColor = MAINCOLOR;
    _payNow.layer.cornerRadius = 5;
    _payNow.layer.masksToBounds = YES;
    [self.contentView addSubview:_payNow];
    [_payNow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(15));
        make.width.mas_equalTo(WIDTH_PRO(70));
        make.height.mas_equalTo(HEIGHT_PRO(25));
        make.bottom.equalTo(self.contentView).offset(-WIDTH_PRO(8));
    }];
    
}

-(void)setModel:(TicketSubSonModel *)model{
    _model = model;
    _title.text = _model.spec;
    _explan.text = _model.property;
    _saleNum.text = [NSString stringWithFormat:@"已售%@",_model.ratio];
    _price.text = [NSString stringWithFormat:@"¥%@",_model.saleprice1];
}


@end
