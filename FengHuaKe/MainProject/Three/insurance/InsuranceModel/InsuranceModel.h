//
//  InsuranceModel.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/23.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InsuranceModel : NSObject
@property(nonatomic,copy)NSString* claim;
@property(nonatomic,copy)NSString*classify;
@property(nonatomic,copy)NSString*code;
@property(nonatomic,copy)NSString*codename;
@property(nonatomic,copy)NSString*descr;
@property(nonatomic,copy)NSString*firstclassify;
@property(nonatomic,copy)NSString*img;
@property(nonatomic,copy)NSString*istop;
@property(nonatomic,copy)NSString*maxPrice;
@property(nonatomic,copy)NSString*minPrice;
@property(nonatomic,copy)NSString*remark;
@property(nonatomic,copy)NSString*tips;
@property(nonatomic,copy)NSString *totalamount;
@property(nonatomic,copy)NSString *proname;
@property(nonatomic,copy)NSString *dayname;

@property(nonatomic,strong)NSArray *OrderDetail;

+(NSMutableArray *)getDatawithdic:(NSDictionary *)dic;
@end
