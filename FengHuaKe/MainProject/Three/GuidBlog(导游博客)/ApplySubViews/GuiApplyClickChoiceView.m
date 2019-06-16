//
//  GuiApplyClickChoiceView.m
//  FengHuaKe
//
//  Created by chenheng on 2019/6/14.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "GuiApplyClickChoiceView.h"

@implementation GuiApplyClickChoiceView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        self.clickLabel = [[UILabel alloc]init];
        self.clickLabel.font = [UIFont systemFontOfSize:WIDTH_PRO(14)];
        [self addSubview:self.clickLabel];
        [self.clickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self.label.mas_right).offset(10);
            make.height.mas_equalTo(20);
            make.right.mas_equalTo(self.mas_right).offset(-15);
        }];
        self.clickLabel.text = @"请选择生日";
    }
    return self;
}

@end
