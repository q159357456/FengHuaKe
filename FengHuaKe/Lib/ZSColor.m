//
//  ZSColor.m
//  PlayVR
//
//  Created by 赵升 on 2016/10/8.
//  Copyright © 2016年 ZS. All rights reserved.
//

#import "ZSColor.h"

@implementation ZSColor


+(NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate type:(NSInteger)type;
{
    NSInteger aa;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    if (type == 0) {
        [dateformater setDateFormat:@"yyyy-MM-dd"];
    }else if (type == 1){
        [dateformater setDateFormat:@"yyyy-MM-dd HH:mm"];
    }else if (type == 3){
        [dateformater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }

    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    
    dta = [dateformater dateFromString:aDate];
    dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    if (result == NSOrderedSame)
    {
        // 相等
    }else if (result == NSOrderedAscending)
    {
        //bDate比aDate大
        aa = 1;
    }else if (result == NSOrderedDescending)
    {
        //bDate比aDate小
        aa = -1;
        
    }
    
    return aa;
}

+(UIColor *)hexStringToColor:(NSString *)stringToConvert;
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


+ (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
