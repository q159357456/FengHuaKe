//
//  ShopCarModel.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/14.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ShopCarModel.h"

@implementation ShopCarModel
+(NSMutableArray *)getDatawithdic:(NSArray *)data;
{
    NSMutableArray *array=[NSMutableArray array];
    for (NSDictionary *dic1 in data) {
        
        
        ShopCarModel *model=[[ShopCarModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        
        [array addObject:model];
    }
    
    
    return array;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
