//
//  MineOneCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/29.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "MineOneCell.h"
#import "Masonry.h"
#define cellHeight 43
@interface MineOneCell()
{
    NSInteger _k;
}
@end
@implementation MineOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUI];
    // Initialization code
}
-(void)setUI
{
    NSArray *imageArray=@[@"ceshi_4_1",@"ceshi_4_2",@"ceshi_4_3"];
    NSArray *titleArray=@[@"我行我秀",@"游记",@"购物车"];
    _k=0;
    for (NSInteger i=0; i<imageArray.count; i++) {
        CGFloat x=i*ScreenWidth/3;
        CGFloat y=0;
        CGFloat w=ScreenWidth/3;
        CGFloat h=cellHeight;
        CGRect frame=CGRectMake(x, y, w, h);
        [self getimaLableWithFrame:frame Str:titleArray[i] ImageStr:imageArray[i]];
       
        
    }
}
-(void)getimaLableWithFrame:(CGRect)frame Str:(NSString*)str ImageStr:(NSString*)imagestr
{
    _k++;
    UIView *imagLableView=[[UIView alloc]initWithFrame:frame];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    imagLableView.tag=_k;
    [imagLableView addGestureRecognizer:tap];
    [self addSubview:imagLableView];
    UIImageView *imageview=[[UIImageView alloc]init];
    imageview.image=[UIImage imageNamed:imagestr];
    UILabel *lable=[[UILabel alloc]init];
    [imagLableView addSubview:imageview];
    [imagLableView addSubview:lable];
    lable.text=str;
    lable.font= [UIFont systemFontOfSize:13];
    CGFloat lableWith=60;
    CGFloat imageHeight=20;
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imageHeight, imageHeight));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(imagLableView.mas_centerX).offset(-20);
        
    }];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(lableWith, 20));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(imagLableView.mas_centerX).offset(-20);
    }];
 
}
-(void)click:(UITapGestureRecognizer*)tap
{
    NSInteger j=tap.view.tag;
    if (self.funBlock) {
       
        self.funBlock([NSNumber numberWithInteger:j]);
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
