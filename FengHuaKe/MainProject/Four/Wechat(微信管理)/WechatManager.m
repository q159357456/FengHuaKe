//
//  WechatManager.m
//  FengHuaKe
//
//  Created by chenheng on 2019/7/11.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "WechatManager.h"
#import "WXApi.h"
@implementation WechatManager
+(instancetype)sharedManager
{
    static WechatManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[WechatManager alloc] init];
    });
    
    return manager;
}
+ (void)weiXinPayWithDic:(NSDictionary *)wechatPayDic {
    NSLog(@"wechatPayDic==>%@",wechatPayDic);
    
//    NSDictionary * dic = wechatPayDic[@"data"];
//    PayReq *req = [[PayReq alloc] init];
//    req.openID =dic [@"appId"];
//    req.partnerId = dic [@"mchId"];
//    req.prepayId = [dic  objectForKey:@"prepayId"];
//    req.package = dic [@"packages"];
//    req.nonceStr = [dic  objectForKey:@"nonceStr"];
//    req.timeStamp = [[dic  objectForKey:@"timestamp"] intValue];
//    req.sign = [dic  objectForKey:@"sign"];
//    [WXApi sendReq:req];
}
@end
