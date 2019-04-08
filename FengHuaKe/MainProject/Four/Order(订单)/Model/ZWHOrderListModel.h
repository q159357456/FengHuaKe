//
//  ZWHOrderListModel.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/8.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZSBaseModel.h"

@interface ZWHOrderListModel : ZSBaseModel

@property(nonatomic,copy)NSString *shopid;
@property(nonatomic,copy)NSString *billno;
@property(nonatomic,copy)NSString *item;
@property(nonatomic,copy)NSString *productno;
@property(nonatomic,copy)NSString *proname;
@property(nonatomic,copy)NSString *firstclassify;
@property(nonatomic,copy)NSString *secondclassify;
@property(nonatomic,copy)NSString *num;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *amount;
@property(nonatomic,copy)NSString *membertype;
@property(nonatomic,copy)NSString *memberid;
@property(nonatomic,copy)NSString *url;

@property(nonatomic,copy)NSString *spec;
@property(nonatomic,copy)NSString *color;
@property(nonatomic,copy)NSString *modelnum;
@property(nonatomic,copy)NSString *discount;
@property(nonatomic,copy)NSString *POdiscount;

@property(nonatomic,copy)NSString *context;
@property(nonatomic,copy)NSString *state;
@property(nonatomic,copy)NSString *refundway;
@property(nonatomic,copy)NSString *reason;
@property(nonatomic,copy)NSString *returnway;
@property(nonatomic,copy)NSString *classify;
@property(nonatomic,copy)NSString *sellno;
@property(nonatomic,strong)NSArray *PicList;




@end
