//
//  RequestAPI.h
//  FengHuaKe
//
//  Created by chenheng on 2019/4/11.
//  Copyright © 2019年 gongbo. All rights reserved.
//

#ifndef RequestAPI_h
#define RequestAPI_h

//省
#define Address_Province @"Address/Province"
//市
#define Address_City @"Address/City"
//区
#define Address_District @"Address/District"
//选择客服
#define Case_CustomerService @"Case/CustomerService"
//获取案例分类
#define Case_Class  @"Case/Class"
//获取企业列表
#define Enterprise_List @"Enterprise/List"
//POST查询是否是导游【已经是导游（DataList为导游资料）、sysmodel.intresult:-1；还不是导游，0：导游资料审核中，1：是导游，2：导游申请驳回】/api/Guide/Verify
#define Guide_Verify @"Guide/Verify"
//上传导游信息POST /api/Guide/ApplyGuide
#define Guide_ApplyGuide @"Guide/ApplyGuide"
//博客信息POST /api/Blogs/List
#define Blogs_List @"Blogs/List"
//POST /api/MemberLevel/Current会员等级
#define MemberLevel_Current @"MemberLevel/Current"
#endif /* RequestAPI_h */
