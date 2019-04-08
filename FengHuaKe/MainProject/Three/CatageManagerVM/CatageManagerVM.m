//
//  CatageManagerVM.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/12.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "CatageManagerVM.h"
#define mysign [DataProcess getMD5Text]
#define mytimestamp [DataProcess getCurrrntDate]
@implementation CatageManagerVM
/**
 获取新闻列表，分页
 */
+(void)NewNewsStartindex:(NSString*)startindex Endindex:(NSString*)endindex Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:endindex querytype:nil Startindex:startindex Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":@{},@"endindex":endindex,@"startindex":startindex,@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"New/News" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}

/**
 获取游记列表，分页
 */
+(void)NewNotesStartindex:(NSString*)startindex Endindex:(NSString*)endindex Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:endindex querytype:nil Startindex:startindex Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":@{},@"endindex":endindex,@"startindex":startindex,@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"New/Notes" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}


/**
 获取攻略列表，分页
 */
+(void)NewGuidesStartindex:(NSString*)startindex Endindex:(NSString*)endindex Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:endindex querytype:nil Startindex:startindex Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":@{},@"endindex":endindex,@"startindex":startindex,@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"New/Guides" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}

/**
 获取单笔新闻
 sysmodel.para1:新闻代码,sysmodel.para2:会员ID
 */
+(void)NewSingleSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"New/Single" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}


/**
 获取某一会员的游记
 sysmodel.para1:会员ID
 */
+(void)NewMyNotesSysmodel:(NSString*)sysmodel Startindex:(NSString*)startindex Endindex:(NSString*)endindex Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:endindex querytype:nil Startindex:startindex Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":endindex,@"startindex":startindex,@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"New/MyNotes" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}


/**
 游记发表
 DataList.title：标题；DataList.tips：标签；DataList.content：内容；DataList.createuser：会员ID；DataList.fromdate：公布时间
 */
+(void)NewAddNotesDataList:(NSString*)dataList Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":@{},@"DataList":dataList,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"New/AddNotes" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}


/**
 游记编辑
 DataList.code：代码；DataList.title：标题；DataList.tips：标签；DataList.content：内容；DataList.createuser：会员ID；DataList.fromdate：公布时间
 */
+(void)NewEditorNotesDataList:(NSString*)dataList Success:(Success)Success Fail:(Fail)fail
{
    
}



/**
 游记删除
 sysmodel.para1：游记代码
 */
+(void)NewDelNotesSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"New/DelNotes" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}



/**
 新闻点赞
 sysmodel.para1：新闻代码, sysmodel.para2：点赞人ID, sysmodel.blresult：取消点赞否
 */
+(void)NewLikeSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"New/Like" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}


/**
 游记中图片上传
 upload传图片接口
 */
+(void)NewImageDataArray:(NSArray*)dataArray Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSDictionary *dic=@{@"sysmodel":@{},@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr,@"DataList":@[]};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr-%@",requestStr);
    NSDictionary *dic1=@{@"json":requestStr,@"dev":@"ios"};
    [[NetDataTool shareInstance]upLoadFile:PAPATH url:@"New/Image" Parameters:dic1 Data:dataArray and:^(id responseObject) {
        
        NSDictionary *dic2=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic2);
    } Faile:^(NSError *error) {
        
        
        fail(error);
        
        
    }];
}

@end
