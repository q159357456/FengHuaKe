//
//  HttpHandler.m
//  StreetShopping
//
//  Created by 赵升 on 2016/12/1.
//  Copyright © 2016年 ZS. All rights reserved.
//

#import "HttpHandler.h"
#import <CommonCrypto/CommonDigest.h>

@implementation HttpHandler

#define mysign [DataProcess getMD5Text]
#define mytimestamp [DataProcess getCurrrntDate]

#pragma mark *********************************登录注册*****************************
//字符串MD5加密
+(NSString *)md5:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return [result lowercaseString];
}
#pragma mark *********************************登录注册**************************

#pragma mark - 获取验证码
/*+ (void)getVerifyCodePartParams:(NSDictionary *)dict Success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:dict];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];//格式化
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString * str = [df stringFromDate:[NSDate date]];
    [dic setValue:str forKey:@"timestamp"];
    
    NSString * ciphertext = [NSString stringWithFormat:@"%@cec850b593ea422b87e4781afd8ddb2%@",dict[@"account"],str];

    [dic setValue:[HttpHandler md5:ciphertext] forKey:@"ciphertext"];
    
    [self appendUrl:@"userApi/sendMsgCode.app" success:success failed:failed postDict:dic];
}*/


#pragma mark - (有图片)
+(void)getImgsaveFeedback:(NSDictionary *)dic imageArray:(NSArray *)imageArray imageKeyArray:(NSArray *)imageKeyArray success:(SuccessBlock)success failed:(FailedBlock)failed{
    [ZSHttpTool uploadImageWithPath:@"feedbackApi/saveFeedback.app" params:dic thumbNames:imageKeyArray images:imageArray success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (error) {
            failed(error);
        }
    } progress:^(CGFloat progress) {
        
    }];
}

#pragma mark - 上传图片
+(void)getuploadImage:(NSDictionary *)dic imageArray:(NSArray *)imageArray imageKeyArray:(NSArray *)imageKeyArray success:(SuccessBlock)success failed:(FailedBlock)failed{
    
    [ZSHttpTool uploadImageWithPath:@"/api/v1/uploadImage" params:dic thumbNames:imageKeyArray images:imageArray success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (error) {
            failed(error);
        }
    } progress:^(CGFloat progress) {
        
    }];
}






#pragma mark - 获取代金券
+(void)getCoupon:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    
    [self appendPostUrlString:@"/Member/Coupon" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];

}

#pragma mark - 获取代金券，现金，佣金，积分
+(void)getMemberAsset:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Member/Asset" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 获取现金，消费记录
+(void)getBillCash:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Bill/Cash" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 获取积分，积分记录
+(void)getBillIntegral:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Bill/Integral" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 获取佣金，佣金记录
+(void)getBillBrokerage:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Bill/Brokerage" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 获取上下级关系
+(void)getMemberRelation:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Member/Relation" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 收藏商品
+(void)getFavoriteProductAdd:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Favorite/Product/Add" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 取消收藏商品
+(void)getFavoriteProductDelete:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Favorite/Product/Delete" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 获得收藏商品
+(void)getFavoriteProductList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Favorite/Product/Get" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 获得浏览商品记录
+(void)getBrowseProductList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Browse/Product/List" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 删除浏览商品记录
+(void)getBrowseProductDelete:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Browse/Product/Delete" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 发票新增
+(void)getInvoiceAdd:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Invoice/Add" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 发票列表
+(void)getInvoiceList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Invoice/List" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 设置默认发票
+(void)getInvoiceSetDefault:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Invoice/SetDefault" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 发票编辑
+(void)getInvoiceEdit:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Invoice/Edit" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 发票删除
+(void)getInvoiceDelete:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Invoice/Delete" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 订单列表
+(void)getBillList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Bill/List" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 支付方式
+(void)getPayWay:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/PayNotify" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 支付调用
+(void)getPayRequest:(NSDictionary *)dict DataList:(NSArray *)datalist start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlStringAndDataList:@"/Pay/Request" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict DataList:datalist];
}

#pragma mark - 获得一级大类
+(void)getFirstClassifyList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/FirstClassify/List" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 旅游攻略
+(void)getNewGuides:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/New/Guides" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 游记
+(void)getNewNotes:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/New/Notes" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 新闻
+(void)getNewNews:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/New/News" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 广告
+(void)getSystemGetADInfo:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/System/GetADInfo" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 产品列表
+(void)getProductList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Product/List" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 获得二级大类
+(void)getClassifyList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Classify/List" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 产品详情
+(void)getProductSingle:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Product/Single" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 加入购物车
+(void)getCartModify:(NSDictionary *)dict DataList:(NSArray *)datalist start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlStringAndDataList:@"/Cart/Modify" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict DataList:datalist];
}

