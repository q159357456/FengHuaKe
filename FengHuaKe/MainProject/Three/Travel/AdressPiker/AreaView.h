//
//  AreaView.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/14.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AreaModel;
@protocol AreaViewDelegate <NSObject>
@optional
-(void)didChosenProvince:(AreaModel*)proModel City:(AreaModel*)cityModel District:(AreaModel*)disModel;
@end
@interface AreaView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView *areaWhiteBaseView;
@property(nonatomic,strong)UIScrollView *areaScrollView;
@property(nonatomic,strong)NSMutableArray *provinceArray;
@property(nonatomic,strong)NSMutableArray *cityArray;
@property(nonatomic,strong)NSMutableArray *districtArray;
@property(nonatomic,assign)id<AreaViewDelegate>delegate;
- (void)showAreaView;
- (void)hidenAreaView;
@end
