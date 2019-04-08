//
//  StrikeThroughLabel.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "StrikeThroughLabel.h"

@implementation StrikeThroughLabel
@synthesize strikeThroughEnabled = _strikeThroughEnabled;
-(void)drawRect:(CGRect)rect
{
    [super drawTextInRect:rect];
    NSDictionary *fontDIc=[NSDictionary dictionaryWithObjectsAndKeys:[self font],NSFontAttributeName,nil];
    CGSize size=[[self text] sizeWithAttributes:fontDIc];
    CGFloat strikeWith=size.width;
    CGRect linRect;

    if ([self textAlignment]==NSTextAlignmentRight)
    {
        linRect=CGRectMake(rect.size.width-strikeWith,self.size.height/2, strikeWith, 1);
        
    }else if ([self textAlignment]==NSTextAlignmentCenter)
    {
        linRect=CGRectMake(rect.size.width/2-strikeWith/2, self.size.height/2, strikeWith, 1);
        
    }else
    {
        linRect=CGRectMake(0, self.size.height/2, strikeWith, 1);
    }
    
    if (_strikeThroughEnabled) {
        CGContextRef context=UIGraphicsGetCurrentContext();
        CGContextFillRect(context, linRect);
    }
    
}

-(void)setStrikeThroughEnabled:(BOOL)strikeThroughEnabled
{
    _strikeThroughEnabled = strikeThroughEnabled;
    
    NSString *tempText = [self.text copy];
    self.text = @"";
    self.text = tempText;
}
@end
