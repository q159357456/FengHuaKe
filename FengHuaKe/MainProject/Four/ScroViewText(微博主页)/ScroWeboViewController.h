//
//  ScroWeboViewController.h
//  FengHuaKe
//
//  Created by Syrena on 2018/9/21.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHBaseViewController.h"

#define childTab  @"ScroChildViewController"
#define fatherTab  @"ScroWeboViewController"
#define contentTab  @"SGPageContentScrollView"


#define OUTSIDE  @"parentVc"
#define INSIDE  @"childVc"


#define HEADERHEIG 300

@interface ScroWeboViewController : ZWHBaseViewController

@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;

//当前页
@property (nonatomic, assign) NSInteger currentIndex;

//判断是否能够滑动
@property(nonatomic,assign)BOOL zwhCanScroaEnble;

//判断是否特殊情况(分页偏移大于0 主视图偏移不够 HEADERHEIG)
@property(nonatomic,assign)BOOL isSpec;


@end
