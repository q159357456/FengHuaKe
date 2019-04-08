//
//  TicketSingleModel.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/21.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "TicketSingleModel.h"

@implementation TicketSingleModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"SpecTree":@"TicketSonTypeModel"};
}

+(NSMutableArray *)getDatawitharray:(NSArray *)array
{
    NSMutableArray *myarray=[NSMutableArray array];
    for (NSDictionary *dic1 in array) {
        
        
        TicketSingleModel *model=[[TicketSingleModel  alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        model.SpecTree=[TicketSonTypeModel getDatawitharray:model.SpecTree];
        
        [myarray addObject:model];
    }
    return myarray;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end


@implementation TicketSonTypeModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"Table":@"TicketSubSonModel"};
}

-(void)setKey:(NSString *)key{
    _key = key;
    _isShow = NO;
}

+(NSMutableArray *)getDatawitharray:(NSArray *)array
{
    NSMutableArray *myarray=[NSMutableArray array];
    for (NSDictionary *dic1 in array) {
        
        
        TicketSonTypeModel *model=[[TicketSonTypeModel  alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        model.Table=[TicketSubSonModel getDatawitharray:model.Table];
        [myarray addObject:model];
    }
    return myarray;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end

@implementation TicketSubSonModel
+(NSMutableArray *)getDatawitharray:(NSArray *)array
{
    NSMutableArray *myarray=[NSMutableArray array];
    for (NSDictionary *dic1 in array) {
        
        
        TicketSubSonModel *model=[[TicketSubSonModel  alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        
        [myarray addObject:model];
    }
    return myarray;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
