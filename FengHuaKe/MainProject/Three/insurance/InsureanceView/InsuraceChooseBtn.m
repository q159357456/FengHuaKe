//
//  InsuraceChooseBtn.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/23.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "InsuraceChooseBtn.h"

@implementation InsuraceChooseBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.titleLabel.font=[UIFont boldSystemFontOfSize:14];
        self.lineView=[[UIView alloc]initWithFrame:CGRectMake(self.width/2-30, frame.size.height-2, 60, 2)];
        self.lineView.backgroundColor=MainColor;
        self.lineView.hidden=YES;
        [self addSubview:self.lineView];
        [self setTitleColor:MainColor forState:UIControlStateSelected];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
    }
    return self;
}
-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        self.lineView.hidden=NO;
    }else
    {
        self.lineView.hidden=YES;
    }
    
}
@end
