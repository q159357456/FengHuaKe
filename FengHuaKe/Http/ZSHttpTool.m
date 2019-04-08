//
//  ZSHttpTool.m
//  PlayVR
//
//  Created by 赵升 on 2016/10/14.
//  Copyright © 2016年 ZS. All rights reserved.
//

#import "ZSHttpTool.h"
#import "AFNetworking.h"

static NSString * kBaseUrl = SERVER_HOST;


@interface AFHttpClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end

@implementation AFHttpClient

+ (instancetype)sharedClient {
    
    static AFHttpClient * client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        client = [[AFHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseUrl] sessionConfiguration:configuration];
        //接收参数类型
        client.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
        //设置超时时间
        client.requestSerializer.timeoutInterval = 60;
        //安全策略
        client.securityPolicy = [AFSecurityPolicy defaultPolicy];
        
    });
    
    return client;
}

@end

@implementation ZSHttpTool

+ (void)getWithPath:(NSString *)path
             params:(NSDictionary *)params
            success:(HttpSuccessBlock)success
            failure:(HttpFailureBlock)failure {
    //获取完整的url路径
    NSString * url = [NSString stringWithFormat:@"%@%@",kBaseUrl,path];
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    //与后台约定好可接收的Content-Type
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",nil];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"image/jpg", nil];
    //增加头部
    //[manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
//    [manager.requestSerializer setValue:Mytoken forHTTPHeaderField:@"token"];
//    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
//        //在这里面对parameters进行处理
//        return parameters;
//    }];
    
    
//    [manager POST :url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dic1=[DataProcess getJsonWith:responseObject];
//        success(dic1);
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSString *wrong=[NSString stringWithFormat:@"%@",error];
//        if ([wrong containsString:@"The request timed out"])
//        {
//            //                [SVProgressHUD setMinimumDismissTimeInterval:1];
//            //                [SVProgressHUD showErrorWithStatus:@"请求超时"];
//        }else
//        {
//            //[SVProgressHUD setMinimumDismissTimeInterval:1];
//            //[SVProgressHUD showErrorWithStatus:@"请求失败"];
//        }
//        failure(error);
//    }];
    
//        [manager.requestSerializer setValue:Mytoken forHTTPHeaderField:@"token"];
//        [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
//            //在这里面对parameters进行处理
//            return parameters;
//        }];
        [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //NSDictionary *dic1=[DataProcess getJsonWith:responseObject];
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSString *wrong=[NSString stringWithFormat:@"%@",error];
            if ([wrong containsString:@"The request timed out"])
            {
                //                [SVProgressHUD setMinimumDismissTimeInterval:1];
                //                [SVProgressHUD showErrorWithStatus:@"请求超时"];
            }else
            {
                //[SVProgressHUD setMinimumDismissTimeInterval:1];
                //[SVProgressHUD showErrorWithStatus:@"请求失败"];
            }
            failure(error);
        }];
    
    

    
}


+ (void)postWithPathString:(NSString *)path
              params:(NSString *)params
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure {
    //获取完整的url路径
    NSString * url = [kBaseUrl stringByAppendingPathComponent:path];
    
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    //与后台约定好可接收的Content-Type
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",nil];
    //增加头部
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if (Mytoken) {
        [manager.requestSerializer setValue:Mytoken forHTTPHeaderField:@"token"];
        [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
            //在这里面对parameters进行处理
            return parameters;
        }];
        
        
        [manager POST :url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic1=[DataProcess getJsonWith:responseObject];
            success(dic1);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSString *wrong=[NSString stringWithFormat:@"%@",error];
            if ([wrong containsString:@"The request timed out"])
            {
//                [SVProgressHUD setMinimumDismissTimeInterval:1];
//                [SVProgressHUD showErrorWithStatus:@"请求超时"];
            }else
            {
                //[SVProgressHUD setMinimumDismissTimeInterval:1];
                //[SVProgressHUD showErrorWithStatus:@"请求失败"];
            }
            failure(error);
        }];
    

    /*[[AFHttpClient sharedClient] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        NSDictionary *dic1=[DataProcess getJsonWith:responseObject];
        success(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error.code == -1001) {
            [SVProgressHUD showInfoWithStatus:@"请求超时"];
            
        }
        
        failure(error);
        
    }];*/
    
    }
}

