//
//  BPPCalendar.h
//  ZHONGHUILAOWU
//
//  Created by 秦根 on 2018/3/21.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DateBlock)(NSInteger,NSInteger);
typedef void (^SlectBlock)(NSInteger,NSInteger,NSInteger);
@interface BPPCalendar : UIView
@property(nonatomic,strong)UIView *backGView;
@property(nonatomic,strong)UIView *workView;
@property(nonatomic,strong)NSDate *minDate;
@property (nonatomic, copy) DateBlock datablock;
@property (nonatomic, copy) SlectBlock slectlock;
- (instancetype)initWithFrame:(CGRect)frame SlectBlock:(SlectBlock)slectlock;
@end
