//
//  BillModel.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "BillModel.h"

@implementation BillModel
+(NSMutableArray *)getDatawithdic:(NSDictionary *)dic
{
    
    NSMutableArray *array=[NSMutableArray array];
    for (NSDictionary *dic1 in dic[@"DataList"]) {
        
        
        BillModel *model=[[BillModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        model.OrderDetail=[OrderDetailModel getDatawithdic:model.OrderDetail];
        
        [array addObject:model];
    }
    
    
    return array;
}
+(NSMutableArray*)getUsefulDicStr:(NSDictionary*)dic
{
    NSMutableArray *array=[NSMutableArray array];
    for (NSDictionary *dic1 in dic[@"DataList"]) {
        
        NSArray *barray=@[dic1];
        NSString *str=[DataProcess getJsonStrWithObj:barray];
        
        [array addObject:str];
    }
    
    
    return array;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end


@implementation OrderDetailModel
+(NSMutableArray *)getDatawithdic:(NSArray *)data
{
    NSMutableArray *array=[NSMutableArray array];
    for (NSDictionary *dic1 in data) {
        
        
        OrderDetailModel *model=[[OrderDetailModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        
        
        [array addObject:model];
    }
    
    
    return array;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
