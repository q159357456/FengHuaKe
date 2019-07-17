//
//  TogetherListCell.h
//  FengHuaKe
//
//  Created by chenheng on 2019/7/17.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupBillModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TogetherListCell : UITableViewCell
-(void)loadData:(GroupBillModel*)model;
@end

NS_ASSUME_NONNULL_END
