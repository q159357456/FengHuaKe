//
//  BillFooterCell.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillFooterCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lable;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property(nonatomic,copy)void(^gopayBlock)();
@end
