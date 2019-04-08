//
//  InsuranceListCell.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/23.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InsuranceModel.h"
@interface InsuranceListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *lable4;
@property(nonatomic,strong)InsuranceModel *model;
@end
