//
//  ProductBottomView.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ProductDetailView.h"
#import "UIView+SDAutoLayout.h"
#define RMB @"¥"
@implementation ProductDetailView
@synthesize bt_addSize,bt_judge,bt_shop,bt_share;
-(instancetype)initWithFrame:(CGRect)frame andImageArr:(NSArray *)imageArr
{
    self=[super initWithFrame:frame];
    if (self) {
         NSLog(@"initWithFrame");
         self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 430)];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        if (imageArr.count == 0) {
            imageArr = @[@""];
        }
        goodsImgScro = [[ImageScrollview alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 260) andImageArr:imageArr];
        [view addSubview:goodsImgScro];
        
        bt_share=[[UIButton alloc]initWithFrame:CGRectZero];
        [bt_share setBackgroundImage:[UIImage imageNamed:@"share"] forState:0];
        [view addSubview:bt_share];
        bt_share.sd_layout.rightSpaceToView(view, 0).heightIs(40).widthIs(58).topSpaceToView(goodsImgScro, 10);
        //
        lb_goodsName=[[UILabel alloc]init];
        lb_goodsName.textColor=[UIColor blackColor];
        lb_goodsName.font = [UIFont systemFontOfSize:18];
        lb_goodsName.numberOfLines = 2;
        [view addSubview:lb_goodsName];
        lb_goodsName.sd_layout.topSpaceToView(goodsImgScro, 10).leftSpaceToView(view, 10).rightSpaceToView(bt_share, 10).heightIs(45);
        //
        img_TianMao = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tianmao"]];
        [view addSubview:img_TianMao];
        img_TianMao.sd_layout.topSpaceToView(goodsImgScro,12).leftEqualToView(lb_goodsName).heightIs(18).widthIs(21);
        //
        lb_price = [[UILabel alloc] initWithFrame:CGRectZero];
        lb_price.textColor = [UIColor colorWithRed:244/255.0 green:56/255.0  blue:11/255.0  alpha:1];
        lb_price.font = [UIFont systemFontOfSize:30];
        [view addSubview:lb_price];
        lb_price.sd_layout.topSpaceToView(lb_goodsName,10).leftSpaceToView(view,10).heightIs(40).widthIs(100);
        //
        lb_actitity = [[UILabel alloc] initWithFrame:CGRectZero];
        lb_actitity.textColor = [UIColor whiteColor];
        lb_actitity.backgroundColor = [UIColor colorWithRed:244/255.0 green:56/255.0  blue:11/255.0  alpha:1];
        lb_actitity.textAlignment = NSTextAlignmentCenter;
        lb_actitity.font = [UIFont systemFontOfSize:10];
        [view addSubview:lb_actitity];
        lb_actitity.sd_layout.topSpaceToView(lb_goodsName,22).leftSpaceToView(lb_price,10).heightIs(16).widthIs(100);
        //
        
        lb_oldPrice = [[StrikeThroughLabel alloc] initWithFrame:CGRectZero];
        lb_oldPrice.textColor = [UIColor lightGrayColor];
        lb_oldPrice.font = [UIFont systemFontOfSize:14];
        [view addSubview:lb_oldPrice];
        lb_oldPrice.sd_layout.topSpaceToView(lb_price,10).leftSpaceToView(view,10).heightIs(20).widthIs(20);
        
        //
        lb_expressDelivery = [[UILabel alloc] initWithFrame:CGRectZero];
        lb_expressDelivery.textColor = [UIColor lightGrayColor];
        lb_expressDelivery.font = [UIFont systemFontOfSize:14];
        [view addSubview:lb_expressDelivery];
        lb_expressDelivery.sd_layout.topSpaceToView(lb_oldPrice,10).leftSpaceToView(view,10).heightIs(20).widthIs(100);
        //
        lb_sales = [[UILabel alloc] initWithFrame:CGRectZero];
        lb_sales.textColor = [UIColor lightGrayColor];
        lb_sales.textAlignment = NSTextAlignmentCenter;
        lb_sales.font = [UIFont systemFontOfSize:14];
        [view addSubview:lb_sales];
        lb_sales.sd_layout.topSpaceToView(lb_oldPrice,10).centerXEqualToView(view).heightIs(20).widthIs(100);
        //
        lb_address = [[UILabel alloc] initWithFrame:CGRectZero];
        lb_address.textColor = [UIColor lightGrayColor];
        lb_address.textAlignment = NSTextAlignmentRight;
        lb_address.font = [UIFont systemFontOfSize:14];
        [view addSubview:lb_address];
        lb_address.sd_layout.topSpaceToView(lb_oldPrice,10).rightSpaceToView(view,10).heightIs(20).widthIs(100);
        //
        
        bt_addSize = [[MsButton alloc] initWithFrame:CGRectMake(0, view.frame.size.height+10, self.frame.size.width, 50) Head:nil Message:nil];
        bt_addSize.msgLabel.frame = CGRectMake(0, bt_addSize.frame.size.height-1, bt_addSize.frame.size.width, 1);
        bt_addSize.msgLabel.backgroundColor = [UIColor lightGrayColor];
        
        bt_addSize.headLabel.frame = CGRectMake(10, 0, bt_addSize.frame.size.width -50, bt_addSize.frame.size.height);
        bt_addSize.backgroundColor = [UIColor whiteColor];
        bt_addSize.jiantou.image = [UIImage imageNamed:@"set_ico_r"];
        bt_addSize.jiantou.frame = CGRectMake(bt_addSize.frame.size.width-15, (bt_addSize.frame.size.height-16)/2, 10, 16);
        [self addSubview:bt_addSize];
        //
        [self inittips];
    }
    return self;
    
}
#pragma mark - private
-(void)inittips
{
//    UILabel *lb_leftline = [[UILabel alloc] initWithFrame:CGRectMake(10, bt_shop.frame.size.height+bt_shop.frame.origin.y+20, 100, 0.5)];
//    lb_leftline.backgroundColor = [UIColor lightGrayColor];
//    [self addSubview:lb_leftline];
//
//    UILabel *lb_rightline = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-110, bt_shop.frame.size.height+bt_shop.frame.origin.y+20, 100, 0.5)];
//    lb_rightline.backgroundColor = [UIColor lightGrayColor];
//    [self addSubview:lb_rightline];
//
//    UILabel *lb_tips = [[UILabel alloc] initWithFrame:CGRectMake(lb_leftline.frame.origin.x+lb_leftline.frame.size.width, bt_shop.frame.size.height+bt_shop.frame.origin.y+10, lb_rightline.frame.origin.x-(lb_leftline.frame.origin.x+lb_leftline.frame.size.width), 20)];
//    lb_tips.textAlignment = NSTextAlignmentCenter;
//    lb_tips.font = [UIFont systemFontOfSize:12];
//    lb_tips.backgroundColor = [UIColor clearColor];
//    lb_tips.text = @"继续拖动查看图文详情";
//    [self addSubview:lb_tips];
    self.contentSize = CGSizeMake(self.frame.size.width, bt_addSize.frame.origin.y+60);
}


