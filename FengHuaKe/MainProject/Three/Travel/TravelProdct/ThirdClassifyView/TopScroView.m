//
//  TopScroView.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/22.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "TopScroView.h"
#import "ClassifyModel.h"

@interface TopScroView()
{
    NSInteger _conut;
    BOOL _isover;

}
@end
@implementation TopScroView

-(instancetype)initWithFrame:(CGRect)frame Data:(NSArray *)data
{
    self=[super initWithFrame:frame];
    if (self) {
        [self setUpWith:data];
    }
    return self;
}

-(void)setUpWith:(NSArray*)data
{
    if (![self isOverScreenWithWith:data])
    {
        _isover=NO;
        self.contentSize=CGSizeMake(self.width, self.height);
        for (NSInteger i=0; i<data.count; i++)
        {
            ClassifyModel *model=data[i];
            NSString *content=model.name;
            TopScroButton *button=[[TopScroButton alloc]initWithFrame:CGRectMake(i*ScreenWidth/data.count, 0,ScreenWidth/data.count, self.frame.size.height) Text:content];
            button.tag=i+1;
            [self addSubview:button];
            [button addTarget:self action:@selector(buttClick:) forControlEvents:UIControlEventTouchUpInside];
            button.bottomView.hidden=YES;
            if (i==0) {
                _seleindex=-1;
                
            }
        }
     
        
    }else
    {
         _isover=YES;
        _conut=data.count;
        CGFloat UX=0;
        for (NSInteger i=0; i<data.count; i++) {
            ClassifyModel *model=data[i];
            NSString *content=model.name;
            NSDictionary *dic=[NSDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:14] forKey:NSFontAttributeName];
            CGSize size=[content sizeWithAttributes:dic];
            
            TopScroButton *button=[[TopScroButton alloc]initWithFrame:CGRectMake(UX, 0,size.width+30, self.frame.size.height) Text:content];
            UX=UX+size.width+30;
            button.tag=i+1;
            [self addSubview:button];
            [button addTarget:self action:@selector(buttClick:) forControlEvents:UIControlEventTouchUpInside];
            button.bottomView.hidden=YES;
            if (i==0) {
                _seleindex=-1;
                
            }
            if (i==data.count-1) {
                self.contentSize=CGSizeMake(UX, self.height);
                self.showsHorizontalScrollIndicator=NO;
            }
            
        }
    }
    
   
    
   
}
-(BOOL)isOverScreenWithWith:(NSArray*)data
{
    NSInteger k=0;
    for (NSInteger i=0; i<data.count; i++) {
        ClassifyModel *model=data[i];
        NSString *content=model.name;
        NSDictionary *dic=[NSDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:14] forKey:NSFontAttributeName];
        CGSize size=[content sizeWithAttributes:dic];
        k=k+size.width+30;
         
    }
    if (k<=ScreenWidth) {
        return NO;
    }
    return YES;
}
-(void)buttClick:(TopScroButton*)butt
{
    if (butt.tag==_seleindex) {
        return;
    }
    TopScroButton *button=[self viewWithTag:_seleindex];
    if (button) {
        button.selected=NO;
        button.bottomView.hidden=YES;
    }
    
    butt.selected=YES;
    butt.bottomView.hidden=NO;
    _seleindex=butt.tag;

    if (_isover==YES) {
        CGFloat flag = ScreenWidth;
        if (butt.frame.origin.x + butt.frame.size.width+ScreenWidth/3>= flag)
        {
            CGFloat offsetX = butt.frame.origin.x + butt.frame.size.width - flag;
            if (_seleindex < _conut)
            {
                offsetX = offsetX + butt.frame.size.width;
            }
            [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
            
        }
        else
        {
            [self setContentOffset:CGPointMake(0, 0) animated:YES];
        }

    }
  
    
    if (self.topScroDelegate &&[self.topScroDelegate respondsToSelector:@selector(touchTag:index:)]) {
        NSLog(@"代理方法");
        [self.topScroDelegate touchTag:self index:butt.tag];
    }
    
}



@end
