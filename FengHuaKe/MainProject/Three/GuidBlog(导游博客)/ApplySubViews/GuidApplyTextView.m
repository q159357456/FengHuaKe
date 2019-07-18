//
//  GuidApplyTextView.m
//  FengHuaKe
//
//  Created by chenheng on 2019/7/18.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "GuidApplyTextView.h"

@implementation GuidApplyTextView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    
        self.label = [[UILabel alloc]init];
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(10);
            make.left.mas_equalTo(self.mas_left).offset(10);
            make.size.mas_equalTo(CGSizeMake(WIDTH_PRO(90), WIDTH_PRO(20)));
        }];
        self.textview = [[UITextView alloc]init];
        self.textview.font = [UIFont systemFontOfSize:WIDTH_PRO(14)];
        [self addSubview:self.textview ];
        [self.textview  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.label.mas_bottom).offset(10);
            make.left.mas_equalTo(self).offset(10);
            make.right.mas_equalTo(self).offset(-10);
            make.bottom.mas_equalTo(self).offset(-10);
        }];
        
        self.qmui_borderColor = [UIColor groupTableViewBackgroundColor];
        self.qmui_borderWidth = 1;
        self.qmui_borderPosition =  QMUIViewBorderPositionBottom;
        self.label.font = [UIFont systemFontOfSize:WIDTH_PRO(14)];
        
    }
    return self;
}
-(void)setNot_edit_avilble:(BOOL)not_edit_avilble
{
    _not_edit_avilble = not_edit_avilble;
    if (_not_edit_avilble) {
        self.textview .userInteractionEnabled = NO;
    }
}
-(NSString *)outPutTxt
{
    if (!_outPutTxt) {
        _outPutTxt = @"";
    }
    _outPutTxt = self.textview .text;
    return _outPutTxt;
}
@end
