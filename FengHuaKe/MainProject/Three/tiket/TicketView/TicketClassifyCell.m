//
//  TicketClassifyCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/20.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "TicketClassifyCell.h"
#import "ImageLabel.h"
@implementation TicketClassifyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setTitles:(NSArray *)titles
{
    _titles=titles;
    NSInteger k=titles.count;
    for (NSInteger i=0; i<k; i++) {
        TicketClassifyModel *model=_titles[i];
        CGFloat w=ScreenWidth/4;
        CGFloat h=70;
        CGFloat x=w*(i%4);
        CGFloat y=floor((CGFloat)(i)/4)* h ;
        ImageLabel *imalable=[ImageLabel initWithFrame:CGRectZero Image:model.icon Title:model.name IsNet:YES];
        imalable.frame=CGRectMake(x, y, w, h);
        [self.contentView addSubview:imalable];
      
        imalable.labelOffsetY=6;
        imalable.tag=i+1;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(traClick:)];
        imalable.userInteractionEnabled=YES;
        [imalable addGestureRecognizer:tap];
        
    }
    
    
    
}
-(void)traClick:(UITapGestureRecognizer*)tap
{
    NSInteger k=tap.view.tag;
    if (self.funBlock) {
        self.funBlock(@(k));
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
