//
//  TiketDetailForthCell.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/21.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiketBaseTableViewCell.h"
#import "TicketSingleModel.h"
@interface TiketDetailForthCell : TiketBaseTableViewCell
@property(nonatomic,strong)UILabel *lable1;
@property(nonatomic,strong)UILabel *lable2;
@property(nonatomic,strong)UILabel *lable3;
@property(nonatomic,strong)UIButton *button1;
@property(nonatomic,strong)UIButton *button2;
@property(nonatomic,strong)TicketSubSonModel *model;
@end
