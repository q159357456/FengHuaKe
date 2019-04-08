//
//  CatageOneCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/29.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "CatageOneCell.h"
#import "ImageLabel.h"
#import "Masonry.h"
@implementation CatageOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self setupUI];
    }
    return self;
}
-(void)setArray:(NSArray<ClassifyModel *> *)array
{
    _array=array;
    self.contentView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    _backGround=[[UIView alloc]initWithFrame:CGRectMake(16, 16, ScreenWidth-32, 200-32)];
    _backGround.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.backGround];
//    NSArray *imageArray=@[@"ceshi_3_2",@"ceshi_3_3",@"ceshi_3_4",@"ceshi_3_5",@"ceshi_3_6",@"ceshi_3_7",@"ceshi_3_8",@"ceshi_3_9"];
//    NSArray *titleArray=@[@"机票",@"酒店",@"美食美味",@"门票",@"签证",@"租车",@"旅游新闻",@"企业会员足迹"];
    for (NSInteger i=0; i<array.count; i++) {
        ClassifyModel *model=array[i];
        CGFloat x=(i%4)*(self.backGround.width)/4;
        CGFloat y=(i/4)*self.backGround.height/2;
        CGFloat w=self.backGround.width/4;
        CGFloat h=self.backGround.height/2;
        ImageLabel *imalable=[ImageLabel initWithFrame:CGRectZero Image:model.icon Title:model.name IsNet:YES];
        [self.backGround addSubview:imalable];
        [imalable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.backGround.mas_left).offset(x);
            make.top.mas_equalTo(self.backGround.mas_top).offset(y);
            make.width.mas_equalTo(w);
            make.height.mas_equalTo(h);
            
        }];
        imalable.labelOffsetY=6;
        imalable.tag=i+1;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(traClick:)];
        imalable.userInteractionEnabled=YES;
        [imalable addGestureRecognizer:tap];
        
    }
    
}
-(void)setupUI
{
   
}
-(void)traClick:(UITapGestureRecognizer*)tap
{
    NSInteger k=tap.view.tag;
    if (self.funBlock) {
        self.funBlock(@(k));
    }
    
    
}
-(void)getRowHeight
{
    NSLog(@"CatageOneCell");
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
