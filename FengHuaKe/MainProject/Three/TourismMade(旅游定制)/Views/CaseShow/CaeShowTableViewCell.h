//
//  CaeShowTableViewCell.h
//  FengHuaKe
//
//  Created by 秦根 on 2019/7/11.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CashListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CaeShowTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel * label1;
@property(nonatomic,strong)UILabel * label2;
@property(nonatomic,strong)UIImageView * contentimageView;
-(void)loadData:(CashListModel*)model;
+(CGFloat)rowHeight;
@end

NS_ASSUME_NONNULL_END
