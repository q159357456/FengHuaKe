//
//  HttpTool.h
//  MeetPet
//
//  Created by 张春 on 16/10/19.
//  Copyright © 2016年 张春. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessBlock)(id obj);
typedef void (^ErrorBlock)(id error);
typedef void (^UploadProgressBlock)(float uploadPercent);
//typedef void (^UploadProgressBlock)(float uploadPercent,long long bytesWritten,long long bytesAll);

typedef enum {
    HTTPRequestTypeGet = 0,    //get请求
    HTTPRequestTypePost,         //post请求
    HTTPRequestTypePut           //put请求
}HTTPRequestType;

@interface HttpTool : NSObject

/*通用接口
 url                          网络请求地址
 params                   参数
 type                        请求类型(Get/Post/Put)
 sBlock                   成功的回调
 eBlock                   失败的回调
 */
+(void)requestURL:(NSString *)url parameters:(NSMutableDictionary *)params withType:(HTTPRequestType)type succeedBlock:(SuccessBlock)sBlock failedBlock:(ErrorBlock)eBlock;



/*上传带图片的内容，允许多张图片上传  (POST)
url                                    网络请求地址
imagesArray                    要上传的图片数组（注意数组内容是UIImage）
params                             参数字典
parameterOfimages         图片对应的参数
scale                                 图片的压缩比例（0.0~1.0之间）
sBlock                             成功的回调
eBlock                             失败的回调
uploadProgressBlock     上传进度的回调
 */
+(void)multiPartUploadTaskWithURL:(NSString *)url
                                         imagesArray:(NSArray *)imagesArr
                                            paramDic:(NSDictionary *)paramDic
                                            parameterOfimages:(NSString *)parameter
                                  compressionScale:(float)scale
                                         succeedBlock:(SuccessBlock)sBlock
                                             failedBlock:(ErrorBlock)eBlock
                              uploadProgressBlock:(UploadProgressBlock)uploadProgressBlock;

//上传语音
+(void)multiAudioPartUploadTaskWithURL:(NSString *)url
                              paramDic:(NSDictionary *)paramDic
                             audioData:(NSData *)data
                      parameterOfAudio:(NSString *)parameter
                      compressionScale:(float)scale
                          succeedBlock:(SuccessBlock)sBlock
                           failedBlock:(ErrorBlock)eBlock
                   uploadProgressBlock:(UploadProgressBlock)uploadProgressBlock;


//上传视频
+ (void)multiPartUploadTaskWithURL:(NSString *)url videoData:(NSData *)videoData parameters:(NSString *)parameter succeedBlock:(SuccessBlock)sBlock failedBlock:(ErrorBlock)eBlock uploadProgressBlock:(UploadProgressBlock)uploadProgressBlock;

//json转数组
+(NSArray *)getArrayWithData:(NSString *)dataStr;

+(NSDictionary *)getDictWithData:(NSString *)dataStr;

//去除null
+(NSMutableDictionary *)takeOffNullWithDict:(NSDictionary *)dict;

//是否为刘海头
+(BOOL)isNavX;

@end
