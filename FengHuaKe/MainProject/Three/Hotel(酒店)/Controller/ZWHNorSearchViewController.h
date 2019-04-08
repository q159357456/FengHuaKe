//
//  ZWHNorSearchViewController.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/24.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "QMUICommonTableViewController.h"

typedef void (^searchWithStr)(NSString *context);

@interface ZWHNorSearchViewController : ZWHBaseViewController

@property (nonatomic,strong)searchWithStr contextBlock;


//0 旅游用品或者旅游特产 1门票 2酒店 3好友
@property(nonatomic,assign)NSInteger state;

//一级分类
@property(nonatomic,copy)NSString *code;
//二级分类
@property(nonatomic,copy)NSString *secode;

@property(nonatomic,copy)NSArray *timeArr;



@end