+ (void)postWithPath:(NSString *)path
              params:(NSDictionary *)params
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure {
    //获取完整的url路径
    NSString * url = [kBaseUrl stringByAppendingPathComponent:path];
    

    
    [[AFHttpClient sharedClient] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error.code == -1001) {
            [SVProgressHUD showInfoWithStatus:@"请求超时"];
            
        }
        
        failure(error);
        
    }];
    
}

+ (void)downloadWithPath:(NSString *)path
                 success:(HttpSuccessBlock)success
                 failure:(HttpFailureBlock)failure
                progress:(HttpDownloadProgressBlock)progress {
    
    //获取完整的url路径
    NSString * urlString = [kBaseUrl stringByAppendingPathComponent:path];
    
    //下载
    NSURL *URL = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [[AFHttpClient sharedClient] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        progress(downloadProgress.fractionCompleted);
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        //获取沙盒cache路径
        NSURL * documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        if (error) {
            failure(error);
        } else {
            success(filePath.path);
        }
        
    }];
    
    [downloadTask resume];
    
}

+ (void)uploadImageWithPath:(NSString *)path
                     params:(NSDictionary *)params
                  thumbName:(NSString *)imagekey
                      image:(UIImage *)image
                    success:(HttpSuccessBlock)success
                    failure:(HttpFailureBlock)failure
                   progress:(HttpUploadProgressBlock)progress {
    
    //获取完整的url路径
    NSString * urlString = [kBaseUrl stringByAppendingPathComponent:path];
    
//    NSData * data = UIImagePNGRepresentation(image);
    NSData * data  = UIImageJPEGRepresentation(image, 0.1);
    
    [[AFHttpClient sharedClient] POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:imagekey fileName:@"01.png" mimeType:@"image/png/jpeg/jpg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
}



+ (void)uploadImageWithPath:(NSString *)path
                     params:(NSDictionary *)params
                 thumbNames:(NSArray *)imagekeys
                     images:(NSArray *)images
                    success:(HttpSuccessBlock)success
                    failure:(HttpFailureBlock)failure
                   progress:(HttpUploadProgressBlock)progress {
    
    //获取完整的url路径
    NSString * urlString = [kBaseUrl stringByAppendingPathComponent:path];
    
    [[AFHttpClient sharedClient] POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < images.count; i++) {
            UIImage * image = images[i];
            NSString * imagekey = imagekeys[i];
            NSData * data = UIImagePNGRepresentation(image);
            //NSData * data  = UIImageJPEGRepresentation(image, 0.1);

            [formData appendPartWithFileData:data name:imagekey fileName:[NSString stringWithFormat:@"%2d.png",i] mimeType:@"image/png/jpg/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
}

//上传文件
+(void)upLoadFileurl:(NSString *)url Parameters:(NSDictionary *)parameters Data:(NSArray*)array and:(HttpSuccessBlock)success Faile:(HttpFailureBlock)faile
{
    //网络请求管理器
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    //与后台约定好可接收的Content-Type
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",nil];
    //增加头部
    [sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if (Mytoken) {
        [sessionManager.requestSerializer setValue:Mytoken forHTTPHeaderField:@"token"];
    }
    sessionManager.responseSerializer =[AFHTTPResponseSerializer serializer];
    NSString *path=[NSString stringWithFormat:@"%@/%@",kBaseUrl,url];
    [sessionManager POST:path parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 上传文件
        //        UIImage *image = [UIImage imageWithContentsOfFile:@"/Users/wangfei/Desktop/100.jpg"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        if (array.count>0) {
            for (UIImage *image in array) {
                NSData * data = UIImageJPEGRepresentation(image,0.6f);
                [formData appendPartWithFileData:data name:@"image" fileName:fileName mimeType:@"image/jpg"];
            }
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1=[DataProcess getJsonWith:responseObject];
        success(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faile(error);
    }];
    
}




+ (void)postWithPathh:(NSString *)path
              params:(NSDictionary *)params
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure {
    //获取完整的url路径
    NSString * url = [kBaseUrl stringByAppendingPathComponent:path];
    
    [[AFHttpClient sharedClient] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
    
}




@end
