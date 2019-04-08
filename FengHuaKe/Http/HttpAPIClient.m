//
//  HttpAPIClient.m
//  MeetPet
//  AFHTTPSessionManager单例
//  Created by 张春 on 16/10/19.
//  Copyright © 2016年 张春. All rights reserved.
//

#import "HttpAPIClient.h"

static HttpAPIClient *_sharedClient = nil;

@implementation HttpAPIClient

+ (instancetype)sharedClient{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[HttpAPIClient alloc]initWithBaseURL:[NSURL URLWithString:SERVER_HOST]];
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/json", @"text/xml",nil];
        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
    });
    return _sharedClient;
}

@end
