//
//  ZWHHistoryCollectionViewCell.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/6.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWHCollectModel.h"

@interface ZWHHistoryCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView *img;
@property(nonatomic,strong)UILabel *titleL;

@property(nonatomic,strong)ZWHCollectModel *model;

@end
