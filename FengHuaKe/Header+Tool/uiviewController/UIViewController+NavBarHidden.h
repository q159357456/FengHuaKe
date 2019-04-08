//
//  UIViewController+NavBarHidden.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavBarHidden)

@property(nonatomic,weak)UITableView *keyTableView;

@property(nonatomic,weak)UICollectionView *keyCollectionView;

/** 需要监听的view */
@property (nonatomic,weak) UIScrollView * keyScrollView;
/** 清除默认导航条的背景设置 */
- (void)setInViewWillAppear;
- (void)setInViewWillDisappear;

/** 偏移offsetY的距离后,导航条的alpha为1 */
- (void)scrollControlByOffsetY:(CGFloat)offsetY;
@end
