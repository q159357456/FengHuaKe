//
//  PayVM.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/17.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "PayVM.h"
#define mysign [DataProcess getMD5Text]
#define mytimestamp [DataProcess getCurrrntDate]
@implementation PayVM
+(void)AlipayPaySysmodel:(NSString*)sysmodel Datalist:(NSString*)datalist Success:(Success)Success Fail:(Fail)fail
{
    
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"DataList":datalist,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStrcccc  :%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Alipay/Pay" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
    
}

@end
