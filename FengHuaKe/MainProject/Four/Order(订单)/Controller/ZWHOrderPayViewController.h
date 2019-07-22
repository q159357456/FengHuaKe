//
//  ZWHOrderPayViewController.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/9.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWHOrderModel.h"
#import "ShopCarModel.h"

@interface ZWHOrderPayViewController : ZWHBaseViewController


//0订单进入 1立即下单  2购物车下单 3保险 4门票 5酒店 6旅游 7会员升级 8美食美味 9拼单
@property(nonatomic,assign)NSInteger state;

@property(nonatomic,strong)NSArray *orderModelList;

@property(nonatomic,assign)NSString *totalPrice;

@property(nonatomic,strong)ServiceBaseModel * baseModel;
@end
