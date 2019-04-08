//
//  ZWHVisaCollectionViewCell.h
//  FengHuaKe
//
//  Created by Syrena on 2018/12/20.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZWHVisaCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView *img;
@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UILabel *priceL;

@property(nonatomic,strong)CatageModel *model;

@end

NS_ASSUME_NONNULL_END
