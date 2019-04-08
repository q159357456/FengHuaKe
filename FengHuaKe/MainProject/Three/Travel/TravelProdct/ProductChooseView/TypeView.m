//
//  TypeView.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/20.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "TypeView.h"

@implementation TypeView
-(instancetype)initWithFrame:(CGRect)frame andDatasource:(NSArray *)arr :(NSString *)typename
{
    self=[super initWithFrame:frame];
    if (self) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
        lab.text = typename;
        lab.textColor = [UIColor blackColor];
        lab.font = [UIFont systemFontOfSize:14];
        [self addSubview:lab];
        
        BOOL  isLineReturn = NO;
        float upX = 10;
        float upY = 40;
         for (int i = 0; i<arr.count; i++) {
             NSString *str = [arr objectAtIndex:i] ;
             
             NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:14] forKey:NSFontAttributeName];
             CGSize size = [str sizeWithAttributes:dic];
             if ( upX > (self.frame.size.width-20 -size.width-35)) {
                 
                 isLineReturn = YES;
                 upX = 10;
                 upY += 30;
             }
             
             UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
             btn.frame = CGRectMake(upX, upY, size.width+30,25);
             [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
             [btn setTitleColor:[UIColor blackColor] forState:0];
             [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
             btn.titleLabel.font = [UIFont systemFontOfSize:13];
             [btn setTitle:[arr objectAtIndex:i] forState:0];
             btn.layer.cornerRadius = 8;
             btn.layer.borderColor = [UIColor clearColor].CGColor;
             btn.layer.borderWidth = 0;
             [btn.layer setMasksToBounds:YES];
             
             [self addSubview:btn];
             btn.tag = 100+i;
             [btn addTarget:self action:@selector(touchbtn:) forControlEvents:UIControlEventTouchUpInside];
             upX+=size.width+35;
             
         }
        upY +=30;
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, upY+10, self.frame.size.width, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        
        self.height = upY+11;
        
        self.seletIndex = -1;
        
    }
    return self;
}
-(void)touchbtn:(UIButton *)btn
{
    if (btn.selected == NO) {
        btn.selected=YES;
        self.seletIndex = (int)btn.tag-100;
        btn.backgroundColor = [UIColor redColor];
        
        
        //        for (UIView *view in self.subviews) {
        //            if ([view class] == [UIButton class]) {
        //                UIButton *bt = (UIButton *)view;
        //                bt.selected = NO;
        //                if (bt.tag == btn.tag) {
        //                    bt.selected = YES;
        //                }
        //            }
        //
        //        }
    }else
    {
        self.seletIndex = -1;
        btn.selected = NO;
        btn.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    }
    [self.delegate btnindex:(int)btn.tag-100];
}
@end
