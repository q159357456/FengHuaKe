//
//  TiketHotCollecCell.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/20.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TravelListModel.h"
@interface TiketHotCollecCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *lable1;
@property (weak, nonatomic) IBOutlet UILabel *lable2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *withPheight;

@property(nonatomic,strong)TravelListModel *model;
@end
