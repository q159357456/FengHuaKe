//
//  GroupChartModel.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "GroupChartModel.h"

@implementation GroupChartModel
+(NSMutableArray *)getDatawithdic:(NSDictionary *)dic
{
    NSMutableArray *array=[NSMutableArray array];
    for (NSDictionary *dic1 in dic[@"DataList"]) {
        
        
        GroupChartModel *model=[[GroupChartModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        NSLog(@"mysever群成员 %@",model.groupid);
        [array addObject:model];
    }
    
    
    return array;
}
+(NSMutableArray *)getDatawitharray:(NSArray *)array
{
    NSMutableArray *myarray=[NSMutableArray array];
    for (NSDictionary *dic1 in array) {
        
        
        GroupChartModel *model=[[GroupChartModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        NSLog(@"mysever群成员 %@",model.groupid);
        [myarray addObject:model];
    }
     return myarray;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
