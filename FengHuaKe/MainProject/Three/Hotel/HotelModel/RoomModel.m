//
//  RoomModel.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "RoomModel.h"

@implementation RoomModel
+(NSMutableArray *)getDatawitharray:(NSArray *)array
{
    NSMutableArray *myarray=[NSMutableArray array];
    for (NSDictionary *dic1 in array) {
        
        
        RoomModel *model=[[RoomModel  alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        
        [myarray addObject:model];
    }
    return myarray;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
