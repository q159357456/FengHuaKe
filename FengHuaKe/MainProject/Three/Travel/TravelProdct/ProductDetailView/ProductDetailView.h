//
//  ProductBottomView.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrikeThroughLabel.h"
#import "MsButton.h"
#import "ImageScrollview.h"
#import "ProductDetailModel.h"
@interface ProductDetailView : UIScrollView
{
    ImageScrollview *goodsImgScro;
    
    UIImageView *img_TianMao;//天猫店铺图标
    UILabel *lb_goodsName;//商品名称
    
    UILabel *lb_price;//价格
    UILabel *lb_actitity;//促销活动
    StrikeThroughLabel *lb_oldPrice;//原价
    UILabel *lb_expressDelivery;//快递
    UILabel *lb_sales;//销量
    UILabel *lb_address;//地址
    
}
@property(nonatomic, retain)MsButton *bt_addSize;
@property(nonatomic, retain)MsButton *bt_judge;//评价
@property(nonatomic, retain)MsButton *bt_shop;//店铺信息
@property(nonatomic, retain)UIButton *bt_share;//分享按钮
-(instancetype)initWithFrame:(CGRect)frame andImageArr:(NSArray *)imageArr;
-(void)initdata:(ProductDetailModel *)model;
@end
