//
//  UserDefineCell.h
//  FengHuaKe
//
//  Created by 秦根 on 2019/6/29.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDefineModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface UserDefineCell : UITableViewCell
@property(nonatomic,strong)UILabel * label1;
@property(nonatomic,strong)UILabel * label2;
@property(nonatomic,strong)UILabel * label3;
-(void)loadData:(DefineContentModel*)model;
@end

NS_ASSUME_NONNULL_END
