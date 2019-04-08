//
//  GroupMember.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/23.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "GroupMember.h"

@implementation GroupMember
+(NSMutableArray *)getDatawithdic:(NSDictionary *)dic
{
    NSMutableArray *array=[NSMutableArray array];
    for (NSDictionary *dic1 in dic[@"DataList"]) {
        
        
        GroupMember *model=[[GroupMember alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
         
        [array addObject:model];
    }
    
    
    return array;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
