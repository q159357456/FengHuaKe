//
//  ZWHChooseProView.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/13.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailModel.h"

typedef void (^returnModel)(ProductSpecModel * model,NSInteger number);

@interface ZWHChooseProView : UIView

@property(nonatomic,strong)QMUIButton *addShopCar;
@property(nonatomic,strong)QMUIButton *goPay;

-(void)ShowView;

-(void)HiddenView;

@property(nonatomic,strong)UIScrollView *scroView;

//价格 库存 规格 图片
@property(nonatomic,strong)QMUILabel *price;
@property(nonatomic,strong)QMUILabel *num;
@property(nonatomic,strong)QMUILabel *type;
@property(nonatomic,strong)UIImageView *img;

@property(nonatomic,strong)UILabel *chooseNum;

@property(nonatomic,strong)UITableView *chooseTable;

@property(nonatomic,strong)ProductDetailModel *detailModel;


//最终选择model
@property(nonatomic,strong)ProductSpecModel *productModel;


@property(nonatomic,copy)returnModel goCar;
@property(nonatomic,copy)returnModel payNow;




@end
