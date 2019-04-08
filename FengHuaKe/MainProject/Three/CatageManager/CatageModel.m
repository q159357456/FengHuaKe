//
//  CatageModel.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/13.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "CatageModel.h"

@implementation CatageModel
+(NSMutableArray *)getDatawithdic:(NSDictionary *)dic
{
    NSMutableArray *array=[NSMutableArray array];
    for (NSDictionary *dic1 in dic[@"DataList"]) {
        
        
       CatageModel *model=[[CatageModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        
        [array addObject:model];
    }
    
    
    return array;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
