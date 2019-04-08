//
//  HotelViewModel.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^Success)(id responseData);
typedef void (^Fail)(id erro);
@interface HotelViewModel : NSObject
+(void)HotelListSysmodel:(NSString*)sysmodel Startindex:(NSString*)startindex Endindex:(NSString*)endindex Success:(Success)Success Fail:(Fail)fail;
+(void)HotelRoomListSysmodel:(NSString*)sysmodel Startindex:(NSString*)startindex Endindex:(NSString*)endindex Success:(Success)Success Fail:(Fail)fail;
+(void)HotelRoomSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail;
@end
