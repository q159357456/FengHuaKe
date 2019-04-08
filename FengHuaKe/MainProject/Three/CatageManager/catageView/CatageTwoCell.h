//
//  CatageTwoCell.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/28.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupBaseCell.h"
#import "ClassifyModel.h"
@interface CatageTwoCell : GroupBaseCell
@property (weak, nonatomic) IBOutlet UIView *backGround;
@property(nonatomic,strong)NSArray<ClassifyModel*>*array;
@end
