//
//  LocationManager.h
//  ZHONGHUILAOWU
//
//  Created by 秦根 on 2018/4/17.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^LocationBlock)(NSString *province,NSString* city);
typedef void (^La_Lo_nameBlock)(CGFloat latitude,CGFloat longitude,NSString * name);
@interface LocationManager : NSObject
+(instancetype)shareInstabce;
//获取省市
-(void)startLocation:(LocationBlock)locationBlock;
//获取详细地址 经纬度
-(void)startLocationLa_Lo_name:(La_Lo_nameBlock)la_Lo_nameBlock;
@end