#pragma mark - 删除购物车记录
+(void)getCartDelete:(NSDictionary *)dict DataList:(NSArray *)datalist start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlStringAndDataList:@"/Cart/Delete" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict DataList:datalist];
}

#pragma mark - 获得默认地址
+(void)getAddressGet:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Address/Get" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 下单
+(void)getBillCreate:(NSDictionary *)dict DataList:(NSArray *)datalist start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlStringAndDataList:@"/PO/Create" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict DataList:datalist];
}

#pragma mark - 保险产品列表
+(void)getInsureList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Insure/List" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 旅游方案价格
+(void)getInsurePrice:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Insure/Price" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 门票详情
+(void)getTicketSingle:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Ticket/Single" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 旅游产品列表(景点)
+(void)getTravelList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Travel/List" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 门票列表
+(void)getTicketList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Ticket/List" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 获取城市
+(void)getAddressCity:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Address/City" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 酒店列表
+(void)getHotelList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Hotel/List" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 酒店房间列表
+(void)getHotelRoomList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Hotel/RoomList" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 酒店房间信息
+(void)getHotelRoom:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Hotel/Room" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 旅游产品信息
+(void)getTravelSingle:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Travel/Single" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 发送验证码
+(void)getSendMobileCode:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/System/SendMobileCode" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 验证验证码
+(void)getIsValidCode:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/System/IsValidCode" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 订单管理接口(新)
+(void)getPOList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/PO/List" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 上传头像(有图片)
+(void)getRegisterLogo:(NSDictionary *)dict dataList:(NSArray *)dataList image:(NSArray *)imageArr start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self uploadFieldPostUrlString:@"/Register/Logo" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict image:imageArr dataList:dataList];
}

#pragma mark - 申请售后(有图片)
+(void)getPOServiceApply:(NSDictionary *)dict dataList:(NSArray *)dataList image:(NSArray *)imageArr start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self uploadFieldPostUrlString:@"/POService/Apply" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict image:imageArr dataList:dataList];
}

#pragma mark - 售后列表
+(void)getPOServiceList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/POService/List" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 可申请售后列表
+(void)getPOServiceLicence:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/POService/Licence" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 售后详情
+(void)getPOServiceSingle:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/POService/Single" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 朋友圈
+(void)getDynamicGetFriendCircle:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Dynamic/GetFriendCircle" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 发表朋友圈(有图片)
+(void)getDynamicPublishDynamicImages:(NSDictionary *)dict dataList:(NSArray *)dataList image:(NSArray *)imageArr start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self uploadFieldPostUrlString:@"/Dynamic/PublishDynamicImages" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict image:imageArr dataList:dataList];
}

#pragma mark - 发表朋友圈(无图片)
+(void)getDynamicPublishDynamic:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Dynamic/PublishDynamic" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 获取相册列表
+(void)getDynamicPhotos:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Dynamic/Photos" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 获取相册图片列表
+(void)getDynamicPicture:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Dynamic/Picture" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 相册添加图片
+(void)getDynamicPictureAdd:(NSDictionary *)dict dataList:(NSArray *)dataList image:(NSArray *)imageArr start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self uploadFieldPostUrlString:@"/Dynamic/PictureAdd" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict image:imageArr dataList:dataList];
}

#pragma mark - 获得分类下的品牌
+(void)getBrandList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Brand/List" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 获得好友信息
+(void)getFriendDetail:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Register/FriendDetail" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 获得单个朋友圈
+(void)getSingleDynamic:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Dynamic/SingleDynamic" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 获得案例分类
+(void)getCaseClass:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Case/Class" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 获得热门案例
+(void)getCaseHot:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Case/Hot" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 获得案例列表(分页)
+(void)getCaseList:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Case/List" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 获取案例单笔记录
+(void)getCaseSingle:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Case/Single" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 获取客服列表
+(void)getCaseCustomerService:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Case/CustomerService" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 获得评价标签
+(void)getCaseTag:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Case/Tag" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 评价客服
+(void)getCaseAppraise:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Case/Appraise" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 联系客服
+(void)getCaseContact:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    [self appendPostUrlString:@"/Case/Contact" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
}

#pragma mark - 获取个人二维码
+(void)getQrCodeTool:(NSDictionary *)dict start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type Success:(SuccessBlock)success failed:(FailedBlock)failed{
    //[self appendPostUrlString:@"/System/QrCodeTool" success:success start:indexstart end:indexend querytype:type failed:failed postDict:dict];
    [self appendGetUrl:@"/System/QrCodeTool" success:success failed:failed postDict:dict];
}








