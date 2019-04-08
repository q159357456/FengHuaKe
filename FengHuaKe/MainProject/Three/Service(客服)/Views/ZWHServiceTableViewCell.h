//
//  ZWHServiceTableViewCell.h
//  FengHuaKe
//
//  Created by Syrena on 2018/12/24.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWHServiceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZWHServiceTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *img;
@property(nonatomic,strong)QMUILabel *name;
@property(nonatomic,strong)QMUILabel *tips;
@property(nonatomic,strong)QMUILabel *orderNum;
@property(nonatomic,strong)QMUILabel *rate;

@property(nonatomic, strong)QMUIFloatLayoutView *floatLayoutView;
@property(nonatomic,strong)ZWHServiceModel *model;



@end

NS_ASSUME_NONNULL_END
