//
//  ShopCarBottomView.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/15.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ShopCarBottomView.h"
#import "UIView+SDAutoLayout.h"
@implementation ShopCarBottomView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.nextButton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.lable1=[[UILabel alloc]init];
        self.lable2=[[UILabel alloc]init];
        self.allBtn = [[QMUIButton alloc]init];
        self.allBtn.layer.cornerRadius = 10;
        self.allBtn.layer.masksToBounds = YES;
        self.allBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.allBtn.layer.borderWidth = 1;
        [self addSubview:self.nextButton];
        [self addSubview:self.allBtn];
        [self addSubview:self.lable1];
        [self addSubview:self.lable2];
        
    self.nextButton.sd_layout.topEqualToView(self).bottomEqualToView(self).rightEqualToView(self).widthIs(frame.size.width/3);
        
        self.allBtn.sd_layout.widthIs(20).heightEqualToWidth().centerYEqualToView(self).leftSpaceToView(self, WIDTH_PRO(8));
        
        self.lable1.sd_layout.topSpaceToView(self, 10).leftSpaceToView(self.allBtn, 12).rightSpaceToView(self.nextButton, 8).heightIs(21);
        
        self.lable2.sd_layout.leftSpaceToView(self.allBtn, 10).rightSpaceToView(self.nextButton, 8).topSpaceToView(self.lable1, 5).heightIs(20);
        
        self.lable2.font=[UIFont systemFontOfSize:13];
        self.lable2.textColor=[UIColor lightGrayColor];
        self.lable2.text=@"优惠：￥12.00  运费：￥5.00";
        self.lable1.text=@"￥0.00";
        
        [self.nextButton setTitle:@"下一步" forState:0];
        self.nextButton.titleLabel.font=[UIFont boldSystemFontOfSize:18];
        UIView *linview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
        [self addSubview:linview];
        linview.backgroundColor=[UIColor lightGrayColor];
    }
    return self;
}
-(void)hideAllBtn{
    self.allBtn.hidden = YES;
    self.lable1.sd_layout.topSpaceToView(self, 10).leftSpaceToView(self, 12).rightSpaceToView(self.nextButton, 8).heightIs(21);
    
    self.lable2.sd_layout.leftSpaceToView(self, 10).rightSpaceToView(self.nextButton, 8).topSpaceToView(self.lable1, 5).heightIs(20);
}

@end
