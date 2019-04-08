//
//  FriendShowHeader.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/10.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "FriendShowHeader.h"
#import "Masonry.h"
@implementation FriendShowHeader
{
    NSInteger _k;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
    
}
-(void)setUI
{
    NSArray *imageArray=@[@"friendShow_1",@"friendShow_2",@"friendShow_3"];
    NSArray *titleArray=@[@"旅游",@"相册",@"足迹"];
    _k=0;
    for (NSInteger i=0; i<imageArray.count; i++) {
        CGFloat x=i*ScreenWidth/3;
        CGFloat y=0;
        CGFloat w=ScreenWidth/3;
        CGFloat h=60;
        CGRect frame=CGRectMake(x, y, w, h);
        [self getimaLableWithFrame:frame Str:titleArray[i] ImageStr:imageArray[i]];
    }
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = LINECOLOR;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
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
    CGFloat lableWith=30;
    CGFloat imageHeight=20;
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imageHeight, imageHeight));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(imagLableView.mas_centerX).offset(-5);
        
    }];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(lableWith, 20));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(imagLableView.mas_centerX).offset(-5);
    }];
    
}
-(void)click:(UITapGestureRecognizer*)tap
{
    NSInteger j=tap.view.tag;
    if (self.funBlock) {
        
        self.funBlock(j);
    }
    
}

@end
