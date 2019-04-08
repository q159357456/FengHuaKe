//
//  BillTopView.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/17.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "BillTopView.h"

@implementation BillTopView
{
    NSInteger _slected;
}
-(instancetype)initWithFrame:(CGRect)frame Array:(NSArray *)array
{
    if (self=[super initWithFrame:frame]) {
   
        for (NSInteger i=0; i<array.count; i++) {
            CGFloat w=ScreenWidth/5-20;
            CGFloat h=frame.size.height-12;
            CGFloat x=10+ScreenWidth*i/5;
            CGFloat y=6;

            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=CGRectMake(x, y, w, h);
            [button setTitle:array[i] forState:0];
            button.titleLabel.font=HTFont(26);
            [button setTitleColor:[UIColor blackColor] forState:0];
            [button setTitleColor:MainColor forState:UIControlStateSelected];
            button.tag=i+1;
//            [button rounded:4 width:1 color:MainColor];
            [button addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
        }
        
        
    }
    return self;
}
-(void)choose:(UIButton*)butt
{
    NSLog(@"choose");
    if (butt.tag==_slected) {
    
        return;
    }
    if (_slected) {
        UIButton *button=(UIButton*)[self viewWithTag:_slected];
        [button rounded:0 width:0 color:[UIColor clearColor]];
//        [button setTitleColor:[UIColor blackColor] forState:0];
        button.selected=NO;
    }
//    butt.backgroundColor=MainColor;
    [butt rounded:4 width:1 color:MainColor];
    butt.selected=YES;
    _slected=butt.tag;
    

    if (self.delegate && [self.delegate respondsToSelector:@selector(touchTagindex:)]) {
        [self.delegate touchTagindex:butt.tag];
    }
   
    
}

@end
