//
//  NetDataTool.m
//  Restaurant
//
//  Created by 张帆 on 16/8/17.
//  Copyright © 2016年 工博计算机. All rights reserved.
//

#import "NetDataTool.h"
@interface NetDataTool()
@end
@implementation NetDataTool
//创建单例
+(NetDataTool*) shareInstance;
{
    static dispatch_once_t onceToken;
    static NetDataTool *net=nil;
    dispatch_once(&onceToken, ^{
        net=[[NetDataTool alloc]init];
    });
    
    return net;
}
//请求数据
-(void)getNetData:(NSString *)rootUrl url:(NSString *)url With:(NSString *)parameters and:(httpRequestSuccess)success Faile:(httpRequestFaile)faile
{
    NSString *path=[NSString stringWithFormat:@"%@/%@",rootUrl,url];
    NSLog(@"path:%@",path);
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
 
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    //与后台约定好可接收的Content-Type
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",nil];
    //增加头部
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if (Mytoken) {
       
     [manager.requestSerializer setValue:Mytoken forHTTPHeaderField:@"token"];
    }
//     [manager.requestSerializer setValue:Mytoken forHTTPHeaderField:@"token"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
        //在这里面对parameters进行处理
        return parameters;
    }];
    
  
    [manager POST :path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        success(responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *wrong=[NSString stringWithFormat:@"%@",error];
        if ([wrong containsString:@"The request timed out"])
        {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showErrorWithStatus:@"请求超时"];
        }else
        {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showErrorWithStatus:@"请求失败"];
        }
        faile(error);
    }];
}
//上传文件
-(void)upLoadFile:(NSString *)rootUrl url:(NSString *)url Parameters:(NSDictionary *)parameters Data:(NSArray*)array and:(httpRequestSuccess)success Faile:(httpRequestFaile)faile
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
    NSString *path=[NSString stringWithFormat:@"%@/%@",rootUrl,url];
    NSLog(@"path:%@",path);
    [sessionManager POST:path parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 上传文件
//        UIImage *image = [UIImage imageWithContentsOfFile:@"/Users/wangfei/Desktop/100.jpg"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        for (NSData *data in array) {
            if (data) {
                [formData appendPartWithFileData:data name:@"image" fileName:fileName mimeType:@"image/jpg"];
            }
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        success(error);
    }];
    
}
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                        
                                                         
                                                         
                                                         
                                                        
                                                         
                                                         
                                                         
                                                        
                                                         
                                                         
                                                         
                                                        
                                                         
                                                         
                                                         
                                                         


//撤销请求
-(void)cancelRequest
{
    
    
}
@end
