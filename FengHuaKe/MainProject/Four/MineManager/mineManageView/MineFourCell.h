//
//  MineFourCell.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/29.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupBaseCell.h"
@interface MineFourCell : GroupBaseCell

//文字是否两行
@property(nonatomic,assign)BOOL isDouble;

@property(nonatomic,strong)NSArray *dataArray;

//佣金
@property(nonatomic,strong)UILabel *brokerage;

//现金
@property(nonatomic,strong)UILabel *cash;

//代金券
@property(nonatomic,strong)UILabel *eCoupon;

//积分
@property(nonatomic,strong)UILabel *integral;

@end
