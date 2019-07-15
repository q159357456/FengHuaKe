//
//  FilterView.m
//  FengHuaKe
//
//  Created by chenheng on 2019/7/15.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "FilterView.h"

@implementation FilterView

-(instancetype)initWithFrame:(CGRect)frame Titles:(NSArray*)titles{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        for (NSInteger i=0; i<titles.count; i++) {
            QMUIButton *btn = [[QMUIButton alloc]qmui_initWithImage:[UIImage imageNamed:@"WechatIMG31"] title:titles[i]];
            btn.imagePosition = QMUIButtonImagePositionRight;
            btn.titleLabel.font = HTFont(24);
            [btn setTitleColor:[UIColor blackColor] forState:0];
            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self);
                make.left.equalTo(self).offset(i*SCREEN_WIDTH/titles.count);
                make.width.mas_equalTo(SCREEN_WIDTH/titles.count);
            }];
            //btn.frame = CGRectMake(SCREEN_WIDTH/3*i, 0, SCREEN_WIDTH/3, HEIGHT_PRO(40));
        }
    }
    return self;
}

@end
