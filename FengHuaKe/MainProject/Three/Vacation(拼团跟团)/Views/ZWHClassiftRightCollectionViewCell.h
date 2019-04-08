//
//  ZWHClassiftRightCollectionViewCell.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/27.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ClassifyModel.h"

@interface ZWHClassiftRightCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView *img;
@property(nonatomic,strong)UILabel *titleL;

@property(nonatomic,strong)ClassifyModel *model;

@end
