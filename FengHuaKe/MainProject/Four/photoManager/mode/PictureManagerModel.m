//
//  PictureManagerModel.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/11.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "PictureManagerModel.h"

@implementation PictureManagerModel
+(NSMutableArray *)getDatawithdic:(NSDictionary *)dic
{
    
    NSMutableArray *array=[NSMutableArray array];
    for (NSDictionary *dic1 in dic[@"DataList"]) {
        
        PictureManagerModel *model=[[PictureManagerModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        
        [array addObject:model];
    }
    
    return array;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
