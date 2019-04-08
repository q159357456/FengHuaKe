//
//  ProductVM.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ProductVM.h"
#define mysign [DataProcess getMD5Text]
#define mytimestamp [DataProcess getCurrrntDate]
@implementation ProductVM
/**
 POST /api/Product/List
 产品列表（可模糊搜索）
 sysmodel.para1:一级大类（模块）【必填】；
 sysmodel.para2;2级大类【可选】；
 sysmodel.para3:产品名称【可选】；
 sysmodel.para4:材质【可选】；
 sysmodel.para5:适用对象【可选】；
 sysmodel.para6:适用性别【可选】；
 sysmodel.para7:适用场景【可选】；
 sysmodel.para8:规格【可选】；
 sysmodel.para9:颜色【可选】；
 sysmodel.strresult:型号【可选】；
 */
+(void)ProductListSysmodel:(NSString*)sysmodel Startindex:(NSString*)startindex Endindex:(NSString*)endindex Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:endindex querytype:nil Startindex:startindex Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":endindex,@"startindex":startindex,@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Product/List" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}
/**
 获取单个产品信息【包含产品规格、产品图片】
 POST /api/Product/Single
 sysmodel.para1:产品代码
 
 */
+(void)ProductSingleSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Product/Single" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
    
}

/**
 POST /api/FirstClassify/List
 获取一级大类
 sysmodel.para1:上级编号【可选】
 */
+(void)FirstClassifyListSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"FirstClassify/List" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
    
}

/**
 POST /api/Classify/List
 获取二级分类
 sysmodel.para1：一级分类ID【必选】；sysmodel.para2：分类上级ID【可选】
 */
+(void)ClassifyListSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Classify/List" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
    
}

/**
 POST /api/Brand/List 获取分类下的品牌
 sysmodel.para1：品牌大类
 */

+(void)BrandListSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Brand/List" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}
/**
 POST /api/Cart/List
 获取购物车记录【sysmodel.strresult 结果集】
 sysmodel.para1：会员ID(必选)，sysmodel.para2：会员类型【S：商家；M：会员】(必选)，sysmodel.para3：一级大类ID
 */

+(void)CartListSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Cart/List" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}

/**
 POST /api/Cart/Modify
 修改购物车数量（购物车中不存在数据时新增一笔购物车记录
 prono【必选】、prospecno【必选】、firstclassify【必选】、secondclassify【必选】、memberid【必选】、membertype【必选】、shopid【必选】、nums【可选，不传或小于等于0默认为1】
 */
+(void)CartModifyDataList:(NSString*)dataList Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSDictionary *dic=@{@"sysmodel":@{},@"DataList":dataList,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Cart/Modify" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
    
}


/**
 POST /api/Cart/Delete
 删除购物车中的记录 WHERE prono、prospecno、firstclassify、secondclassify、memberid、membertype
 prono【必选】、prospecno【必选】、firstclassify【必选】、secondclassify【必选】、memberid【必选】、membertype【必选】、shopid【必选】
 */
+(void)CartDeleteDataList:(NSString*)dataList Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":@{},@"DataList":dataList,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Cart/Delete" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}

/**
 POST /api/Cart/DeleteFirstClass
 删除购物车中某个大类下的记录 WHERE firstclassify、memberid、membertype
 firstclassify【必选】、memberid【必选】、membertype【必选】
 */
+(void)CartDeleteFirstClassDataList:(NSString*)dataList Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":@{},@"DataList":dataList,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Cart/DeleteFirstClass" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}

/**
 POST /api/Cart/DeleteAll
 删除我的购物车中的记录 WHERE memberid、membertype
 memberid【必选】、membertype【必选】
 */
+(void)CartDeleteAllDataList:(NSString*)dataList Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":@{},@"DataList":dataList,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Cart/DeleteAll" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}

/**
 POST /api/Bill/Create
 生成订单strresult订单号
 sysmodel.para1：地址ID【必选】， sysmodel.para2:：备注， sysmodel.para3：会员ID【必选】； sysmodel.para4：会员类型【必选】； sysmodel.intresult：支付方式【0：在线支付(默认)；1：到店支付；2：货到付款；】【必选】； sysmodel.blresult：是否为购物车下单【立即下单 false】； DataList：购物车【prono：品号；prospecno：规格代码；nums：购买数量】
 */
+(void)BillCreateSysmodel:(NSString*)sysmodel DataList:(NSString*)dataList Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"DataList":dataList,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Bill/Create" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}

/**
 POST /api/Bill/List
 订单列表【分页】
 sysmodel.intresult：订单状态【0：全部；1:下单待付；2：已付待发；3：发货待收；4：待评价；5：已完成；】；sysmodel.para1：会员id；sysmodel.para2：会员类型；
 */
+(void)BillListSysmodel:(NSString*)sysmodel Startindex:(NSString*)startindex Endindex:(NSString*)endindex Success:(Success)Success Fail:(Fail)fail;
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:endindex querytype:nil Startindex:startindex Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":endindex,@"startindex":startindex,@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Bill/List" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}

/**
 POST /api/Bill/Single
 订单详情
 sysmodel.para1：订单单号；sysmodel.para2：会员编号；sysmodel.para3：会员类型；
 */
+(void)BillSingleSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail
{
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Bill/Single" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}

@end
