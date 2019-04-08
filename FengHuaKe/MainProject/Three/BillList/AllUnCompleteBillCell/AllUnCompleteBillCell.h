//
//  AllUnCompleteBillCell.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillModel.h"
@interface AllUnCompleteBillCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UIImageView *proImage;
@property(nonatomic,strong)OrderDetailModel *model;
@end
