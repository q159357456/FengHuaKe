//
//  ZWHMyinsuranceTableViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/9/7.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHMyinsuranceTableViewCell.h"

@implementation ZWHMyinsuranceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
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
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(WIDTH_PRO(8));
        make.width.height.mas_equalTo(WIDTH_PRO(75));
    }];
    
    _title = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:ZWHCOLOR(@"101010")];
    [self.contentView addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_img.mas_right).offset(WIDTH_PRO(15));
        make.top.equalTo(_img.mas_top);
    }];
    
    
    _price = [[QMUILabel alloc]qmui_initWithFont:HTFont(32) textColor:ZWHCOLOR(@"FF9800")];
    [self.contentView addSubview:_price];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_title.mas_left);
        make.bottom.equalTo(_img.mas_bottom);
    }];
}

-(void)setModel:(InsuranceModel *)model{
    _model = model;
    ZWHOrderListModel *listmodel = model.OrderDetail[0];
    _title.text = listmodel.proname;
    _price.text = listmodel.amount;
}







@end
