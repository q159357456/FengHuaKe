//
//  CookingDetailModel.h
//  FengHuaKe
//
//  Created by chenheng on 2019/7/16.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CookingDetailModel : NSObject
@property(nonatomic,copy)NSString * code;
@property(nonatomic,copy)NSString * color;
@property(nonatomic,copy)NSString * descr;
@property(nonatomic,copy)NSString * prono;
@property(nonatomic,copy)NSString * property;
@property(nonatomic,copy)NSString * protype;
@property(nonatomic,copy)NSString *putaway;
@property(nonatomic,copy)NSString *saleprice1;
@property(nonatomic,copy)NSString *saleprice2;
@property(nonatomic,copy)NSString *saleprice3;
@property(nonatomic,copy)NSString *saleprice4;
@property(nonatomic,copy)NSString *saleprice5;
@property(nonatomic,assign)BOOL saleunit;
@property(nonatomic,copy)NSString * saleweight;
@property(nonatomic,copy)NSString * saleweightunit;
@property(nonatomic,copy)NSString * spec;
@property(nonatomic,copy)NSString * tax;
@property(nonatomic,copy)NSString * unit;
@property(nonatomic,copy)NSString * url;
@property(nonatomic,copy)NSString * pcs;
@property(nonatomic,copy)NSString * modelnum;
@end

NS_ASSUME_NONNULL_END