#pragma mark - private
-(void)initdata:(ProductDetailModel *)model
{
    
    NSLog(@"initdata");
    NSLog(@"%@",model);
    //传进来的字典里面包含以下信息
    BOOL isTianMao = 0;//是否是天猫店铺 是的话就要显示天猫图标
    BOOL isActivity = 1;//是否有促销活动
    if (isTianMao) {
        img_TianMao.hidden = NO;
        lb_goodsName.text = @"      2016春装新款长袖小西装外套女韩版修身荷叶边短款糖果色小西服潮";
    }else
    {
        img_TianMao.hidden = YES;
        lb_goodsName.text = model.proname;
    }
    
    lb_price.text = [NSString stringWithFormat:@"%@%@",RMB,model.minsaleprice];
    NSDictionary *fontdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:30],NSFontAttributeName, nil];
    CGSize size = [lb_price.text sizeWithAttributes:fontdic];
    lb_price.sd_layout.widthIs(size.width);
    
    if (isActivity) {
        lb_actitity.text = @"踏青囤货价";
        fontdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10],NSFontAttributeName, nil];
        size = [lb_actitity.text sizeWithAttributes:fontdic];
        lb_actitity.sd_layout.widthIs(size.width+5).leftSpaceToView(lb_price,10);
    }
    
    //原价
    lb_oldPrice.text = [NSString stringWithFormat:@"价格:%@",model.maxsaleprice];

    lb_oldPrice.strikeThroughEnabled = YES;
    fontdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName, nil];
    size = [lb_oldPrice.text sizeWithAttributes:fontdic];
    NSLog(@"size.width:%f",size.width);
    lb_oldPrice.sd_layout.widthIs(size.width);
    
    
    
    lb_expressDelivery.text = @"快递:00";
    lb_sales.text = [NSString stringWithFormat:@"月销量%@笔",model.sellnums];
    lb_address.text = model.proplace;
    
    bt_addSize.headLabel.text = @"选择 颜色 规格";
//    bt_judge.headLabel.text = @"宝贝评价(10022)";
    
//    bt_shop.jiantou.image = [UIImage imageNamed:@"1.jpg"];
//    bt_shop.headLabel.text = @"彩黛妃旗舰店";
//    bt_shop.msgLabel.text = @"天猫 TIANMAO.COM";
}

@end
