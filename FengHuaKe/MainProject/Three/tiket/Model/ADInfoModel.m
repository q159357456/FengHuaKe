//
//  ADInfoModel.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/20.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ADInfoModel.h"

@implementation ADInfoModel
+(NSMutableArray *)getDatawithdic:(NSDictionary *)dic
{
    NSMutableArray *array=[NSMutableArray array];
    for (NSDictionary *dic1 in dic[@"DataList"]) {
        
        
        ADInfoModel *model=[[ADInfoModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        
        [array addObject:model];
    }
    
    
    return array;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
