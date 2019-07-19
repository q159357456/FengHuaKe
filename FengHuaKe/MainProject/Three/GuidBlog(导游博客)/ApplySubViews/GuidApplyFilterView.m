//
//  GuidApplyFilterView.m
//  FengHuaKe
//
//  Created by 秦根 on 2019/7/18.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "GuidApplyFilterView.h"

@implementation GuidApplyFilterView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        self.label = [[UILabel alloc]init];
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(10);
            make.left.mas_equalTo(self.mas_left).offset(10);
            make.size.mas_equalTo(CGSizeMake(WIDTH_PRO(130), WIDTH_PRO(20)));
        }];

        self.qmui_borderColor = [UIColor groupTableViewBackgroundColor];
        self.qmui_borderWidth = 1;
        self.qmui_borderPosition =  QMUIViewBorderPositionBottom;
        self.label.font = [UIFont systemFontOfSize:WIDTH_PRO(14)];
        
    }
    return self;
}
-(void)setFilerTitles:(NSArray *)filerTitles
{
    _filerTitles = filerTitles;
    NSArray * reverseA = [[filerTitles reverseObjectEnumerator] allObjects];
    for (NSInteger i= 0; i<reverseA.count; i++) {
        QMUIButton * btn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        [btn setTitle:reverseA[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"slected_1"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"slected_2"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn.tag = 100+(reverseA.count-i-1);
        if (btn.tag-100 == self.selctIndex) {
            btn.selected = YES;
        }
        
        btn.imagePosition =  QMUIButtonImagePositionLeft;
        CGFloat temp = 10 + (40+20)*i;

        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40,30));
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self).offset(-temp);
        }];
       
        [btn addTarget:self action:@selector(selet:) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)selet:(UIButton*)btn{
    //    NSInteger temp = btn.tag-100;
    if (btn.tag-100 == self.selctIndex) {
        return;
    }
    btn.selected = YES;
//    UIView * view = [self.view viewWithTag:7];
    UIButton *  old = [self viewWithTag:self.selctIndex+100];
    old.selected = NO;
    self.selctIndex = btn.tag-100;
}
@end
