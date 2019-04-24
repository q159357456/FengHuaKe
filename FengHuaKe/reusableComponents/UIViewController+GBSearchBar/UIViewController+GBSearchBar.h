//
//  UIViewController+GBSearchBar.h
//  FengHuaKe
//
//  Created by chenheng on 2019/4/24.
//  Copyright © 2019年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWHSearchBar.h"
NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (GBSearchBar)
-(void)setsearchbar;
@property(nonatomic,strong)ZWHSearchBar *searchBar;
@end

NS_ASSUME_NONNULL_END
