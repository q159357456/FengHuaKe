//
//  HotelRoomListModel.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotelRoomListModel : NSObject
@property(nonatomic,copy)NSString*rowindex;
@property(nonatomic,copy)NSString*productno;
@property(nonatomic,copy)NSString*shopid;
@property(nonatomic,copy)NSString*proname;
@property(nonatomic,copy)NSString*url;
@property(nonatomic,copy)NSString*material;
@property(nonatomic,copy)NSString*saleprice1;
@property(nonatomic,copy)NSString*spec;
@property(nonatomic,copy)NSString*modelnum;
@property(nonatomic,copy)NSString*Breakfast;
+(NSMutableArray *)getDatawitharray:(NSArray *)array;
@end
