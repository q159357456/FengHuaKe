//
//  BPPCalendarModel.m
//  ZHONGHUILAOWU
//
//  Created by 秦根 on 2018/3/21.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "BPPCalendarModel.h"
@interface BPPCalendarModel()
@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, assign) NSInteger day;//天
@property (nonatomic, assign) NSInteger month;//月
@property (nonatomic, assign) NSInteger year;//年
@property (nonatomic, strong) NSMutableArray *dayArray;
@end
@implementation BPPCalendarModel
-(instancetype)init
{
    if (self=[super init]) {
        self.calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *nowCompoents =[self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
        self.year = nowCompoents.year;
        self.month = nowCompoents.month;
        self.day = nowCompoents.day;
        self.dayArray = [[NSMutableArray alloc] init];
    }
    return self;
}
#pragma mark private
//返回本月第一天的NSDate对象
- (NSDate *)firstDayDate {
    
    return nil;
}
//返回上个月第一天的NSDate对象
- (NSDate *)setLastMonthWithDay {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * date = nil;
    if (self.month != 1) {
        
        date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%d",self.year,self.month-1,01]];
        
    }else{
        
        date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%d-%d",self.year - 1,12,01]];
    }
    return date;
}
#pragma mark pubilc
- (NSArray *)setDayArr
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    
    NSDate * nowDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%d",_year,_month,1]];

    NSRange dayRange = [_calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:nowDate];
    NSRange lastdayRange = [_calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[self setLastMonthWithDay]];
    //本月第一天的NSDate对象
    NSDate *nowMonthfirst = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%d",_year,_month,1]];
    //本月第一天是星期几
    NSDateComponents * components = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:nowMonthfirst];
    //本月最后一天的NSDate对象
    NSDate * nextDay = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld",_year,_month,dayRange.length]];
    //本月最后一天星期几
    NSDateComponents * lastDay = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:nextDay];
    //上个月遗留的天数
    /*for (NSInteger i = lastdayRange.length - components.weekday + 2; i <= lastdayRange.length; i++) {
        
        [self.dayArray addObject:@""];
       
    }*/
    
    for (NSInteger i = 0; i <components.weekday-1; i++) {
        [self.dayArray addObject:@""];
    }
    
    //本月的总天数
    for (NSInteger i = 1; i <= dayRange.length ; i++) {
        NSString * string = [NSString stringWithFormat:@"%ld",i];
        [self.dayArray addObject:string];
        
    }
    //下个月空出的天数
    for (NSInteger i = 1; i <= (7 - lastDay.weekday); i++) {
//        NSString * string = [NSString stringWithFormat:@"%ld",i];
        [self.dayArray addObject:@""];
        
    }
    self.index = components.weekday - 2 + self.day;
//    NSLog(@"self.index:%ld",self.index);
    self.block(_year, _month);
    
    return self.dayArray;
}

- (NSArray *)nextMonthDataArr
{
    [self.dayArray removeAllObjects];
    if (_month == 12) {
        _month = 1;
        _year ++;
    }else {
        _month ++;
    }
    return [self setDayArr];
}

- (NSArray *)lastMonthDataArr
{
    [self.dayArray removeAllObjects];
    if (_month == 1) {
        _month = 12;
        _year --;
    }else {
        _month --;
    }
;

    return [self setDayArr];
}
//-(NSInteger)getNowDay
//{
//    NSDateComponents *nowCompoents =[self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
//    self.day = nowCompoents.day;
//}
@end
