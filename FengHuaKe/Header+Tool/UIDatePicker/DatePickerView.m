//
//  DatePickerView.m
//  FengHuaKe
//
//  Created by chenheng on 2019/6/14.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "DatePickerView.h"
@interface DatePickerView()
@property(nonatomic,copy)void(^chooseDone)(NSDate *date);
@property(nonatomic,strong)UIDatePicker *datePicker;
@property(nonatomic,strong)NSDate * date;
@end
@implementation DatePickerView

+(void)showDatePickerCallBack:(void(^)(NSDate *date))block{
    
    DatePickerView * date = [[DatePickerView alloc]init];
    date.chooseDone = ^(NSDate *date) {
        block(date);
    };
    UIWindow * window = UIApplication.sharedApplication.keyWindow;
    if (![window.subviews containsObject:date]) {
        [window addSubview:date];
    }
}
-(instancetype)init
{
    if (self = [super init]) {
        UIWindow * window = UIApplication.sharedApplication.keyWindow;
        self.frame = window.bounds;
        self.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.8];
        UIView * contentView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height-300, ScreenWidth, 300)];
        contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:contentView];
        self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth, 250)];
        [contentView addSubview:self.datePicker];
        self.datePicker.backgroundColor = [UIColor whiteColor];
        [self.datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        [self.datePicker setCalendar:[NSCalendar currentCalendar]];
        [self.datePicker setDate:[NSDate date]];
        self.date = [NSDate date];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSDate *currentDate = [NSDate date];
        
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        
        [comps setDay:10];//设置最大时间为：当前时间推后10天
        
//        NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
//
//        [comps setDay:0];//设置最小时间为：当前时间
//
//        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
//
//        [self.datePicker setMaximumDate:maxDate];
//
//        [self.datePicker setMinimumDate:minDate];
        
        [self.datePicker setDatePickerMode:UIDatePickerModeDate];
        
        
        [self.datePicker addTarget:self action:@selector(dateChange:)forControlEvents:UIControlEventValueChanged];
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [contentView addSubview:btn1];
        [contentView addSubview:btn2];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(contentView);
            make.size.mas_equalTo(CGSizeMake(100, 50));
        }];
        [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.mas_equalTo(contentView);
            make.size.mas_equalTo(CGSizeMake(100, 50));
        }];
        [btn1 setTitle:@"取消" forState:UIControlStateNormal];
        [btn2 setTitle:@"确定" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
        [btn1 addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)dateChange:(UIDatePicker *)date

{
    self.date = date.date;
    NSLog(@"%@", date.date);
    
}
-(void)queding{
    if (self.chooseDone) {
        self.chooseDone(self.date);
    }
    [self removeFromSuperview];
}
-(void)cancel{
    
    [self removeFromSuperview];
}
@end
