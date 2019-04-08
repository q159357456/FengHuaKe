//
//  LoginManagerVM.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/15.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "LoginManagerVM.h"
#define mysign [DataProcess getMD5Text]
#define mytimestamp [DataProcess getCurrrntDate]
@implementation LoginManagerVM

//发送短息
+(void)SendMobileCodeWithPara1:(NSString*)para1 Para2:(NSString*)para2 Success:(Success)success Fail:(Fail)fail
{
    NSString *jsonpara=[DataProcess getJsonStrWithObj:@{@"para1":para1,@"para2":para2}];
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSDictionary *dic=@{@"sysmodel":jsonpara,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
 
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"System/SendMobileCode" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[DataProcess getJsonWith:responseObject];

        success(dic1[@"sysmodel"][@"strresult"]);
    } Faile:^(NSError *error) {
     
        fail(error);
    }];
}

//注册
+(void)RegisterMemberRegWithPara1:(NSString*)para1 DataList:(id)dataList Success:(Success)success Fail:(Fail)fail
{
    NSString *sysmodelJson=[DataProcess getJsonStrWithObj:@{@"para1":para1}];
    NSString *dataListJson=[DataProcess getJsonStrWithObj:dataList];
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSDictionary *dic=@{@"sysmodel":sysmodelJson,@"DataList":dataListJson,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"--%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Register/MemberReg" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[DataProcess getJsonWith:responseObject];
        success(dic1);
    } Faile:^(NSError *error) {
        fail(error);
    }];
}


//登录
+(void)LoginMemberWithPara1:(NSString*)para1 Para2:(NSString*)para2 Success:(Success)success Fail:(Fail)fail
{
    NSString *jsonpara=[DataProcess getJsonStrWithObj:@{@"para1":para1,@"para2":para2}];
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSDictionary *dic=@{@"sysmodel":jsonpara,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Login/Member" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[DataProcess getJsonWith:responseObject];
                NSLog(@"%@",dic1);
        success(dic1);
    } Faile:^(NSError *error) {
     
        fail(error);
    }];
}
@end
