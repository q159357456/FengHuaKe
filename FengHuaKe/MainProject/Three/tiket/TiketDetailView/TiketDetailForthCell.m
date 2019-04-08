//
//  TiketDetailForthCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/21.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "TiketDetailForthCell.h"
#define margin 0
@implementation TiketDetailForthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
         self.lable.font=[UIFont systemFontOfSize:12];
        self.lable1=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-70, self.lable.y, 66, self.lable.height)];
        self.lable1.textColor=[UIColor redColor];
        self.lable1.font=[UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:self.lable1];
        
        
        self.lable2=[[UILabel alloc]initWithFrame:CGRectMake(self.lable.x, self.lable.y+self.lable.height+margin, 200, self.lable.height)];
        self.lable2.textColor=MainColor;
        self.lable2.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.lable2];
        
        
        
        self.lable3=[[UILabel alloc]initWithFrame:CGRectMake(self.lable.x, self.lable2.y+self.lable2.height+margin, 80, self.lable.height)];
//        self.lable3.textColor=MainColor;
        self.lable3.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.lable3];
        
        
        self.button1=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-70, CGRectGetMaxY(self.lable1.frame)+10, 60, 30)];
        [self.button1 setTitle:@"预定" forState:UIControlStateNormal];
        [self.button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.button1 rounded:8 ];
        self.button1.backgroundColor=MainColor;
        self.button1.titleLabel.font=[UIFont systemFontOfSize:14];
        [self.button1 addTarget:self action:@selector(yuding) forControlEvents:UIControlEventTouchUpInside];
         [self.contentView addSubview:self.button1];
        
        
        self.button2=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.lable3.frame)+8,self.lable3.y, 80, 20)];
        [self.button2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self.button2 setTitle:@"购买须知>" forState:UIControlStateNormal];
        [self.button2 addTarget:self action:@selector(xuzhi)
               forControlEvents:UIControlEventTouchUpInside];
        self.button2.titleLabel.font=[UIFont systemFontOfSize:12];
         [self.contentView addSubview:self.button2];
       
        
    }
    return self;
}
-(void)setModel:(TicketSubSonModel *)model
{
    _model=model;
    self.contentView.backgroundColor=defaultColor1;
     self.lable.text=model.spec;
    self.lable1.text=[NSString stringWithFormat:@"¥%@",model.saleprice1];
    self.lable2.text=model.property;
    self.lable3.text=[NSString stringWithFormat:@"已售:%@",model.ratio];
    
}

-(void)yuding{
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(CellEvent:Valuae:)]) {
        [self.baseDelegate CellEvent:self Valuae:@1];
    }
    
}
-(void)xuzhi{
    
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(CellEvent:Valuae:)]) {
        [self.baseDelegate CellEvent:self Valuae:@2];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
