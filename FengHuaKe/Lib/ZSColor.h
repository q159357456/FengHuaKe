//
//  ZSColor.h
//  PlayVR
//
//  Created by 赵升 on 2016/10/8.
//  Copyright © 2016年 ZS. All rights reserved.
//

#import <UIKit/UIKit.h>
// 设置颜色
#define BXColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define BXAlphaColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
@interface ZSColor : UIColor

+(NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate type:(NSInteger)type;

+(UIColor *)hexStringToColor:(NSString *)stringToConvert;

/**
 *  用颜色返回一张图片
 */
+ (UIImage *)createImageWithColor:(UIColor*) color;

@end
