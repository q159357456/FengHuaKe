//
//  ZSBaseModel.m
//  HaveToStudy
//
//  Created by 赵升 on 2017/4/24.
//  Copyright © 2017年 ZS. All rights reserved.
//

#import "ZSBaseModel.h"

@implementation ZSBaseModel
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    return [[self alloc]initWithDictionary:dictionary];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
