//
//  CatageOneCell.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/29.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupBaseCell.h"
#import "ClassifyModel.h"
@interface CatageOneCell : GroupBaseCell
@property(nonatomic,strong)UIView *backGround;
@property(nonatomic,strong)NSArray<ClassifyModel*>*array;
@end
