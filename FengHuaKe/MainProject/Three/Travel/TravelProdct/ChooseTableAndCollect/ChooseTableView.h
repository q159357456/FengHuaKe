//
//  ChooseTableView.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/22.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChooseTableView;
@protocol ChooseTableDeledate <NSObject>
@optional
-(void)didRow:(ChooseTableView*)chooseTableView Index:(NSInteger)index;
@end
@interface ChooseTableView : UITableView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)id<ChooseTableDeledate>chooseTableDeledate;
-(instancetype)initWithFrame:(CGRect)frame Data:(NSArray*)data;
@end
