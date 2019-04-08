//
//  HotelView.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "HotelView.h"

@implementation HotelView

-(instancetype)initWithFrame:(CGRect)frame Title:(NSString*)title
{
    self=[super initWithFrame:frame];
    if (self) {
        self.lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
        self.lable.text=title;
        self.lable.font=[UIFont systemFontOfSize:13];
        self.lable.textAlignment=NSTextAlignmentCenter;
        self.lable.textColor=[UIColor darkGrayColor];
        CGSize sizeThatFit=[self.lable sizeThatFits:CGSizeZero];
        CGFloat w=sizeThatFit.width;
        CGFloat h=sizeThatFit.height;
        CGFloat centerX=self.frame.size.width/2;
        CGFloat centerY=self.frame.size.height/2;
        self.lable.frame=CGRectMake(0, 0, w, h);
        self.lable.center=CGPointMake(centerX, centerY);
        [self addSubview:self.lable];
        
        CGFloat shaplenth=h/2;
        CAShapeLayer *shapLayer=[CAShapeLayer layer];
        [self.layer addSublayer:shapLayer];
        UIBezierPath *bezier=[[UIBezierPath alloc]init];
        [bezier moveToPoint:CGPointMake(w/2+centerX+shaplenth, centerY+1)];
        [bezier addLineToPoint:CGPointMake(centerX +w/2 +shaplenth, self.lable.frame.origin.y+h)];
        [bezier addLineToPoint:CGPointMake(w/2+centerX, self.lable.frame.origin.y+h)];
        shapLayer.path=bezier.CGPath;
        [shapLayer setFillColor:[UIColor darkGrayColor].CGColor];
//        shapLayer setFillRule:kcg
  
    }
    return self;
}


@end
