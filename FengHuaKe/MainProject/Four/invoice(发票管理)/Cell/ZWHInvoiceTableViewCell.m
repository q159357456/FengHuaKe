//
//  ZWHInvoiceTableViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/6.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHInvoiceTableViewCell.h"

@implementation ZWHInvoiceTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    _setdefaultB = [[QMUIButton alloc]qmui_initWithImage:[UIImage imageNamed:@"slected_1"] title:@"设置为默认抬头"];
    _setdefaultB.titleLabel.font = HTFont(28);
    _setdefaultB.spacingBetweenImageAndTitle = WIDTH_PRO(10);
    [_setdefaultB setTitleColor:ZWHCOLOR(@"#6B6F78") forState:0];
    [self.contentView addSubview:_setdefaultB];
    [_setdefaultB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(8));
        make.bottom.equalTo(self.contentView).offset(-HEIGHT_PRO(8));
        //make.width.mas_equalTo(WIDTH_PRO(100));
    }];
    
    //[_setdefaultB setImage:[UIImage imageNamed:@"picture_seleted"] forState:0];
    
    _editB = [[QMUIButton alloc]qmui_initWithImage:[UIImage imageNamed:@"edit"] title:@"编辑"];
    _editB.titleLabel.font = HTFont(28);
    _editB.spacingBetweenImageAndTitle = WIDTH_PRO(5);
    [_editB setTitleColor:ZWHCOLOR(@"#6B6F78") forState:0];
    [self.contentView addSubview:_editB];
    [_editB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(246));
        make.centerY.equalTo(_setdefaultB);
        //make.width.mas_equalTo(WIDTH_PRO(100));
    }];
    
    _deleteB = [[QMUIButton alloc]qmui_initWithImage:[UIImage imageNamed:@"newdelete"] title:@"删除"];
    _deleteB.titleLabel.font = HTFont(28);
    _deleteB.spacingBetweenImageAndTitle = WIDTH_PRO(5);
    [_deleteB setTitleColor:ZWHCOLOR(@"#6B6F78") forState:0];
    [self.contentView addSubview:_deleteB];
    [_deleteB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_editB.mas_right).offset(WIDTH_PRO(18));
        make.centerY.equalTo(_setdefaultB);
        //make.width.mas_equalTo(WIDTH_PRO(100));
    }];
    
    UIView *midline = [[UIView alloc]init];
    midline.backgroundColor = LINECOLOR;
    [self.contentView addSubview:midline];
    [midline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_setdefaultB.mas_top).offset(-HEIGHT_PRO(8));
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    _canpanyName = [[UILabel alloc]init];
    _canpanyName.font = HTFont(28);
    _canpanyName.text = @"某公司";
    [self.contentView addSubview:_canpanyName];
    [_canpanyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(WIDTH_PRO(8));
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(8));
    }];
    _canpanyName.numberOfLines = 0;
    
    _adresspanyName = [[UILabel alloc]init];
    _adresspanyName.font = HTFont(28);
    _adresspanyName.text = @"某地址";
    [self.contentView addSubview:_adresspanyName];
    [_adresspanyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(8));
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(8));
        make.top.equalTo(_canpanyName.mas_bottom).offset(HEIGHT_PRO(10));
        make.bottom.equalTo(midline.mas_top).offset(-HEIGHT_PRO(25));
    }];
    _adresspanyName.numberOfLines = 0;
    
}

-(void)setModel:(ZWHInvoiceModel *)model{
    _model = model;
    _canpanyName.text = _model.companyname;
    _adresspanyName.text = _model.address;
    [_setdefaultB setImage:[UIImage imageNamed:[_model.state integerValue]==1?@"slected_2":@"slected_1"] forState:0];
}


@end
