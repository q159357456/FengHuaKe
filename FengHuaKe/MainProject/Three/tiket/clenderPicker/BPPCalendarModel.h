//
//  BPPCalendarModel.h
//  ZHONGHUILAOWU
//
//  Created by 秦根 on 2018/3/21.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^dateBlock)(NSInteger,NSInteger);
@interface BPPCalendarModel : NSObject
@property (nonatomic, assign) NSUInteger index;

@property (nonatomic, copy) dateBlock block;
- (NSArray *)setDayArr;

- (NSArray *)nextMonthDataArr;

- (NSArray *)lastMonthDataArr;
@end
