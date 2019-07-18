//
//  FollowGroupClassCell.h
//  FengHuaKe
//
//  Created by chenheng on 2019/7/18.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketClassifyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FollowGroupClassCell : UICollectionViewCell
@property(nonatomic,strong)UILabel * label;
-(void)loadData:(TicketClassifyModel*)model;
@end

NS_ASSUME_NONNULL_END
