//
//  TopScroButton.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/22.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "TopScroButton.h"
#import "UIView+SDAutoLayout.h"
@implementation TopScroButton

-(instancetype)initWithFrame:(CGRect)frame Text:(NSString *)text
{
    self=[super initWithFrame:frame];
    if (self) {
        _textLable=[[UILabel alloc]init];
        _textLable.font=[UIFont systemFontOfSize:14];
        _bottomView=[[UIView alloc]init];
        _bottomView.backgroundColor=MainColor;
        [self addSubview:_textLable];
        [self addSubview:_bottomView];
        
        NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:14] forKey:NSFontAttributeName];
        CGSize size = [text sizeWithAttributes:dic];
 _textLable.sd_layout.centerXEqualToView(self).centerYEqualToView(self).heightIs(self.height-2).widthIs(size.width);
        _bottomView.sd_layout.centerXEqualToView(self).bottomSpaceToView(self, 2).widthIs(size.width).heightIs(2);
        
        _textLable.text=text;
        
        
        
    }
    return self;
}

@end
