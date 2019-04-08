//
//  ZWHOrderModel.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/8.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZSBaseModel.h"

@interface ZWHOrderModel : ZSBaseModel

@property(nonatomic,copy)NSString *shopid;
@property(nonatomic,copy)NSString *billno;
@property(nonatomic,copy)NSString *creator;
@property(nonatomic,copy)NSString *create_date;
@property(nonatomic,copy)NSString *modifier;
@property(nonatomic,copy)NSString *modi_date;
@property(nonatomic,copy)NSString *membertype;
@property(nonatomic,copy)NSString *memberid;
@property(nonatomic,copy)NSString *totalnum;
@property(nonatomic,copy)NSString *totalamount;
@property(nonatomic,copy)NSString *ismainpoif;
@property(nonatomic,copy)NSString *parentbillno;
@property(nonatomic,copy)NSString *fastcompany;
@property(nonatomic,copy)NSString *fastcode;
@property(nonatomic,copy)NSString *addrid;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *contact;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *remark;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,strong)NSArray *OrderDetail;
@property(nonatomic,strong)NSArray *SubOrder;

@end
