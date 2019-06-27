//
//  AdressModel.h
//  FengHuaKe
//
//  Created by chenheng on 2019/6/27.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdressModel : NSObject
@property(nonatomic,copy)NSString * Province;
@property(nonatomic,copy)NSString * ProvinceCode;
@property(nonatomic,copy)NSString * City;
@property(nonatomic,copy)NSString * CityCode;
@property(nonatomic,copy)NSString * District;
@property(nonatomic,copy)NSString * DistrictCode;
@end

NS_ASSUME_NONNULL_END
