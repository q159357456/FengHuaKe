//
//  AlreadyApplyHeadView.m
//  FengHuaKe
//
//  Created by chenheng on 2019/6/24.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "AlreadyApplyHeadView.h"

@implementation AlreadyApplyHeadView

-(instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth*0.6);
        self.imageView = [[UIImageView alloc]init];
        self.label1 = [[UILabel alloc]init];
        self.label2 = [[UILabel alloc]init];
        self.label3 = [[UILabel alloc]init];
        self.label4 = [[UILabel alloc]init];
        self.label5 = [[UILabel alloc]init];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(70*MULPITLE, 70*MULPITLE));
            make.left.mas_equalTo(self.mas_left).offset(15);
        }];
        [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(15);
            make.size.mas_equalTo(CGSizeMake(150*MULPITLE, 20*MULPITLE));
            make.top.mas_equalTo(self.imageView.mas_bottom).offset(10*MULPITLE);
        }];
        [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(15);
            make.size.mas_equalTo(CGSizeMake(150*MULPITLE, 20*MULPITLE));
            make.top.mas_equalTo(self.label1.mas_bottom).offset(10*MULPITLE);
        }];
        [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(15);
            make.size.mas_equalTo(CGSizeMake(100*MULPITLE, 20*MULPITLE));
            make.top.mas_equalTo(self.label2.mas_bottom).offset(30*MULPITLE);
        }];
        [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.label3.mas_left).offset(25);
            make.size.mas_equalTo(CGSizeMake(100*MULPITLE, 20*MULPITLE));
            make.top.mas_equalTo(self.label2.mas_bottom).offset(30*MULPITLE);
        }];
        [self.label5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.label4.mas_left).offset(25);
            make.size.mas_equalTo(CGSizeMake(100*MULPITLE, 20*MULPITLE));
            make.top.mas_equalTo(self.label2.mas_bottom).offset(30*MULPITLE);
        }];
    }
    return self;
}

@end
