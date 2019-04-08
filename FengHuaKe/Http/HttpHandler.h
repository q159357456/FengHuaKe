//
//  HttpHandler.h
//  StreetShopping
//
//  Created by 赵升 on 2016/12/1.
//  Copyright © 2016年 ZS. All rights reserved.
//

#import "ZSBaseHandle.h"
#import "ZSHttpTool.h"
@interface HttpHandler : ZSBaseHandle

#pragma mark *********************************登录注册**************************





#pragma mark - 获取代金券
+(void)getCoupon:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 获取代金券，现金，佣金，积分
+(void)getMemberAsset:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 获取现金，消费记录
+(void)getBillCash:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 获取积分，积分记录
+(void)getBillIntegral:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 获取佣金，佣金记录
+(void)getBillBrokerage:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 获取上下级关系
+(void)getMemberRelation:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 收藏商品
+(void)getFavoriteProductAdd:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 取消收藏商品
+(void)getFavoriteProductDelete:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 获得收藏商品
+(void)getFavoriteProductList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 获得浏览商品记录
+(void)getBrowseProductList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 删除浏览商品记录
+(void)getBrowseProductDelete:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 发票新增
+(void)getInvoiceAdd:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 发票列表
+(void)getInvoiceList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 设置默认发票
+(void)getInvoiceSetDefault:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 发票编辑
+(void)getInvoiceEdit:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 发票删除
+(void)getInvoiceDelete:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 订单列表
+(void)getBillList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 支付方式
+(void)getPayWay:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 支付调用
+(void)getPayRequest:(NSDictionary *)dict DataList:(NSArray *)datalist start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 获得一级大类
+(void)getFirstClassifyList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 旅游攻略
+(void)getNewGuides:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 游记
+(void)getNewNotes:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 新闻
+(void)getNewNews:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 广告
+(void)getSystemGetADInfo:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 产品列表
+(void)getProductList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 获得二级大类
+(void)getClassifyList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 产品详情
+(void)getProductSingle:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 加入购物车
+(void)getCartModify:(NSDictionary *)dict DataList:(NSArray *)datalist start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 删除购物车记录
+(void)getCartDelete:(NSDictionary *)dict DataList:(NSArray *)datalist start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 获得默认地址
+(void)getAddressGet:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 下单
+(void)getBillCreate:(NSDictionary *)dict DataList:(NSArray *)datalist start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 保险产品列表
+(void)getInsureList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 旅游方案价格
+(void)getInsurePrice:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 门票详情
+(void)getTicketSingle:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 旅游产品列表(景点)
+(void)getTravelList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 门票列表
+(void)getTicketList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 获取城市
+(void)getAddressCity:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 酒店列表
+(void)getHotelList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 酒店房间列表
+(void)getHotelRoomList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 酒店房间信息
+(void)getHotelRoom:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 旅游产品信息
+(void)getTravelSingle:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 发送验证码
+(void)getSendMobileCode:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 验证验证码
+(void)getIsValidCode:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 订单管理接口(新)
+(void)getPOList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 上传头像(有图片)
+(void)getRegisterLogo:(NSDictionary *)dict dataList:(NSArray *)dataList image:(NSArray *)imageArr start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 申请售后(有图片)
+(void)getPOServiceApply:(NSDictionary *)dict dataList:(NSArray *)dataList image:(NSArray *)imageArr start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 售后列表
+(void)getPOServiceList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 可申请售后列表
+(void)getPOServiceLicence:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 售后详情
+(void)getPOServiceSingle:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 朋友圈
+(void)getDynamicGetFriendCircle:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 发表朋友圈(有图片)
+(void)getDynamicPublishDynamicImages:(NSDictionary *)dict dataList:(NSArray *)dataList image:(NSArray *)imageArr start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 发表朋友圈(无图片)
+(void)getDynamicPublishDynamic:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 获取相册列表
+(void)getDynamicPhotos:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 获取相册图片列表
+(void)getDynamicPicture:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 相册添加图片
+(void)getDynamicPictureAdd:(NSDictionary *)dict dataList:(NSArray *)dataList image:(NSArray *)imageArr start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 获得分类下的品牌
+(void)getBrandList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 获得好友信息
+(void)getFriendDetail:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 获得单个朋友圈
+(void)getSingleDynamic:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 获得案例分类
+(void)getCaseClass:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 获得热门案例
+(void)getCaseHot:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 获得案例列表(分页)
+(void)getCaseList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 获取案例单笔记录
+(void)getCaseSingle:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 获取客服列表
+(void)getCaseCustomerService:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 获得评价标签
+(void)getCaseTag:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 评价客服
+(void)getCaseAppraise:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 联系客服
+(void)getCaseContact:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;

#pragma mark - 获取个人二维码
+(void)getQrCodeTool:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed;




+ (void)appendGetUrl:(NSString *)appendUrl success:(SuccessBlock)success failed:(FailedBlock)failed postDict:(NSDictionary *)postDict;



@end


