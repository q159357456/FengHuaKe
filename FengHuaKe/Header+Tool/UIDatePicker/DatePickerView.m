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
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
        self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.height-300, ScreenWidth, 300)];
        [self.datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        [self.datePicker setCalendar:[NSCalendar currentCalendar]];
        [self.datePicker setDate:[NSDate date]];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSDate *currentDate = [NSDate date];
        
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        
        [comps setDay:10];//设置最大时间为：当前时间推后10天
        
        NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        
        [comps setDay:0];//设置最小时间为：当前时间
        
        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        
        [self.datePicker setMaximumDate:maxDate];
        
        [self.datePicker setMinimumDate:minDate];
        
        [self.datePicker setDatePickerMode:UIDatePickerModeDate];
        
        [self.view addSubview:self.datePicker];
        
        [self.datePicker addTarget:self action:@selector(dateChange:)forControlEvents:UIControlEventValueChanged];
        
    }
    return self;
}

- (void)dateChange:(UIDatePicker *)date

{
    
    NSLog(@"%@", date.date);
    
}
@end
