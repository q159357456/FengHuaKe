//
//  ZWHCashNTableViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/1.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHCashNTableViewCell.h"

@implementation ZWHCashNTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    CellLine
    _typeL = [[UILabel alloc]init];
    _typeL.text = @"门票购买";
    _typeL.font = HTFont(28);
    [self.contentView addSubview:_typeL];
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(HEIGHT_PRO(15));
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(8));
    }];
    
    _timeL = [[UILabel alloc]init];
    _timeL.text = @"2018-08-08";
    _timeL.font = HTFont(24);
    _timeL.textColor = ZWHCOLOR(@"#AAAAAA");
    [self.contentView addSubview:_timeL];
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_typeL.mas_bottom).offset(HEIGHT_PRO(6));
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(8));
    }];
    
    _moneyL = [[UILabel alloc]init];
    _moneyL.text = @"-50";
    _moneyL.font = HTFont(32);
    [self.contentView addSubview:_moneyL];
    [_moneyL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_typeL);
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(8));
    }];
}

-(void)setModel:(ZWHBillModel *)model{
    _model = model;
    _typeL.text = _model.type_text;
    switch ([_state integerValue]) {
        case 0:
            _moneyL.text = _model.amount;
            break;
        case 1:
            _moneyL.text = _model.integral;
            break;
        case 2:
            _moneyL.text = _model.amount;
            break;
        default:
            break;
    }
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS";
    NSDate *date = [format dateFromString:_model.createtime];
    format.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    _timeL.text = [format stringFromDate:date];
    NSInteger cost = [_moneyL.text integerValue];
    if (cost>0) {
        _moneyL.text = [NSString stringWithFormat:@"+%ld",cost];
        _moneyL.textColor = ZWHCOLOR(@"#4BA4FF");
    }else{
        _moneyL.textColor = ZWHCOLOR(@"#101010");
    }
}

@end
