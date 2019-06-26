//
//  NSString+Addition.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/5.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (Addition)
-(NSString *)URLEncodedString
{
    
    
    NSString* encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)self,NULL,NULL,kCFStringEncodingUTF8));
    return encodedString;
}

-(NSMutableAttributedString*)Color:(UIColor*)color ColorRange:(NSRange)range Font:(UIFont*)font FontRange:(NSRange)fontRange{
    NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:self];
    [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    [str addAttribute:NSFontAttributeName value:font range:fontRange];
    
    return str;
    
}
- (NSDictionary *)toDictionary
{
    if (self == nil) {
        return nil;
    }
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
@end
