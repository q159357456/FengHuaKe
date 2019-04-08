//
//  ZWHMyHeaderView.m
//  FengHuaKe
//
//  Created by Syrena on 2018/9/12.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHMyHeaderView.h"
#import "ZWHSeaView.h"
#import "UIColor+Extension.h"

@interface ZWHMyHeaderView()

@property(nonatomic,strong)ZWHSeaView *seaView;


@end


@implementation ZWHMyHeaderView




-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor qmui_colorWithHexString:@"1EADFB"];
        [self.layer addSublayer:[UIColor setGradualChangingColor:self fromColor:@"38B0DE" toColor:@"4BA4FF"]];
        [self setUI];
    }
    return self;
}


-(void)setUI{
    [self addSubview:self.seaView];
    _img = [[UIImageView alloc]init];
    [self addSubview:_img];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(ZWHNavHeight);
        make.left.equalTo(self).offset(WIDTH_PRO(26));
        make.width.height.mas_equalTo(WIDTH_PRO(103));
    }];
    _img.layer.cornerRadius = WIDTH_PRO(103)/2;
    _img.layer.masksToBounds = YES;
    _img.layer.borderWidth = 3;
    _img.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _imgBtn = [[QMUIButton alloc]init];
    _imgBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:_imgBtn];
    [_imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(_img);
    }];
    
    _name = [[QMUILabel alloc]qmui_initWithFont:HTFont(32) textColor:[UIColor whiteColor]];
    [self addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_img.mas_right).offset(WIDTH_PRO(15));
        make.top.equalTo(_img.mas_top).offset(HEIGHT_PRO(15));
    }];
    
    _num = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:[UIColor whiteColor]];
    [self addSubview:_num];
    [_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_img.mas_right).offset(WIDTH_PRO(15));
        make.top.equalTo(_name.mas_bottom).offset(3);
    }];
    
    _quit = [[QMUIButton alloc]qmui_initWithImage:nil title:@"退出"];
    [_quit setTitleColor:[UIColor whiteColor] forState:0];
    [self addSubview:_quit];
    [_quit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-WIDTH_PRO(15));
        make.centerY.equalTo(_name);
    }];
    
    _qrCode = [[QMUIButton alloc]qmui_initWithImage:[UIImage imageNamed:@"WechatIMG128"] title:@""];
    [self addSubview:_qrCode];
    [_qrCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_quit.mas_left).offset(-WIDTH_PRO(15));
        make.centerY.equalTo(_quit);
        make.height.width.mas_equalTo(WIDTH_PRO(25));
    }];
}


-(ZWHSeaView *)seaView{
    if (!_seaView) {
        _seaView = [[ZWHSeaView alloc]initWithFrame:CGRectMake(0, self.height-10, self.width, 10)];
        _seaView.frontColor = [UIColor colorWithWhite:1 alpha:0.5];
        _seaView.insideColor = [UIColor whiteColor];
        _seaView.frontSpeed = 0.15;
        _seaView.insideSpeed = 0.15; //让两条曲线的速度保持一致
        _seaView.waveOffset = M_PI/2; //更改两条波形交错的距离
        _seaView.directionType = WaveDirectionTypeFoward; //正向移动
    }
    return _seaView;
}










@end
