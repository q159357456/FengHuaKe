//
//  HotelListModel.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "HotelListModel.h"

@implementation HotelListModel
+(NSMutableArray *)getDatawitharray:(NSArray *)array
{
    NSMutableArray *myarray=[NSMutableArray array];
    for (NSDictionary *dic1 in array) {
        
        
        HotelListModel *model=[[HotelListModel  alloc]init];
        [model setValuesForKeysWithDictionary:dic1];

        [myarray addObject:model];
    }
    return myarray;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
