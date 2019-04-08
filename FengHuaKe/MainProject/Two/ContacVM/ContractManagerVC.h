//
//  ContractManagerVC.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/15.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^Success)(id responseData);
typedef void (^Fail)(id erro);
@interface ContractManagerVC : NSObject
//搜索好友
+(void)UserListWithPara:(NSString*)para Success:(Success)Success Fail:(Fail)fail;
//获取所自己所有的好友
+(void)SystemCommonWithID:(NSString*)ID Success:(Success)Success Fail:(Fail)fail;
//添加好友
+(void)RegisterFriendAddWithPara1:(NSString*)para1 Para2:(NSString*)para2 Para3:(NSString*)para3 Success:(Success)Success Fail:(Fail)fail;
//删除好友
+(void)RegisterFriendDelWithDatalist:(NSString*)datalist Success:(Success)Success Fail:(Fail)fail;

//搜索群组
+(void)SystemCommonGroupWithKeyWord:(NSString*)keyword Success:(Success)Success Fail:(Fail)fail;
//获取自己所有的群组(自己是群组)
+(void)SystemCommonGroupWithID:(NSString*)ID Success:(Success)Success Fail:(Fail)fail;
//获取自己所有的相关群组
+(void)RegisterUserDetailForCharGroupSuccess:(Success)Success Fail:(Fail)fail;
//创建群组
+(void)RegisterChatGroupAddWithDtalist:(NSString*)datalist Success:(Success)Success Fail:(Fail)fail;
//加入群组
+(void)RegisterChatGroupAddMember:(NSString*)dataList  Success:(Success)Success Fail:(Fail)fail;
//群组中删除成员
+(void)RegisterChatGroupDelMember:(NSString*)dataList  Success:(Success)Success Fail:(Fail)fail;
//通过id获取user信息
+(void)SystemCommonGroupWithuserid:(NSString*)userid Success:(Success)Success Fail:(Fail)fail;
//获取群组所有群成员资料
+(void)RegisterChatGroupUserListWithGroupid:(NSString*)groupid Success:(Success)Success Fail:(Fail)fail;
//删除群租
+(void)RegisterChatGroupDelWithOwner:(NSString*)ownerid Groupid:(NSString*)groupid Success:(Success)Success Fail:(Fail)fail;
//获取好友申请中好友的详细资料
+(void)RegisterUserInfoWithDatalist:(NSString*)datalist Success:(Success)Success Fail:(Fail)fail;
//我的好友分组添加
+(void)RegisterGroupAdd:(NSString*)para2 Success:(Success)Success Fail:(Fail)fail;
//删除分组
+(void)RegisterGroupDel:(NSString*)para2 Success:(Success)Success Fail:(Fail)fail;
//修改好友分组
+(void)RegisterGroupEditWithDatalist:(NSString*)datalist Success:(Success)Success Fail:(Fail)fail;
//查询用户分组及好友信息
+(void)RegisterGroupAndUserListWithSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail;
//获取自己所有的分组
+(void)SystemCommonGroupWithMyid:(NSString*)ID Success:(Success)Success Fail:(Fail)fail;
//给好友更换分组
+(void)RegisterEditFriendGroupWithDatalist:(NSString*)datalist Success:(Success)Success Fail:(Fail)fail;
@end
