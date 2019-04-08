//
//  ContractManagerVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/15.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ContractManagerVC.h"

#define mysign [DataProcess getMD5Text]
#define mytimestamp [DataProcess getCurrrntDate]


@implementation ContractManagerVC
//搜索好友
+(void)UserListWithPara:(NSString*)para Success:(Success)Success Fail:(Fail)fail
{
    
    NSString *jsonStr=[DataProcess getJsonStrWithObj:@{@"para1":para}];
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSDictionary *dic=@{@"sysmodel":jsonStr,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Register/UserList" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {

        fail(error);
    }];
}
//获取所自己所有的好友
+(void)SystemCommonWithID:(NSString*)ID Success:(Success)Success Fail:(Fail)fail
{
    NSString *systemJson=[DataProcess getJsonStrWithObj:@{@"para1":@"ring_myfriend"}];
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSString *dataListJson=[DataProcess getJsonStrWithObj:@[@{Field:@"myid",Left:@false,Logical:@"0",Operation:@"0",Right:@false,KValue:ID}]];
    NSDictionary *dic=@{@"sysmodel":systemJson,@"DataList":dataListJson,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"System/Common" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
    
}
//添加好友
+(void)RegisterFriendAddWithPara1:(NSString*)para1 Para2:(NSString*)para2 Para3:(NSString*)para3 Success:(Success)Success Fail:(Fail)fail
{
    NSString *sysmodelJson=[DataProcess getJsonStrWithObj:@{@"para1":para1,@"para2":para2,@"para3":para3}];
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSDictionary *dic=@{@"sysmodel":sysmodelJson,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Register/FriendAdd" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}

//删除好友
+(void)RegisterFriendDelWithDatalist:(NSString*)datalist Success:(Success)Success Fail:(Fail)fail
{
    NSString *sysmodelJson=[DataProcess getJsonStrWithObj:@{}];
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSDictionary *dic=@{@"sysmodel":sysmodelJson,@"DataList":datalist,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Register/FriendDel" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}
//搜索群组
+(void)SystemCommonGroupWithKeyWord:(NSString*)keyword Success:(Success)Success Fail:(Fail)fail
{
    NSString *systemJson=[DataProcess getJsonStrWithObj:@{@"para1":@"ring_chatgroup"}];
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSString *dataListJson=[DataProcess getJsonStrWithObj:@[@{Field:@"groupname",Left:@false,Logical:@"0",Operation:@"5",Right:@false,KValue:keyword}]];
    NSDictionary *dic=@{@"sysmodel":systemJson,@"DataList":dataListJson,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"System/Common" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}
//获取自己所有的群组(自己是群主)
+(void)SystemCommonGroupWithID:(NSString*)ID Success:(Success)Success Fail:(Fail)fail
{
    NSString *systemJson=[DataProcess getJsonStrWithObj:@{@"para1":@"ring_chatgroup"}];
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSString *dataListJson=[DataProcess getJsonStrWithObj:@[@{Field:@"owner",Left:@false,Logical:@"0",Operation:@"0",Right:@false,KValue:ID}]];
    NSDictionary *dic=@{@"sysmodel":systemJson,@"DataList":dataListJson,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"System/Common" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
    
}
//获取自己所有的相关群组
+(void)RegisterUserDetailForCharGroupSuccess:(Success)Success Fail:(Fail)fail
{
    NSString *systemJson=[DataProcess getJsonStrWithObj:@{@"para1":@"",@"para2":UniqUserID}];
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSDictionary *dic=@{@"sysmodel":systemJson,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Register/UserDetailForCharGroup" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"获取自己所有的相关群组:%@",dic1);

        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}

//创建群组
+(void)RegisterChatGroupAddWithDtalist:(NSString*)datalist Success:(Success)Success Fail:(Fail)fail
{
    NSString *systemJson=[DataProcess getJsonStrWithObj:@{}];
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];

    NSDictionary *dic=@{@"sysmodel":systemJson,@"DataList":datalist,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Register/ChatGroupAdd" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}
//加入群组(群组中添加成员)
+(void)RegisterChatGroupAddMember:(NSString*)dataList  Success:(Success)Success Fail:(Fail)fail
{
    NSString *systemJson=[DataProcess getJsonStrWithObj:@{}];
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":systemJson,@"DataList":dataList,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Register/ChatGroupAddMember" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}

//群组中删除成员
+(void)RegisterChatGroupDelMember:(NSString*)dataList  Success:(Success)Success Fail:(Fail)fail
{
    NSString *systemJson=[DataProcess getJsonStrWithObj:@{}];
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":systemJson,@"DataList":dataList,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Register/ChatGroupDelMember" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
    
}
//通过id获取user信息
+(void)SystemCommonGroupWithuserid:(NSString*)userid Success:(Success)Success Fail:(Fail)fail
{
    NSString *systemJson=[DataProcess getJsonStrWithObj:@{@"para1":@"ring_users"}];
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSArray *datalistArray=@[@{Field:@"myid",Left:@false,Logical:@"0",Operation:@"0",Right:@false,KValue:userid}];
    NSString *datalistStr=[DataProcess getJsonStrWithObj:datalistArray];
    NSDictionary *dic=@{@"sysmodel":systemJson,@"DataList":datalistStr,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"System/Common" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}
//获取群组所有群成员资料
+(void)RegisterChatGroupUserListWithGroupid:(NSString*)groupid Success:(Success)Success Fail:(Fail)fail
{
    NSString *systemJson=[DataProcess getJsonStrWithObj:@{@"para1":groupid}];
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSDictionary *dic=@{@"sysmodel":systemJson,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Register/ChatGroupUserList" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"所有群成员资料:%@",dic1);
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}

//删除群租
+(void)RegisterChatGroupDelWithOwner:(NSString*)ownerid Groupid:(NSString*)groupid Success:(Success)Success Fail:(Fail)fail
{
    NSString *systemJson=[DataProcess getJsonStrWithObj:@{@"para1":ownerid,@"para2":groupid}];
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSDictionary *dic=@{@"sysmodel":systemJson,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Register/ChatGroupDel" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"删除结果:%@",dic1);
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}
//获取好友申请中好友的详细资料
+(void)RegisterUserInfoWithDatalist:(NSString*)datalist Success:(Success)Success Fail:(Fail)fail
{
    NSString *systemJson=[DataProcess getJsonStrWithObj:@{}];
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":systemJson,@"DataList":datalist,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Register/UserInfo" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}

//我的好友分组添加
+(void)RegisterGroupAdd:(NSString*)para2 Success:(Success)Success Fail:(Fail)fail
{
    NSString *systemJson=[DataProcess getJsonStrWithObj:@{@"para1":UniqUserID,@"para2":para2}];
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSDictionary *dic=@{@"sysmodel":systemJson,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Register/GroupAdd" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        //        NSLog(@"获取自己所有的相关群组:%@",dic1);
        
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}
//删除分组
+(void)RegisterGroupDel:(NSString*)para2 Success:(Success)Success Fail:(Fail)fail
{
    NSString *systemJson=[DataProcess getJsonStrWithObj:@{@"para1":UniqUserID,@"para2":para2}];
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSDictionary *dic=@{@"sysmodel":systemJson,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Register/GroupDel" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        //        NSLog(@"获取自己所有的相关群组:%@",dic1);
        
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}

//修改好友分组
+(void)RegisterGroupEditWithDatalist:(NSString*)datalist Success:(Success)Success Fail:(Fail)fail;
{
    NSString *systemJson=[DataProcess getJsonStrWithObj:@{}];
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":systemJson,@"DataList":datalist,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Register/GroupEdit" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
    
}
//查询用户分组好友信息
+(void)RegisterGroupAndUserListWithSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail
{
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    NSDate *date = [NSDate date];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *systemJson=[DataProcess getJsonStrWithObj:@{@"para1":[format stringFromDate:date],@"blresult":@"true"}];
    NSString *datalistJson=[DataProcess getJsonStrWithObj:@[@{@"myid":UniqUserID}]];
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSDictionary *dic=@{@"sysmodel":systemJson,@"DataList":datalistJson,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Register/GroupAndUserList" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}

//获取自己所有的分组
+(void)SystemCommonGroupWithMyid:(NSString*)ID Success:(Success)Success Fail:(Fail)fail
{
    NSString *systemJson=[DataProcess getJsonStrWithObj:@{@"para1":@"ring_group"}];
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    NSArray *datalistArray=@[@{Field:@"myid",Left:@false,Logical:@"0",Operation:@"0",Right:@false,KValue:ID}];
    NSString *datalistStr=[DataProcess getJsonStrWithObj:datalistArray];
    NSDictionary *dic=@{@"sysmodel":systemJson,@"DataList":datalistStr,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"System/Common" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
}
//给好友更换分组
+(void)RegisterEditFriendGroupWithDatalist:(NSString*)datalist Success:(Success)Success Fail:(Fail)fail
{
    NSString *systemJson=[DataProcess getJsonStrWithObj:@{}];
    NSString *time=mytimestamp;
    NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    
    NSDictionary *dic=@{@"sysmodel":systemJson,@"DataList":datalist,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    [[NetDataTool shareInstance]getNetData:PAPATH url:@"Register/EditFriendGroup" With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Success(dic1);
    } Faile:^(NSError *error) {
        
        fail(error);
    }];
    
}
@end
