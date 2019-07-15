//
//  CookingTableViewCell.h
//  FengHuaKe
//
//  Created by chenheng on 2019/7/15.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CookingTableViewCell : UITableViewCell
-(void)loadData:(ShopModel*)model;
@end

NS_ASSUME_NONNULL_END
