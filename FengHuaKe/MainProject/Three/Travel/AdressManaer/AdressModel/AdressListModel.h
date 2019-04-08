//
//  AdressListModel.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/14.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdressListModel : NSObject
@property(nonatomic,copy)NSString *MemberNo;
@property(nonatomic,copy)NSString *Contact;
@property(nonatomic,copy)NSString *Mobile;
@property(nonatomic,copy)NSString *Tips;
@property(nonatomic,copy)NSString *ProvinceCode;
@property(nonatomic,copy)NSString *Province;
@property(nonatomic,copy)NSString *CityCode;
@property(nonatomic,copy)NSString *City;
@property(nonatomic,copy)NSString *DistrictCode;
@property(nonatomic,copy)NSString *District;
@property(nonatomic,copy)NSString *Address;
@property(nonatomic,copy)NSString *DefaultAddr;
@property(nonatomic,copy)NSString *Code;
+(NSMutableArray *)getDatawithdic:(NSDictionary *)dic;
@end
