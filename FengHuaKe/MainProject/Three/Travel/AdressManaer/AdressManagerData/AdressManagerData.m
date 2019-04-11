//
//  AdressManagerData.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/14.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "AdressManagerData.h"
#define mysign [DataProcess getMD5Text]
#define mytimestamp [DataProcess getCurrrntDate]
@implementation AdressManagerData
/**
 POST /api/Address/List
 获取地址列表
 */
+(void)AddressListSysmodel:(NSString*)sysmodel Startindex:(NSString*)startindex Endindex:(NSString*)endindex Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:endindex querytype:nil Startindex:startindex Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":endindex,@"startindex":startindex,@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Address/List" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}


/**
 POST /api/Address/Single
 获取单个地址
 */
+(void)AddressSinglSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Address/Single" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}


/**
 POST /api/Address/Get
 获取默认地址
 */
+(void)AddressGetSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Address/Get" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}


/**
 POST /api/Address/Add
 添加地址
 */
+(void)AddressAddDatalist:(NSString*)datalist Success:(Success)Success Fail:(Fail)fail
{
    
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSDictionary *dic=@{@"sysmodel":@{},@"DataList":datalist,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Address/Add" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
    
}


/**
 POST /api/Address/Editor
 修改地址
 */

+(void)AddressEditorDatalist:(NSString*)datalist Success:(Success)Success Fail:(Fail)fail
{
    
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSDictionary *dic=@{@"sysmodel":@{},@"DataList":datalist,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Address/Editor" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}


/**
 POST /api/Address/Delete
 删除地址
 */
+(void)AddressDeleteSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Address/Delete" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}



/**
 POST /api/Address/Default
 设为默认地址
 */

+(void)AddressDefaultSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Address/Default" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}


/**
 POST /api/Address/Province
 获取省份
 */

+(void)AddressProvinceSuccess:(Success)Success Fail:(Fail)fail
{
//    NSString *time=mytimestamp;
//    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
//
//    NSDictionary *dic=@{@"sysmodel":@{},@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
//    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
//    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSString *requestStr= GETRequestStr(nil,nil, nil, nil);
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Address/Province" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}


/**
 POST /api/Address/City
 获取城市
 */
+(void)AddressCitySysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Address/City" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}



/**
 POST /api/Address/District
 获取县区
 */
+(void)AddressDistrictSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Address/District" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}
@end
