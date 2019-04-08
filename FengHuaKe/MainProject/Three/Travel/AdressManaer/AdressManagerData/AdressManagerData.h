//
//  AdressManagerData.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/14.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^Success)(id responseData);
typedef void (^Fail)(id erro);
@interface AdressManagerData : NSObject


/**
 POST /api/Address/List
 获取地址列表
 */
+(void)AddressListSysmodel:(NSString*)sysmodel Startindex:(NSString*)startindex Endindex:(NSString*)endindex Success:(Success)Success Fail:(Fail)fail;


/**
 POST /api/Address/Single
 获取单个地址
 */
+(void)AddressSinglSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail;


/**
POST /api/Address/Get
 获取默认地址
 */
+(void)AddressGetSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail;


/**
 POST /api/Address/Add
 添加地址
 */
+(void)AddressAddDatalist:(NSString*)datalist Success:(Success)Success Fail:(Fail)fail;


/**
 POST /api/Address/Editor
 修改地址
 */

+(void)AddressEditorDatalist:(NSString*)datalist Success:(Success)Success Fail:(Fail)fail;


/**
 POST /api/Address/Delete
 删除地址
 */
+(void)AddressDeleteSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail;



/**
 POST /api/Address/Default
 设为默认地址
 */

+(void)AddressDefaultSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail;


/**
 POST /api/Address/Province
 获取省份
 */


+(void)AddressProvinceSuccess:(Success)Success Fail:(Fail)fail;


/**
 POST /api/Address/City
 获取城市
 */
+(void)AddressCitySysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail;



/**
 POST /api/Address/District
 获取县区
 */
+(void)AddressDistrictSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail;
@end
