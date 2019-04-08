//
//  ZWHProductDetailView.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/13.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "ProductDetailModel.h"

@interface ZWHProductDetailView : UIView

@property(nonatomic,strong)SDCycleScrollView *topScrView;

@property(nonatomic,strong)QMUILabel *name;
@property(nonatomic,strong)QMUILabel *price;
@property(nonatomic,strong)QMUILabel *type;
@property(nonatomic,strong)QMUILabel *oldprice;
@property(nonatomic,strong)QMUILabel *express;
@property(nonatomic,strong)QMUILabel *num;
@property(nonatomic,strong)QMUILabel *address;
@property(nonatomic,strong)QMUIButton *share;


@property(nonatomic,strong)ProductDetailModel *model;


@end
