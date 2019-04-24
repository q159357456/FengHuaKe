//
//  GBSegmentView.m
//  FengHuaKe
//
//  Created by chenheng on 2019/4/23.
//  Copyright © 2019年 gongbo. All rights reserved.
//

#import "GBSegmentView.h"
@interface GBSegmentView ()
{
    NSInteger _index;
}
@property(nonatomic,copy)void(^btncallBack)(NSInteger index);
@end
@implementation GBSegmentView

+(instancetype)initialSegmentViewFrame:(CGRect)frame DataSource:(NSArray<NSString*>*)dataSource CallBack:(void(^)(NSInteger index))callBack{
    
    GBSegmentView *gb = [[GBSegmentView alloc]initWithFrame:frame DataSource:dataSource];
    gb.btncallBack = ^(NSInteger index) {
        callBack(index);
    };

    return gb;
}

-(instancetype)initWithFrame:(CGRect)frame DataSource:(NSArray<NSString*>*)dataSource{

    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat x = 8.0;
        CGFloat rowSpace = 8;
        for (NSInteger i=0; i<dataSource.count; i++) {
            NSString *title = dataSource[i];
            UILabel *temp = [[UILabel alloc]init];
            temp.text = title;
            temp.font = ZWHFont(12);
            CGSize size = [temp sizeThatFits:CGSizeZero];
            CGFloat w = size.width+16;
            CGFloat h =self.height-16;
            CGFloat y = 8;
            QMUIButton *button = [[QMUIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
            x = x + w + rowSpace;
            [self addSubview:button];
            [button setTitle:title forState:UIControlStateNormal];
            button.layer.cornerRadius = h/2;
            [self addSubview:button];
            [button addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font = ZWHFont(12);
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.tag = i +1 ;
            if (button.tag==1) {
                [self pressBtn:button];
            }
        }
        
        
    }
    return self;
    
}
-(void)pressBtn:(UIButton*)btn{
    
    if (_index == btn.tag) {
        return;
    }
    if (_index == 0) {
        btn.backgroundColor = MAINCOLOR;
        _index = btn.tag;
    }else
    {
        btn.backgroundColor = MAINCOLOR;
        UIButton *oldBtn = [self viewWithTag:_index];
        oldBtn.backgroundColor = [UIColor clearColor];
         _index = btn.tag;
        
    }
    if (self.btncallBack) {
        self.btncallBack(_index);
    }
    
    
   
    
    
    
    
}
@end
