//
//  JsonTools.m
//  Reservation ordering
//
//  Created by 张帆 on 16/8/9.
//  Copyright © 2016年 工博计算机. All rights reserved.
//

#import "JsonTools.h"

@implementation JsonTools


+(NSDictionary *)getData:(NSData *)data
{
    NSString *string=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];

    NSArray *array=[string componentsSeparatedByString:@">"];

    NSString *str=array[2];

    NSArray *arr=[str componentsSeparatedByString:@"<"];
    NSString *st=arr.firstObject;

    NSData *mydata=[st dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:mydata options:NSJSONReadingMutableContainers error:nil];
    
    return dic;
}
+(NSString *)getNSString:(NSData *)data
{
    NSString *string=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSArray *array=[string componentsSeparatedByString:@">"];
    
    NSString *str=array[2];
    
    NSArray *arr=[str componentsSeparatedByString:@"<"];
    NSString *st=arr.firstObject;
    return st;
}



@end
