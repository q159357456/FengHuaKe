//
//  ZWHTicketDateCollectionViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/21.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHTicketDateCollectionViewCell.h"

@implementation ZWHTicketDateCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setUI{
    _title = [[QMUILabel alloc]init];
    _title.font = HTFont(22);
    _title.text = @"-";
    _title.textColor = [UIColor blackColor];
    _title.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(HEIGHT_PRO(6));
    }];
    
    _price = [[QMUILabel alloc]init];
    _price.font = HTFont(24);
    _price.text = @"-";
    _price.textColor = [UIColor redColor];
    [self.contentView addSubview:_price];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(_title.mas_bottom).offset(HEIGHT_PRO(6));
    }];
}

@end


