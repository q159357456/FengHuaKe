//
//  HotelListModel.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotelListModel : NSObject
@property(nonatomic,copy)NSString* RowIndex;
@property(nonatomic,copy)NSString*SHOPID;
@property(nonatomic,copy)NSString*ShopName;
@property(nonatomic,copy)NSString*provName;
@property(nonatomic,copy)NSString*cityName;
@property(nonatomic,copy)NSString*boroName;
@property(nonatomic,copy)NSString*commentnums;
@property(nonatomic,copy)NSString*grade;
@property(nonatomic,copy)NSString*LogoUrl;
@property(nonatomic,copy)NSString*Longitude;
@property(nonatomic,copy)NSString*Latitude;
@property(nonatomic,copy)NSString*minPrice;
+(NSMutableArray *)getDatawitharray:(NSArray *)array;
@end
