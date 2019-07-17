//
//  ProductModel.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject
@property(nonatomic,copy)NSString *bonus;
@property(nonatomic,copy)NSString *brand;
@property(nonatomic,copy)NSString *firstclassify;
@property(nonatomic,copy)NSString *fitobject;
@property(nonatomic,copy)NSString *fitscene;
@property(nonatomic,copy)NSString *fitsex;
@property(nonatomic,copy)NSString *grade;
@property(nonatomic,copy)NSString *material;
@property(nonatomic,copy)NSString *productno;
@property(nonatomic,copy)NSString *proname;
@property(nonatomic,copy)NSString *proplace;
@property(nonatomic,copy)NSString *putaway;
@property(nonatomic,copy)NSString *saleprice;
@property(nonatomic,copy)NSString *secondclassify;
@property(nonatomic,copy)NSString *sellnums;
@property(nonatomic,copy)NSString *shopid;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *minPrice;
@property(nonatomic,copy)NSString *maxPrice;
@property(nonatomic,copy)NSString *remark;
@property(nonatomic,copy)NSString *code;
+(NSMutableArray *)getDatawithdic:(NSDictionary *)dic;
@end
