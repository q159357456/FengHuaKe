//
//  MyfriendModel.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "MyfriendModel.h"

@implementation MyfriendModel
+(NSMutableArray *)getDatawithdic:(NSDictionary *)dic
{
    NSMutableArray *array=[NSMutableArray array];
    for (NSDictionary *dic1 in dic[@"DataList"]) {
        
        
        MyfriendModel *model=[[MyfriendModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        
        [array addObject:model];
    }
    
    
    return array;
}

+(NSMutableArray *)getNewDataWithDic:(NSDictionary *)dic{
    NSArray *arr = [HttpTool getArrayWithData:dic[@"sysmodel"][@"strresult"]];
    NSMutableArray *friArray = [NSMutableArray array];
    for (NSDictionary *dict in arr) {
        if ((NSNull *)dict[@"userlist"]==[NSNull null]){
        }else{
            for (NSDictionary *friend in dict[@"userlist"]) {
                MyfriendModel *model=[[MyfriendModel alloc]init];
                [model setValuesForKeysWithDictionary:friend];
                [friArray addObject:model];
            }
        }
    }
    return friArray;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
