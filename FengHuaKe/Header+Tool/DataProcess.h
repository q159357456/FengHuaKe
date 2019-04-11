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
#define GETRequestStr(sysmodel,start,end,type) ([DataProcess getRequestStr:sysmodel Strat:start End:end Type:type])
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


@end
