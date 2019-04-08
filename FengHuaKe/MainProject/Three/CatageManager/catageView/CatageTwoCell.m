//
//  CatageTwoCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/28.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "CatageTwoCell.h"
#define cellHeight 200
@implementation CatageTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    [self setUI];
    // Initialization code
}
-(void)setArray:(NSArray<ClassifyModel *> *)array
{
    _array=array;
//    NSArray *imageArray=@[@"ceshi_3_10",@"ceshi_3_11",@"ceshi_3_12",@"ceshi_3_13",@"ceshi_3_14",@"ceshi_3_15"];
    CGFloat colum=5;
    CGFloat line=5.0;
    for (NSInteger i=0; i<array.count; i++) {
        ClassifyModel *model=array[i];
        CGFloat x=(i%3)*((ScreenWidth-32-10)/3+colum);
        CGFloat y=(i/3)*((cellHeight-13-5)/2+line);
        CGFloat w=(ScreenWidth-32-10)/3;
        CGFloat h=(cellHeight-13-5)/2;
        CGRect frame=CGRectMake(x, y, w, h);
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:frame];
        [imageview sd_setImageWithURL:[NSURL URLWithString:[DataProcess PicAdress:model.icon]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
        
        [self.backGround addSubview:imageview];
        imageview.tag=i+1;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapClick:)];
        imageview.userInteractionEnabled=YES;
        [imageview addGestureRecognizer:tap];
    }
}
-(void)setUI
{
    
}
-(void)TapClick:(UITapGestureRecognizer*)tap
{
    NSInteger k=tap.view.tag;
    if (self.funBlock) {
        self.funBlock(@(k));
    }
    
    
}
-(void)getRowHeight
{
    NSLog(@"CatageTwoCell");
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
