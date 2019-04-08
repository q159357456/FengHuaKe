//
//  TicketVM.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/20.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "TicketVM.h"
#define mysign [DataProcess getMD5Text]
#define mytimestamp [DataProcess getCurrrntDate]
@implementation TicketVM
+(void)GetADInfoSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"System/GetADInfo" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}
+(void)TravelListSysmodel:(NSString*)sysmodel Startindex:(NSString*)startindex Endindex:(NSString*)endindex Success:(Success)Success Fail:(Fail)fail{
    
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:endindex querytype:nil Startindex:startindex Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":endindex,@"startindex":startindex,@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Travel/List" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}

+(void)TicketListSysmodel:(NSString*)sysmodel Startindex:(NSString*)startindex Endindex:(NSString*)endindex Success:(Success)Success Fail:(Fail)fail{
    
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:endindex querytype:nil Startindex:startindex Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":endindex,@"startindex":startindex,@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Ticket/List" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
    
}
+(void)TicketSingleSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail
{
    
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Ticket/Single" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
    
}
@end
