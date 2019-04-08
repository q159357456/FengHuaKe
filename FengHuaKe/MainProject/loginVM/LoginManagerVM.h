//
//  LoginManagerVM.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/15.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^Success)(id responseData);
typedef void (^Fail)(id erro);
@interface LoginManagerVM : NSObject
//发送短息
+(void)SendMobileCodeWithPara1:(NSString*)para1 Para2:(NSString*)para2 Success:(Success)success Fail:(Fail)fail;
//注册
+(void)RegisterMemberRegWithPara1:(NSString*)para1 DataList:(id)dataList Success:(Success)success Fail:(Fail)fail;
//登录
+(void)LoginMemberWithPara1:(NSString*)para1 Para2:(NSString*)para2 Success:(Success)success Fail:(Fail)fail;
@end
