//
//  DataProcess.h
//  ZHONGHUILAOWU
//
//  Created by 工博计算机 on 17/9/26.
//  Copyright © 2017年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#define Field @"field"
#define Left @"left"
#define Logical @"logical"
#define Operation @"operation"
#define Right @"right"
#define KValue @"value"
//支付指令
#define payCommand(type) ([DataProcess getPayCommandWithType:type])
//requestStr
#define GETRequestStr(datalist,sysmodel,start,end,type) ([DataProcess getRequestStrDataList:datalist Sysmodel:sysmodel Strat:start End:end Type:type])
//sd_image_cache
#define ImageCacheDefine(originalView,imageurl) ([DataProcess sd_imageCacheDefine:originalView ImageURL:imageurl])
//默认城市
#define defaultCityName @"东莞市"
#define defaultCityCode @"441900"
typedef void (^PhotopBlock)(UIImage *image);
typedef enum {
    hotel =0,
    insure,
    travel,
    tickets,
    store
    
}PayCommand;

//支付方式
typedef enum {
    //在线支付
    OnLineToPay =0,
    //到店支付
    ComToPay,
    //货到付款
    GetProToPay
}PayWay;
@interface DataProcess : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,copy)PhotopBlock photoBlock;
//单利
+(DataProcess*) shareInstance;
+(void)showWarnProgress:(NSString *)progress;
+(void)showSuccessProgress:(NSString *)progress;
+ (NSMutableAttributedString *)setupAttributeString:(NSString *)text highlightText:(NSString *)highlightText Color:(UIColor*)color;

/**
 获取支付类型
 */
+(NSString *)getPayCommandWithType:(NSInteger)type;
/*
 电话
 */
+(void)callWithPhone:(NSString*)phone;
/*
 短息
 */
+(void)writToPhone:(NSString*)phone;


/**
 使用钥匙串 －－添加
 */
+(void)addToKeychainWithValue:(NSString*)value;

/**
 使用钥匙串 －－更新
 */
+(void)updateDataWithNewValue:(NSString*)newValue;
/**
 使用钥匙串 －－查询
 */
+(NSString*)findData;

/**
 使用钥匙串 －－删除
 */
+(void)deletFromKeychain;

/**
 省－市－区
 */
//+(NSMutableArray*)getAllProvinceAndCityData;
//+(NSString*)getCityModelWithCityName:(NSString*)cityName;
//+(NSString*)getProvincModelWithProvinceName:(NSString*)provinceName;

/**
 md5加密
 */
+(NSString*)getMD5TextWithStr:(NSString*)text;

+(NSString*)getCurrrntDate;
/**
 获得json字符串
 */
+(NSString*)getJsonStrWithObj:(id)obj;
/**
 获得sign字符串
 */
+(NSString*)getSignWithEndindex:(NSString*)endindex querytype:(NSString*)querytype Startindex:(NSString*)startindex Timestamp:(NSString*)timestamp;
/**
 获得Request字符串
 */
+(NSString*)getRequestStrDataList:(NSArray*)datalist Sysmodel:(NSDictionary*)sysmode Strat:(NSNumber*)start End:(NSNumber*)end Type:(NSString*)type;
/**
 通用请求
 */
+(void)requestDataWithURL:(NSString*)url RequestStr:(NSString*)requestStr Result:(void(^)(id  obj,id erro))result;
/**
 参数处理方式
 */
+(NSString*)getParseWithStr:(NSString*)parse;
/**
 获取json值
 */
+(NSDictionary*)getJsonWith:(NSData*)responseObject;
+(NSString*)PicAdress:(NSString*)str;
/**
 相机/相册操作
 */
-(void)choosePhotoWithBlock:(PhotopBlock)phtoBlock;
/**
 导航栏图片
 */
+(UIImage*)barImage;
+(UIImage*)clearImage;
+(UIImage *)imageWithColor:(UIColor *)color;
/**
 sdimagecache封装
 */
+(void)sd_imageCacheDefine:(UIView*)view ImageURL:(NSString*)imageurl;
/**
 服务端返回时间转化
 */
+(NSString*)resultTime:(NSString*)time;
@end
