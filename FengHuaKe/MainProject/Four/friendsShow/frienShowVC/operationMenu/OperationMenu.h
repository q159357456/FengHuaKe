//
//  OperationMenu.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/3.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OperationMenu : UIView
@property (nonatomic, assign, getter = isShowing) BOOL show;
@property (nonatomic, copy) void (^likeButtonClickedOperation)();
@property (nonatomic, copy) void (^commentButtonClickedOperation)();
@property (nonatomic, assign, getter = isShowing) BOOL isLike;
@end
