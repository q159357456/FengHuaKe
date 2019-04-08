//
//  ZWHPickView.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/24.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^returnChoose)(NSString * value,NSInteger index);

@interface ZWHPickView : UIView

/**
 * 显示字体颜色
 */
@property(nonatomic,strong)UIColor *titleColor;

@property(nonatomic,strong)returnChoose inputValue;

+(void)showZWHPickView:(NSArray *)dataSource with:(returnChoose)value;

@end
