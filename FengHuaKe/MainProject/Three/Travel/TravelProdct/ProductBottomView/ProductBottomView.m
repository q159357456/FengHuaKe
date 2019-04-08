//
//  ProductDetailView.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ProductBottomView.h"
#import "UIView+SDAutoLayout.h"
@implementation ProductBottomView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor redColor];
        [self setUp];
    }
    return self;
}

-(void)setUp
{
    _addShopCar=[UIButton buttonWithType:UIButtonTypeCustom];
    _goPay=[UIButton buttonWithType:UIButtonTypeCustom];
    _collectB=[UIButton buttonWithType:UIButtonTypeCustom];
    _homeB=[UIButton buttonWithType:UIButtonTypeCustom];
    
    _homeB.backgroundColor = [UIColor whiteColor];
    _collectB.backgroundColor = [UIColor whiteColor];
    
    [_addShopCar setTitle:@"加入购物车" forState:UIControlStateNormal];
    [_goPay setTitle:@"立即购买" forState:UIControlStateNormal];
    
    [_collectB setImage:[UIImage imageNamed:@"WechatIMG20"] forState:0];

    
    [_homeB setImage:[UIImage imageNamed:@"WechatIMG19"] forState:0];
    
    [_addShopCar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_goPay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _addShopCar.backgroundColor=[UIColor orangeColor];
    _goPay.backgroundColor=[UIColor redColor];
    
    [self addSubview:_addShopCar];
    [self addSubview:_goPay];
    [self addSubview:_homeB];
    [self addSubview:_collectB];
    
    [_goPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH/3);
    }];
    
    [_addShopCar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(_goPay.mas_left);
        make.width.mas_equalTo(SCREEN_WIDTH/3);
    }];
    
    [_homeB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(_addShopCar.mas_left);
        make.width.mas_equalTo(SCREEN_WIDTH/3/2);
    }];
    
    [_collectB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(_homeB.mas_left);
        make.width.mas_equalTo(SCREEN_WIDTH/3/2);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = LINECOLOR;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(_homeB.mas_left);
        make.width.mas_equalTo(1);
    }];
    
    UIView *topline = [[UIView alloc]init];
    topline.backgroundColor = LINECOLOR;
    [self addSubview:topline];
    [topline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.right.equalTo(_homeB.mas_right);
        make.left.equalTo(_collectB.mas_left);
        make.height.mas_equalTo(1);
    }];
    
    
}
@end
