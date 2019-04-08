//
//  InsuranceChooseCell.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/23.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsuranceChooseCell : UITableViewCell
@property(nonatomic,copy)void(^chooseModelBlock)(NSInteger index);
@end
