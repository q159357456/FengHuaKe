//
//  UserModel.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/22.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
+(NSMutableArray *)getDatawithdic:(NSDictionary *)dic
{
    NSMutableArray *array=[NSMutableArray array];
    for (NSDictionary *dic1 in dic[@"DataList"]) {
        
        
        UserModel *model=[[UserModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        
        [array addObject:model];
    }
    
    
    return array;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
