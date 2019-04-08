//
//  UIColor+Extension.h
//  FengHuaKe
//
//  Created by Syrena on 2018/9/12.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)


+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr;

+ (UIColor *)colorWithHex:(NSString *)hexColor;

@end
