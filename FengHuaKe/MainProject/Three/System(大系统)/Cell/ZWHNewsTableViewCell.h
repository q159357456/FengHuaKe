//
//  ZWHNewsTableViewCell.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/10.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatageModel.h"

@interface ZWHNewsTableViewCell : UITableViewCell


@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UILabel *detailL;
@property(nonatomic,strong)UILabel *timeL;
@property(nonatomic,strong)UILabel *numL;
@property(nonatomic,strong)UIImageView *img;

@property(nonatomic,strong)CatageModel *model;

@end
