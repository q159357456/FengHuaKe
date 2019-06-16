//
//  GuidApplyBaseView.m
//  FengHuaKe
//
//  Created by chenheng on 2019/6/14.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "GuidApplyBaseView.h"

@implementation GuidApplyBaseView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc]init];
        self.label.font = [UIFont systemFontOfSize:WIDTH_PRO(14)];
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self.mas_left).offset(10);
            make.size.mas_equalTo(CGSizeMake(WIDTH_PRO(90), WIDTH_PRO(20)));
        }];
        self.qmui_borderColor = [UIColor groupTableViewBackgroundColor];
        self.qmui_borderWidth = 1;
        self.qmui_borderPosition =  QMUIViewBorderPositionBottom;
    }
    return self;
}

@end
