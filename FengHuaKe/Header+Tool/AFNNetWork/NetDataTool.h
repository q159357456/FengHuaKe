//
//  NetDataTool.h
//  Restaurant
//
//  Created by 张帆 on 16/8/17.
//  Copyright © 2016年 工博计算机. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetDataTool : NSObject


typedef void(^httpRequestSuccess)(id responseObject);
typedef void(^httpRequestFaile)(NSError * error);

+(NetDataTool*) shareInstance;
-(void)getNetData:(NSString *)rootUrl url:(NSString *)url With:(NSString *)parameters and:(httpRequestSuccess)success Faile:(httpRequestFaile)faile;

-(void)upLoadFile:(NSString *)rootUrl url:(NSString *)url Parameters:(NSDictionary *)parameters Data:(NSArray<NSData*>*)array and:(httpRequestSuccess)success Faile:(httpRequestFaile)faile;
@end
