//
//  ZWHCashListTableViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/7/30.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHCashListTableViewCell.h"

@implementation ZWHCashListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

//设置状态
-(void)setStateIndex:(NSInteger)stateIndex{
    _stateIndex = stateIndex;
    [self creatUI];
}



-(void)creatUI{
    self.contentView.backgroundColor = LINECOLOR;
    
    //上半部白色背景
    _topBackView = [[UIView alloc]init];
    _topBackView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_topBackView];
    [_topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(HEIGHT_PRO(10));
        make.height.mas_equalTo(HEIGHT_PRO(110));
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(8));
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(8));
    }];
    
    //底部蓝色背景
    UIView *bottomBackView = [[UIView alloc]init];
    bottomBackView.backgroundColor = ZWHCOLOR(@"#4BA4FF");
    if (_stateIndex == 2) {
        bottomBackView.backgroundColor = ZWHCOLOR(@"#AAAAAA");
    }
    [self.contentView addSubview:bottomBackView];
    [bottomBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topBackView.mas_bottom);
        make.bottom.equalTo(self.contentView).offset(-HEIGHT_PRO(10));
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(8));
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(8));
    }];
    
    //左右半弧
    
    for (int i=0; i<2; i++) {
        UIView *leftView = [[UIView alloc]init];
        leftView.backgroundColor = LINECOLOR;
        leftView.layer.cornerRadius = WIDTH_PRO(8);
        leftView.layer.masksToBounds = YES;
        [self.contentView addSubview:leftView];
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(WIDTH_PRO(16));
            make.centerY.equalTo(_topBackView.mas_bottom);
            make.centerX.equalTo(i==0?_topBackView.mas_left:_topBackView.mas_right);
        }];
    }
    
    //虚线
    _dashPhaseLab = [[QMUILabel alloc]init];
    _dashPhaseLab.qmui_dashPhase = 5;
    _dashPhaseLab.qmui_dashPattern = @[@3,@3];
    [_dashPhaseLab setQmui_borderPosition:QMUIViewBorderPositionRight];
    _dashPhaseLab.qmui_borderWidth = 1;
    _dashPhaseLab.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_dashPhaseLab];
    [_dashPhaseLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topBackView.mas_left).offset(WIDTH_PRO(170));
        make.top.equalTo(_topBackView).offset(HEIGHT_PRO(5));
        make.bottom.equalTo(_topBackView).offset(-HEIGHT_PRO(5));
        make.width.mas_equalTo(3);
    }];
    
    _tagMoney = [[UILabel alloc]init];
    _tagMoney.textColor = ZWHCOLOR(@"#4BA4FF");;
    _tagMoney.font = HTFont(36);
    _tagMoney.text = @"¥";
    [self.contentView addSubview:_tagMoney];
    [_tagMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topBackView.mas_top).offset(HEIGHT_PRO(50));
        //make.width.mas_equalTo(WIDTH_PRO(20));
        //make.height.mas_equalTo(HEIGHT_PRO(26));
        make.left.equalTo(_topBackView.mas_left).offset(WIDTH_PRO(8));
    }];
    
    _moneyL = [[QMUILabel alloc]init];
    _moneyL.textColor = ZWHCOLOR(@"#4BA4FF");;
    _moneyL.font = HTFont(100);
    _moneyL.text = @"150";
    [self.contentView addSubview:_moneyL];
    [_moneyL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_tagMoney.mas_bottom).offset(HEIGHT_PRO(8));
        make.left.equalTo(_tagMoney.mas_right);
    }];
    
    _typeMoney = [[UILabel alloc]init];
    _typeMoney.textColor = ZWHCOLOR(@"#4BA4FF");;
    _typeMoney.font = HTFont(36);
    _typeMoney.text = @"优惠券";
    [self.contentView addSubview:_typeMoney];
    [_typeMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_tagMoney.mas_bottom);
        //make.left.equalTo(_moneyL.mas_right);
        make.right.equalTo(_dashPhaseLab.mas_right).offset(-WIDTH_PRO(3));
    }];
    
    _detailL = [[UILabel alloc]init];
    _detailL.textColor = ZWHCOLOR(@"#101010");;
    _detailL.font = HTFont(28);
    _detailL.text = @"万达国际影城（华南摩）享代金券";
    _detailL.numberOfLines = 2;
    [self.contentView addSubview:_detailL];
    if (_stateIndex!=0) {
        [_detailL mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_tagMoney.mas_centerY);
            make.left.equalTo(_dashPhaseLab.mas_right).offset(WIDTH_PRO(8));
            make.right.equalTo(_topBackView.mas_right).offset(-WIDTH_PRO(8));
        }];
    }else{
        [_detailL mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.top.equalTo(topBackView.mas_top).offset(HEIGHT_PRO(20));
            make.bottom.equalTo(_tagMoney.mas_centerY).offset(HEIGHT_PRO(3));
            make.left.equalTo(_dashPhaseLab.mas_right).offset(WIDTH_PRO(8));
            make.right.equalTo(_topBackView.mas_right).offset(-WIDTH_PRO(8));
        }];
    }
    
    
    _dayL = [[QMUILabel alloc]init];
    _dayL.textColor = ZWHCOLOR(@"#EB6000");;
    _dayL.font = HTFont(24);
    _dayL.text = @"还剩4天到期";
    [self.contentView addSubview:_dayL];
    [_dayL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_detailL.mas_bottom).offset(HEIGHT_PRO(5));
        make.left.equalTo(_dashPhaseLab.mas_right).offset(WIDTH_PRO(8));
        make.right.equalTo(_topBackView.mas_right).offset(-WIDTH_PRO(8));
    }];
    _dayL.hidden = _stateIndex==0?NO:YES;
    
    _explainL = [[QMUILabel alloc]init];
    _explainL.textColor = ZWHCOLOR(@"#FFFFFF");;
    _explainL.font = HTFont(24);
    _explainL.text = @"满50元可用不与其他优惠叠加";
    [self.contentView addSubview:_explainL];
    [_explainL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomBackView);
        make.left.equalTo(bottomBackView.mas_left).offset(WIDTH_PRO(8));
        //make.right.equalTo(topBackView.mas_right).offset(-WIDTH_PRO(8));
    }];
    
    if (_stateIndex == 2) {
        _tagMoney.textColor = ZWHCOLOR(@"#AAAAAA");
        _moneyL.textColor = ZWHCOLOR(@"#AAAAAA");
        _typeMoney.textColor = ZWHCOLOR(@"#AAAAAA");
        _detailL.textColor = ZWHCOLOR(@"#AAAAAA");
    }
}

-(void)setModel:(ZWHCashcoupon *)model{
    _model = model;
    _moneyL.text = _model.derate;
    _typeMoney.text = _model.ClassifyName;
    _explainL.text = _model.meet;
    _detailL.text = _model.ShopName;
    
    if (_stateIndex == 0) {
        //创建两个日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        NSDate *startDate = [NSDate date];
        NSDate *endDate = [dateFormatter dateFromString:_model.EndDate];
        //利用NSCalendar比较日期的差异
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSCalendarUnit unit = NSCalendarUnitDay;//只比较天数差异
        NSDateComponents *delta = [calendar components:unit fromDate:startDate toDate:endDate options:0];
        _dayL.text = [NSString stringWithFormat:@"还有%ld天过期",delta.day];
    }
    
}


@end
