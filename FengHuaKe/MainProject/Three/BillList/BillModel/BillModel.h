//
//  BillModel.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BillModel : NSObject
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
+(NSMutableArray *)getDatawithdic:(NSDictionary *)dic;
+(NSMutableArray*)getUsefulDicStr:(NSDictionary*)dic;
@end

@interface OrderDetailModel :NSObject
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
+(NSMutableArray *)getDatawithdic:(NSArray *)data;
@end




