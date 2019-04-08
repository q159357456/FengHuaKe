//
//  InsuranceVM.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/23.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "InsuranceVM.h"
#define mysign [DataProcess getMD5Text]
#define mytimestamp [DataProcess getCurrrntDate]
@implementation InsuranceVM
+(void)InsureTopListSysmodel:(NSString*)sysmodel Startindex:(NSString*)startindex Endindex:(NSString*)endindex Success:(Success)Success Fail:(Fail)fail{
    
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:endindex querytype:nil Startindex:startindex Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":endindex,@"startindex":startindex,@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Insure/TopList" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}

+(void)InsureListSysmodel:(NSString*)sysmodel Startindex:(NSString*)startindex Endindex:(NSString*)endindex Success:(Success)Success Fail:(Fail)fail{
    
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:endindex querytype:nil Startindex:startindex Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":endindex,@"startindex":startindex,@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Insure/List" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
    
}
+(void)InsureSingleSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Insure/Single" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}

+(void)InsurePriceSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Insure/Price" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}


+(void)InsurePriceListSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail{
    
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Insure/PriceList" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
    
}


+(void)POCreateDataList:(NSString*)dataList Success:(Success)Success Fail:(Fail)fail{
    
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSDictionary *dic=@{@"sysmodel":@{},@"DataList":dataList,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];

    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"PO/Create" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}
@end
