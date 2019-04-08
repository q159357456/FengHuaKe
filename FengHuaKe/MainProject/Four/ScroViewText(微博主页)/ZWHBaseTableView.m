//
//  ZWHBaseTableView.m
//  FengHuaKe
//
//  Created by Syrena on 2018/9/21.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHBaseTableView.h"

@implementation ZWHBaseTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//允许同时识别多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}




@end
