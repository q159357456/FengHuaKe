//
//  GuidApplyTxtInputView.m
//  FengHuaKe
//
//  Created by chenheng on 2019/6/14.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "GuidApplyTxtInputView.h"

@implementation GuidApplyTxtInputView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.textfield = [[UITextField alloc]init];
        self.textfield.font = [UIFont systemFontOfSize:WIDTH_PRO(14)];
        [self addSubview:self.textfield];
        [self.textfield mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self.label.mas_right).offset(10);
            make.height.mas_equalTo(30);
            make.right.mas_equalTo(self.mas_right).offset(-15);
        }];
    }
    return self;
}

-(NSString *)outPutTxt
{
    if (!_outPutTxt) {
        _outPutTxt = @"";
    }
    _outPutTxt = self.textfield.text;
    return _outPutTxt;
}
@end
