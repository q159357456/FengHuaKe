//
//  ZWHCollectTableViewCell.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/6.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWHCollectModel.h"

@interface ZWHCollectTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *img;
@property(nonatomic,strong)UILabel *nameL;
@property(nonatomic,strong)UILabel *priceL;

@property(nonatomic,strong)ZWHCollectModel *model;

@end