+ (void)uploadFieldPostUrlString:(NSString *)appendUrl success:(SuccessBlock)success start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type failed:(FailedBlock)failed postDict:(NSDictionary *)postDict image:(NSArray *)imageArr dataList:(NSArray *)dataList{
    NSString *jsonpara=[DataProcess getJsonStrWithObj:postDict];
    NSString *jsonDatalist=[DataProcess getJsonStrWithObj:dataList];
    NSString *time=mytimestamp;
    NSString *signStr;
    if ([indexend integerValue]<1 || [indexstart integerValue]<1) {
        signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    }else{
        signStr=[DataProcess getSignWithEndindex:[indexend stringValue] querytype:type Startindex:[indexstart stringValue] Timestamp:time];
    }
    
    NSDictionary *dic=@{@"sysmodel":jsonpara,@"endindex": indexend,@"startindex":indexstart,@"querytype":type,@"timestamp":time,@"sign":signStr,@"DataList":jsonDatalist};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSDictionary *dic1=@{@"json":requestStr,@"dev":@"ios"};
    NSLog(@"requestStr:%@",requestStr);
    MJWeakSelf;
    [ZSHttpTool upLoadFileurl:appendUrl Parameters:dic1 Data:imageArr and:^(id json) {
        if (success) {
            success(json);
        }
    } Faile:^(NSError *error) {
        if (error) {
            failed(error);
            [weakSelf showHint:@"网络请求失败"];
        }
    }];
    /* NSString *time=mytimestamp;
     NSString *signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
     NSDictionary *dic=@{@"sysmodel":sysmodel,@"endindex":@"-1",@"startindex":@"-1",@"querytype":@"0",@"timestamp":time,@"sign":signStr,@"DataList":@[]};
     NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
     NSString *requestStr=[DataProcess getParseWithStr:dicjson];
     NSLog(@"-%@",requestStr);
     NSDictionary *dic1=@{@"json":requestStr,@"dev":@"ios"};*/
}


+ (void)appendPostUrlString:(NSString *)appendUrl success:(SuccessBlock)success start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type failed:(FailedBlock)failed postDict:(NSDictionary *)postDict{
    NSString *jsonpara=[DataProcess getJsonStrWithObj:postDict];
    NSString *time=mytimestamp;
    NSString *signStr;
    if ([indexend integerValue]<1 || [indexstart integerValue]<1) {
        signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    }else{
        signStr=[DataProcess getSignWithEndindex:[indexend stringValue] querytype:type Startindex:[indexstart stringValue] Timestamp:time];
    }
    
    NSDictionary *dic=@{@"sysmodel":jsonpara,@"endindex": indexend,@"startindex":indexstart,@"querytype":type,@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    NSLog(@"token:%@",Mytoken);
    MJWeakSelf
    [ZSHttpTool postWithPathString:appendUrl params:requestStr success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (error) {
            failed(error);
            [weakSelf showHint:@"网络请求失败"];
        }
    }];
}

+ (void)appendPostUrlStringAndDataList:(NSString *)appendUrl success:(SuccessBlock)success start:(NSNumber *)indexstart end:(NSNumber *)indexend querytype:(NSString *)type failed:(FailedBlock)failed postDict:(NSDictionary *)postDict DataList:(NSArray *)DataList{
    NSString *jsonpara=[DataProcess getJsonStrWithObj:postDict];
    NSString *jsonDatalist=[DataProcess getJsonStrWithObj:DataList];
    NSString *time=mytimestamp;
    NSString *signStr;
    if ([indexend integerValue]<1 || [indexstart integerValue]<1) {
        signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    }else{
        signStr=[DataProcess getSignWithEndindex:[indexend stringValue] querytype:type Startindex:[indexstart stringValue] Timestamp:time];
    }
    NSDictionary *dic=@{@"sysmodel":jsonpara,@"DataList":jsonDatalist,@"endindex": indexend,@"startindex":indexstart,@"querytype":type,@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    NSLog(@"requestStr:%@",requestStr);
    NSLog(@"token:%@",Mytoken);
    MJWeakSelf;
    [ZSHttpTool postWithPathString:appendUrl params:requestStr success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (error) {
            failed(error);
            [weakSelf showHint:@"网络请求失败"];
        }
    }];
}

+ (void)appendGetUrl:(NSString *)appendUrl success:(SuccessBlock)success failed:(FailedBlock)failed postDict:(NSDictionary *)postDict{
    //NSString *jsonpara=[DataProcess getJsonStrWithObj:postDict];
    MJWeakSelf
    [ZSHttpTool getWithPath:appendUrl params:postDict success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (error) {
            failed(error);
            [weakSelf showHint:@"网络请求失败"];
        }
    }];
}


+(void)showHint:(NSString *)hint
{
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.yOffset = 180;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}



@end
