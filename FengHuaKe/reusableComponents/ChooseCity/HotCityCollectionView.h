//
//  HotCityCollectionView.h
//  ZHONGHUILAOWU
//
//  Created by 秦根 on 2018/7/15.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIResponder+Event.h"

@interface HotCityCollectionView : UICollectionView
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)UILabel *headLable;
-(void)getCityDataWithProcode:(NSString*)proCode;
@end
