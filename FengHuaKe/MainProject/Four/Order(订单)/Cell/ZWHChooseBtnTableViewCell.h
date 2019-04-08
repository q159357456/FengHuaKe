//
//  ZWHChooseBtnTableViewCell.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/30.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^chooseIndex)(NSInteger index);

@interface ZWHChooseBtnTableViewCell : UITableViewCell

@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)QMUILabel *title;

@property(nonatomic,assign)NSInteger seleIndex;

@property(nonatomic,strong)chooseIndex returnIndex;

@end
