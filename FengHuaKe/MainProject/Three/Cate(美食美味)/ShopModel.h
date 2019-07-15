//
//  ShopModel.h
//  FengHuaKe
//
//  Created by chenheng on 2019/7/15.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopModel : NSObject
@property(nonatomic,copy)NSString * SHOPID;
@property(nonatomic,copy)NSString * ShopName;
@property(nonatomic,copy)NSString * LogoUrl;
@property(nonatomic,copy)NSString * cityName;
@property(nonatomic,assign)NSInteger  grade;
@end

NS_ASSUME_NONNULL_END
