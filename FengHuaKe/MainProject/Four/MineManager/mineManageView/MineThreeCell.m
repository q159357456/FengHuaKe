//
//  MineThreeCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/29.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "MineThreeCell.h"
#define rowHeight 43
@implementation MineThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}
-(void)updateCellWithData:(id)data
{
    NSLog(@"xxxxxxxxxxinitWithStyle");
    NSArray *titleArray=(NSArray*)data;
    for (NSInteger i=0; i<titleArray.count; i++) {
        CGFloat w=(ScreenWidth-3)/4;
        UILabel *lable1=[[UILabel alloc]initWithFrame:CGRectMake(i*(w+1), 0, w, rowHeight)];
        lable1.text=titleArray[i];
        lable1.tag=i+1;
        lable1.font=[UIFont systemFontOfSize:13];
        lable1.textAlignment=NSTextAlignmentCenter;
        [self addSubview:lable1];
        if (i>0) {
            UILabel *lable2=[[UILabel alloc]initWithFrame:CGRectMake(i*w, 6, 1, rowHeight-12)];
            lable2.backgroundColor=[UIColor lightGrayColor];
            [self.viewForLastBaselineLayout addSubview:lable2];
        }
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
        lable1.userInteractionEnabled=YES;
        [lable1 addGestureRecognizer:tap];
    }
 
    
}
-(void)click:(UIGestureRecognizer*)tap
{
    NSInteger k=tap.view.tag;
    if (self.funBlock) {
        self.funBlock([NSNumber numberWithInteger:k]);
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
