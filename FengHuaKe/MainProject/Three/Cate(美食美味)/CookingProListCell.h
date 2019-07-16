//
//  CookingProListCell.h
//  FengHuaKe
//
//  Created by chenheng on 2019/7/16.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CookingProListCell : UITableViewCell
-(void)loadData:(ProductModel*)model;
@end

NS_ASSUME_NONNULL_END
