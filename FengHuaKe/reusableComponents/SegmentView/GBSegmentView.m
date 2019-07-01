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
    UIView * _lineView;
}
@property(nonatomic,copy)void(^btncallBack)(NSInteger index);
@end
@implementation GBSegmentView

+(instancetype)initialSegmentViewFrame:(CGRect)frame DataSource:(NSArray<NSString*>*)dataSource SegStyle:(NSInteger)segStyle CallBack:(void(^)(NSInteger index))callBack{
    
    GBSegmentView *gb = [[GBSegmentView alloc]initWithFrame:frame DataSource:dataSource SegStyle:(NSInteger)segStyle];
    gb.btncallBack = ^(NSInteger index) {
        callBack(index);
    };

    return gb;
}

-(instancetype)initWithFrame:(CGRect)frame DataSource:(NSArray<NSString*>*)dataSource SegStyle:(NSInteger)segStyle{

    self = [super initWithFrame:frame];
    if (self) {
        
        if (segStyle == SegStyle_1) {
            [self style_1_Frame:frame DataSource:dataSource];
        }
        if (segStyle == SegStyle_2) {
            [self style_2_Frame:frame DataSource:dataSource];
        }
        
        
    }
    return self;
    
}

-(void)style_1_Frame:(CGRect)frame DataSource:(NSArray<NSString*>*)dataSource{
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

-(void)style_2_Frame:(CGRect)frame DataSource:(NSArray<NSString*>*)dataSource{
    
    
    for (NSInteger i=0; i<dataSource.count; i++) {
        NSString *title = dataSource[i];
        CGFloat w = frame.size.width/dataSource.count;
        CGFloat h =self.height-1;
        CGFloat y = 0;
        CGFloat x = w*i;
        QMUIButton *button = [[QMUIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
        [self addSubview:button];
        [button setTitle:title forState:UIControlStateNormal];
        button.layer.cornerRadius = h/2;
        [self addSubview:button];
        [button addTarget:self action:@selector(pressBtn1:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = ZWHFont(12);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = i +1 ;
        
        
        
        if (button.tag==1) {
            _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height-1, button.width, 1)];
            _lineView.backgroundColor = MainColor;
            [self addSubview:_lineView];
            [button setTitleColor:MainColor forState:UIControlStateNormal];
            _index = button.tag;
//            [self pressBtn1:button];
        }
    }
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

-(void)pressBtn1:(UIButton*)btn{
    if (_index == btn.tag) {
        return;
    }
    [btn setTitleColor:MainColor forState:UIControlStateNormal];
    if (_index) {
        UIButton *oldBtn = [self viewWithTag:_index];
        [oldBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
       
    }
    _index = btn.tag;
    _lineView.transform = CGAffineTransformMakeTranslation(btn.width*(_index-1), 0);
 
    if (self.btncallBack) {
        self.btncallBack(_index);
    }
}
@end
