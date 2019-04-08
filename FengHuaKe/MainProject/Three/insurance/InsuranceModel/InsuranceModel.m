//
//  InsuranceModel.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/23.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "InsuranceModel.h"

@implementation InsuranceModel
+(NSMutableArray *)getDatawithdic:(NSDictionary *)dic
{
    NSMutableArray *array=[NSMutableArray array];
    for (NSDictionary *dic1 in dic[@"DataList"]) {
        
        
        InsuranceModel *model=[[InsuranceModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        
        [array addObject:model];
    }
    
    
    return array;
}

+(NSDictionary *)mj_objectClassInArray{
    return @{@"OrderDetail":@"ZWHOrderListModel"};
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
