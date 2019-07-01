//
//  BillTogetherTCell.h
//  FengHuaKe
//
//  Created by chenheng on 2019/7/1.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillTogetherModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BillTogetherTCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
-(void)loadData:(BillTogetherContentModel*)model;
@end

NS_ASSUME_NONNULL_END
