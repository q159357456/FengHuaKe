//
//  UIViewController+KeyBoard.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "UIViewController+KeyBoard.h"
#import <objc/runtime.h>
@implementation UIViewController (KeyBoard)
static const char *offsetKey="offset";
-(CGFloat)offset
{
    return [objc_getAssociatedObject(self, offsetKey) floatValue];
}
-(void)setOffset:(CGFloat)offset
{
    return objc_setAssociatedObject(self, offsetKey, @(offset), OBJC_ASSOCIATION_RETAIN);
}
static const char *coverHeightKey="coverHeight";
-(CGFloat)coverHeight
{
    return [objc_getAssociatedObject(self, coverHeightKey) floatValue];
}
-(void)setCoverHeight:(CGFloat)coverHeight
{
    return objc_setAssociatedObject(self, coverHeightKey, @(coverHeight), OBJC_ASSOCIATION_RETAIN);
}

-(void)addKeyBoardNotify
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark--键盘事件
//键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    self.offset = self.coverHeight - (self.view.frame.size.height - kbHeight);
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //将视图上移计算好的偏移
    if(self.offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(self.view.frame.origin.x, -self.offset, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+self.offset, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

@end
