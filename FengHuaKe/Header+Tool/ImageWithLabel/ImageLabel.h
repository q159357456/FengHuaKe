//
//  ImageLabel.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/28.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageLabel : UIView
+(instancetype)initWithFrame:(CGRect)frame Image:(NSString*)imageNmae Title:(NSString*)title IsNet:(BOOL)isNet;


/**
 图片的高度
 */
@property(nonatomic,assign)CGFloat imageHeight;

/**
 label的高度
 */
@property(nonatomic,assign)CGFloat labelHeight;


/**
 字体
 默认系统12号字体
 */
@property (nonatomic, strong) UIFont *labelFont;
/**
字体颜色
*/
@property (nonatomic, strong) UIColor *labelColor;
/**
 Label 行数
 */
@property(nonatomic) NSInteger numberOfLines;
/**
 Label 文字对齐方式
 默认居中对齐
 */
@property (nonatomic, assign) NSTextAlignment textAlign;
/**
 Label 背景颜色
 */
@property (nonatomic, strong) UIColor *labelBacgroudColor;
/**
 lable距离图片的距离
 */
@property(nonatomic,assign)CGFloat labelOffsetY;
/**
图片距离顶部的距离
 */
@property(nonatomic,assign)CGFloat imageOffsetY;
/**
 图片的 contentMode
 默认为 UIViewContentModeScaleAspectFit
 */
@property (nonatomic, assign) UIViewContentMode contentMode;
@end
