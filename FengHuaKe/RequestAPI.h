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
//POST /api/MemberLevel/Apply
#define MemberLevel_Apply @"MemberLevel/Apply"
//POST /api/Pay/MemberLevel
#define Pay_MemberLevel @"Pay/MemberLevel"
//POST /api/FolderLink/List
#define FolderLink_List @"FolderLink/List"
//POST /api/GroupBuy/Me
#define GroupBuy_Me @"GroupBuy/Me"
//POST /api/Blogs/Hot
#define Blogs_Hot @"Blogs/Hot"
//POST /api/Case/CustomerService
#define Case_CustomerService @"Case/CustomerService"
//POST /api/Case/Class
#define Case_Class @"Case/Class"
//POST /api/Case/List
#define Case_List @"Case/List"
//POST /api/Case/Single
#define Case_Single @"Case/Single"
//POST /api/Blogs/Single
#define Blogs_Single @"Blogs/Single"
//POST /api/Blogs/CommentList
#define Blogs_CommentList @"Blogs/CommentList"
//api/Dynamic/CommentAdd
#define Dynamic_CommentAdd @"Dynamic/CommentAdd"
//POST /api/Cate/Store
#define Cate_Store @"Cate/Store"
//POST /api/Classify/List
#define Classify_List @"Classify/List"
//POST /api/Cate/SinglePro
#define Cate_SinglePro @"Cate/SinglePro"
//POST /api/Cate/ProList
#define Cate_ProList @"Cate/ProList"
//POST /api/PO/Create
#define PO_Create @"PO/Create"
//POST /api/GroupBuy/List
#define GroupBuy_List @"GroupBuy/List"
//POST /api/Pro/HotList
#define Pro_HotList @"Pro/HotList"
#endif /* RequestAPI_h */
