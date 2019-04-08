//
//  BrowserImageView.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/9.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaitingView.h"
@interface BrowserImageView : UIImageView<UIGestureRecognizerDelegate>
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign, readonly) BOOL isScaled;
@property (nonatomic, assign) BOOL hasLoadedImage;

- (void)eliminateScale; // 清除缩放
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;
- (void)doubleTapToZommWithScale:(CGFloat)scale;
- (void)clear;
@end
