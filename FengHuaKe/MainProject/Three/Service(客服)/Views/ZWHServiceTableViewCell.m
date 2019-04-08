//
//  ZWHServiceTableViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/12/24.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHServiceTableViewCell.h"

@implementation ZWHServiceTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    CellLine;
    _img = [[UIImageView alloc]init];
    [self.contentView addSubview:_img];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(15));
        make.top.equalTo(self.contentView).offset(HEIGHT_PRO(10));
        make.width.height.mas_equalTo(WIDTH_PRO(50));
    }];
    
    _name = [[QMUILabel alloc]qmui_initWithFont:ZWHFont(14) textColor:[UIColor blackColor]];
    [self.contentView addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_img.mas_right).offset(WIDTH_PRO(5));
        make.top.equalTo(_img);
    }];
    
    _tips = [[QMUILabel alloc]qmui_initWithFont:ZWHFont(12) textColor:[UIColor blackColor]];
    [self.contentView addSubview:_tips];
    [_tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_img.mas_right).offset(WIDTH_PRO(5));
        make.bottom.equalTo(_img);
    }];
    
    _orderNum = [[QMUILabel alloc]qmui_initWithFont:ZWHFont(12) textColor:[UIColor qmui_colorWithHexString:@"#9B9B9B"]];
    [self.contentView addSubview:_orderNum];
    [_orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_img.mas_left);
        make.top.equalTo(_img.mas_bottom).offset(HEIGHT_PRO(4));
    }];
    
    _rate = [[QMUILabel alloc]qmui_initWithFont:ZWHFont(12) textColor:[UIColor qmui_colorWithHexString:@"#9B9B9B"]];
    [self.contentView addSubview:_rate];
    [_rate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(15));
        make.centerY.equalTo(_orderNum);
    }];
    
    _floatLayoutView = [[QMUIFloatLayoutView alloc] init];
    _floatLayoutView.padding = UIEdgeInsetsZero;
    _floatLayoutView.itemMargins = UIEdgeInsetsMake(0, 0, 0, 0);
    _floatLayoutView.minimumItemSize = CGSizeMake(WIDTH_PRO(12), WIDTH_PRO(12));
    [self.contentView addSubview:_floatLayoutView];
    [_floatLayoutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_name.mas_bottom).offset(HEIGHT_PRO(4));
        make.left.equalTo(_name);
        make.height.mas_equalTo(HEIGHT_PRO(20));
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(66));
    }];
    
    
    for (NSInteger i=0; i<5; i++) {
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"x"]];
        [_floatLayoutView addSubview:img];
    }
    
    
    
    _rate.text = @"好评率99%";
    _orderNum.text = @"一个月完成1单";
    _tips.text = @"用心服务";
    _name.text = @"客服";
    _img.image = [UIImage qmui_imageWithColor:[UIColor qmui_randomColor]];
}

-(void)setModel:(ZWHServiceModel *)model{
    _model = model;
    _name.text = _model.name;
    _tips.text = _model.tips;
    _orderNum.text = [NSString stringWithFormat:@"共完成%@单",_model.quantity];
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,_model.logonurl]] placeholderImage:[UIImage qmui_imageWithColor:[UIColor qmui_randomColor]]];
    _rate.text = [NSString stringWithFormat:@"好评率%.0f%%",[_model.evaluate_01 floatValue]/[_model.quantity floatValue]*100];
    
    
    float xNum = [_model.evaluate_01 floatValue]/[_model.quantity floatValue]*5;
    float pointNum = xNum - (NSInteger)xNum;
    [_floatLayoutView qmui_removeAllSubviews];
    for (NSInteger i=0; i<(NSInteger)xNum; i++) {
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"x"]];
        [_floatLayoutView addSubview:img];
    }
    UIImageView *pointimg = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"x"] qmui_imageWithTintColor:LINECOLOR]];
    UIImage *img = [UIImage imageNamed:@"x"];

    UIImageView *grayImg = [[UIImageView alloc]initWithImage:img];
    
    UIView *view = [[UIView alloc]init];
    view.layer.masksToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    [pointimg addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(pointimg);
        make.width.equalTo(pointimg.mas_width).multipliedBy(pointNum);
    }];
    
    [view addSubview:grayImg];
    [grayImg mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.top.bottom.equalTo(view);
    }];
    
    
    [_floatLayoutView addSubview:pointimg];
}







@end
