//
//  HttpTool.m
//  MeetPet
//  网络请求工具类
//  Created by 张春 on 16/10/19.
//  Copyright © 2016年 张春. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
#import "HttpAPIClient.h"
#import "SVProgressHUD.h"
#import <AVFoundation/AVFoundation.h>
#import <sys/utsname.h>

@implementation HttpTool

#pragma mark - 通用接口
+ (void)requestURL:(NSString *)url parameters:(NSMutableDictionary *)params withType:(HTTPRequestType)type succeedBlock:(SuccessBlock)sBlock failedBlock:(ErrorBlock)eBlock{
    //检查网络
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showInfoWithStatus:@"网络未连接!"];
        });
        return;
    }
    
    //Get请求
    if (type == HTTPRequestTypeGet) {
        [[HttpAPIClient sharedClient] GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (sBlock) {
                NSString *jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                sBlock(jsonDic);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (eBlock){
                eBlock(error);
            }
        }];
        return;
    }
    
    //Post请求
    if (type == HTTPRequestTypePost) {
        [[HttpAPIClient sharedClient] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (sBlock) {
                NSString *jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    sBlock(jsonDic);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (eBlock){
                eBlock(error);
            }
        }];
        return;
    }
    
    //Put请求
    if (type == HTTPRequestTypePut) {
        [[HttpAPIClient sharedClient] PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (sBlock) {
                NSString *jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                sBlock(jsonDic);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (eBlock){
                eBlock(error);
            }
        }];
        return;
    }
}




#pragma mark - 上传图片
+ (void)multiPartUploadTaskWithURL:(NSString *)url imagesArray:(NSArray *)imagesArr paramDic:(NSDictionary *)paramDic parameterOfimages:(NSString *)parameter compressionScale:(float)scale succeedBlock:(SuccessBlock)sBlock failedBlock:(ErrorBlock)eBlock uploadProgressBlock:(UploadProgressBlock)uploadProgressBlock{
    if (imagesArr.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"请上传图片"];
        return;
    }
    for (id obj in imagesArr) {
        if (![obj isKindOfClass:[UIImage class]]) {
            NSLog(@"数组中含有非法元素");
            return;
        }
    }
    
    //根据当前系统时间生成图片名称
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd-hh-mm"];
    NSString *dateString = [formatter stringFromDate:date];
    
    [[HttpAPIClient sharedClient] POST:url parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSInteger i = 0; i < imagesArr.count; i++) {
            UIImage *image = imagesArr[i];
            NSString *fileName = [NSString stringWithFormat:@"%@_%ld.png",dateString,(long)i];
            
            NSData *imageData;
            if (scale >0 && scale < 1.0) {
                //压缩图片
                imageData = UIImageJPEGRepresentation(image, scale);
            }else{
                imageData = UIImageJPEGRepresentation(image, 1.0);
            }
            [formData appendPartWithFileData:imageData name:parameter fileName:fileName mimeType:@"image/jpg/png/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //完成进度百分比
        CGFloat percent =  uploadProgress.completedUnitCount*1.0/uploadProgress.totalUnitCount;
        uploadProgressBlock(percent);
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (sBlock) {
            NSString *jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            sBlock(jsonDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (eBlock){
            eBlock(error);
        }
    }];
}


+(void)multiAudioPartUploadTaskWithURL:(NSString *)url
                              paramDic:(NSDictionary *)paramDic
                             audioData:(NSData *)data
                     parameterOfAudio:(NSString *)parameter
                      compressionScale:(float)scale
                          succeedBlock:(SuccessBlock)sBlock
                           failedBlock:(ErrorBlock)eBlock
                   uploadProgressBlock:(UploadProgressBlock)uploadProgressBlock{


    [[HttpAPIClient sharedClient] POST:url parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:parameter fileName:@"good.mp3" mimeType:@"mp3"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //完成进度百分比
        CGFloat percent =  uploadProgress.completedUnitCount*1.0/uploadProgress.totalUnitCount;
        uploadProgressBlock(percent);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        if (sBlock) {
            NSString *jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            sBlock(jsonDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---%@",error);
        if (eBlock){
            eBlock(error);
        }
    }];
}


#pragma mark - 上传视频
+ (void)multiPartUploadTaskWithURL:(NSString *)url videoData:(NSData *)videoData parameters:(NSString *)parameter succeedBlock:(SuccessBlock)sBlock failedBlock:(ErrorBlock)eBlock uploadProgressBlock:(UploadProgressBlock)uploadProgressBlock{
    if (videoData ==nil || videoData.length == 0) {
        NSLog(@"上传内容没有包含视频文件");
        return;
    }
    NSString *fileName = [NSDate date].description;
    fileName = [NSString stringWithFormat:@"%@.mp4",fileName];
    [[HttpAPIClient sharedClient] POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:videoData name:parameter fileName:fileName mimeType:@"video/mp4"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //完成进度百分比
        CGFloat percent =  uploadProgress.completedUnitCount*1.0/uploadProgress.totalUnitCount;
        uploadProgressBlock(percent);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (sBlock) {
            NSString *jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            sBlock(jsonDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (eBlock){
            eBlock(error);
        }
    }];
}

+(NSArray *)getArrayWithData:(NSString *)dataStr{
    NSData *data=[dataStr dataUsingEncoding:NSUTF8StringEncoding];
    NSObject *obj=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *array=(NSArray*)obj;
    return array;
}

+(NSDictionary *)getDictWithData:(NSString *)dataStr{
    NSData *data=[dataStr dataUsingEncoding:NSUTF8StringEncoding];
    NSObject *obj=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *array=(NSDictionary*)obj;
    return array;
}

+(NSMutableDictionary *)takeOffNullWithDict:(NSDictionary *)dict{
    NSArray * keys=[dict allKeys];
    NSMutableDictionary *dictD = [NSMutableDictionary dictionary];
    for (NSInteger i=0; i<keys.count; i++) {
        NSString *str = [dict objectForKey:keys[i]];
        if ((NSNull *)str == [NSNull null]) {
            [dictD setValue:@"0" forKey:keys[i]];
        }else{
            [dictD setValue:[dict objectForKey:keys[i]] forKey:keys[i]];
        }
    }
    NSLog(@"%@",dictD);
    return dictD;
}

+(BOOL)isNavX{
    /*switch ([DeviceUtil hardware]) {
        case IPHONE_X_CN:
            return YES;
            break;
        case IPHONE_X:
            return YES;
            break;
        default:
            return NO;
            break;
    }*/
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    //------------------------------iPhone---------------------------

    if ([platform isEqualToString:@"iPhone10,3"] ||
        [platform isEqualToString:@"iPhone10,6"])
        return YES;
    if ([platform isEqualToString:@"iPhone11,8"])
        return YES;
    if ([platform isEqualToString:@"iPhone11,2"])
        return YES;
    if ([platform isEqualToString:@"iPhone11,4"] ||
        [platform isEqualToString:@"iPhone11,6"])
        return YES;
    
    return NO;
    
}



@end
