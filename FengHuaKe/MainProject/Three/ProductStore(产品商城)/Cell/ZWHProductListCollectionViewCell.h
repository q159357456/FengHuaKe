//
//  ZWHProductListCollectionViewCell.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/9.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProductModel.h"

@interface ZWHProductListCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView *img;
@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UILabel *priceL;

@property(nonatomic,strong)ProductModel *model;

@end
