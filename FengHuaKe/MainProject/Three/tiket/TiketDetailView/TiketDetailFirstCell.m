//
//  TiketDetailFirstCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/21.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "TiketDetailFirstCell.h"

@implementation TiketDetailFirstCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.lable1=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-70, self.lable.y, 66, self.lable.height)];
        self.lable1.textColor=MainColor;
        self.lable1.textAlignment=NSTextAlignmentCenter;
        self.lable1.font=[UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.lable1];
        
    }
    return self;
}
-(void)setFreight:(NSString *)freight
{
    _freight=freight;
    NSArray *array=[freight componentsSeparatedByString:@"，"];
    if (array) {
        for (NSInteger i =0; i < array.count; i++) {
            CGFloat w=60;
            CGFloat h=18;
            CGFloat x=self.lable.x + i*(w+5);
            CGFloat y=self.lable.y+self.lable.height+8;
            UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
            lable.textAlignment=NSTextAlignmentCenter;
            [lable rounded:2 width:0.5 color:MainColor];
            lable.font=[UIFont systemFontOfSize:9];
            lable.textColor=MainColor;
            [self.contentView addSubview:lable];
            lable.text=[NSString stringWithFormat:@"%@",array[i]];
        }
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
