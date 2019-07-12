//
//  TouristTableViewCell.h
//  FengHuaKe
//
//  Created by 秦根 on 2019/7/11.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TouristTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView * headimageView;
@property(nonatomic,strong)UILabel * label1;
@property(nonatomic,strong)UILabel * label2;
@property(nonatomic,strong)UIImageView * contentimageView;
+(CGFloat)rowHeight;
@end

NS_ASSUME_NONNULL_END
