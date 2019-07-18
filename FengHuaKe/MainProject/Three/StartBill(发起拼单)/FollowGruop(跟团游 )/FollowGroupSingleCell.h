//
//  FollowGroupSingleCell.h
//  FengHuaKe
//
//  Created by chenheng on 2019/7/18.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FollowGroupSingleCell : UICollectionViewCell
-(void)loadData:(ProductModel*)model;
@end

NS_ASSUME_NONNULL_END
