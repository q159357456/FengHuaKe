//
//  ShopCarModel.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/14.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCarModel : NSObject
@property(nonatomic,copy)NSString *ShopName;
@property(nonatomic,copy)NSString *proname;
@property(nonatomic,copy)NSString *spec;
@property(nonatomic,copy)NSString *color;
@property(nonatomic,copy)NSString *modelnum;
@property(nonatomic,copy)NSString *saleunit;
@property(nonatomic,copy)NSString *saleweight;
@property(nonatomic,copy)NSString *saleweightunit;
@property(nonatomic,copy)NSString *saleprice1;
@property(nonatomic,copy)NSString *appPCS;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *prono;
@property(nonatomic,copy)NSString *prospecno;
@property(nonatomic,copy)NSString *shopid;
@property(nonatomic,copy)NSString *firstclassify;
@property(nonatomic,copy)NSString *secondclassify;
@property(nonatomic,copy)NSString *memberid;
@property(nonatomic,copy)NSString *membertype;
@property(nonatomic,copy)NSString *nums;
@property(nonatomic,copy)NSString *createdate;
@property(nonatomic,copy)NSString *modifydate;
@property(nonatomic,assign)BOOL isSelected;
+(NSMutableArray *)getDatawithdic:(NSArray *)data;
@end
