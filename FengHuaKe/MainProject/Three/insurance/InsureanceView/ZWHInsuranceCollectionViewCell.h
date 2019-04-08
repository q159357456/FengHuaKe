//
//  ZWHInsuranceCollectionViewCell.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InsuranceModel.h"

@interface ZWHInsuranceCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)QMUILabel *price;
@property(nonatomic,strong)QMUILabel *title;
@property(nonatomic,strong)UIImageView *img;

@property(nonatomic,strong)InsuranceModel *model;




@end
