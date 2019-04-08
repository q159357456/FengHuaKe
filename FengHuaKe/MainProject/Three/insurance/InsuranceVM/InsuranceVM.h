//
//  InsuranceVM.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/23.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^Success)(id responseData);
typedef void (^Fail)(id erro);
@interface InsuranceVM : NSObject
+(void)InsureTopListSysmodel:(NSString*)sysmodel Startindex:(NSString*)startindex Endindex:(NSString*)endindex Success:(Success)Success Fail:(Fail)fail;

+(void)InsureListSysmodel:(NSString*)sysmodel Startindex:(NSString*)startindex Endindex:(NSString*)endindex Success:(Success)Success Fail:(Fail)fail;

+(void)InsureSingleSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail
;

+(void)InsurePriceSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail
;

+(void)InsurePriceListSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail;


+(void)POCreateDataList:(NSString*)dataList Success:(Success)Success Fail:(Fail)fail;
@end
