//
//  HotelRoomListModel.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "HotelRoomListModel.h"

@implementation HotelRoomListModel
+(NSMutableArray *)getDatawitharray:(NSArray *)array
{
    NSMutableArray *myarray=[NSMutableArray array];
    for (NSDictionary *dic1 in array) {
        
        
        HotelRoomListModel *model=[[HotelRoomListModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        
        [myarray addObject:model];
    }
    return myarray;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
