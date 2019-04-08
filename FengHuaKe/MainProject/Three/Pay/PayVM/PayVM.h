//
//  PayVM.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/17.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^Success)(id responseData);
typedef void (^Fail)(id erro);
@interface PayVM : NSObject
//支付宝支付 POST /api/Alipay/Pay
+(void)AlipayPaySysmodel:(NSString*)sysmodel Datalist:(NSString*)datalist Success:(Success)Success Fail:(Fail)fail;
@end
