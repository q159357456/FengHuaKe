//
//  TicketVM.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/20.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^Success)(id responseData);
typedef void (^Fail)(id erro);
@interface TicketVM : NSObject
/*
 para1:城市 para2:广告类型
 */
+(void)GetADInfoSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail;

+(void)TravelListSysmodel:(NSString*)sysmodel Startindex:(NSString*)startindex Endindex:(NSString*)endindex Success:(Success)Success Fail:(Fail)fail;

+(void)TicketListSysmodel:(NSString*)sysmodel Startindex:(NSString*)startindex Endindex:(NSString*)endindex Success:(Success)Success Fail:(Fail)fail;
//
+(void)TicketSingleSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail;

@end

