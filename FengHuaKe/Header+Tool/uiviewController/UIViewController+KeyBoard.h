//
//  UIViewController+KeyBoard.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (KeyBoard)
//偏移量
@property(nonatomic,assign)CGFloat  offset;
//控件初始高度
@property(nonatomic,assign)CGFloat  coverHeight;
-(void)addKeyBoardNotify;
@end
