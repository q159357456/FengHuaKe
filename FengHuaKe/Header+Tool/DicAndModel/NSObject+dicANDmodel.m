//
//  NSObject+dicANDmodel.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/17.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "NSObject+dicANDmodel.h"
#import <objc/runtime.h>
@implementation NSObject (dicANDmodel)
- (NSDictionary *)toDictionary
{
    unsigned int outCount = 0;
    objc_property_t *properties=class_copyPropertyList([self class], &outCount);
    if (outCount!=0) {
        NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:outCount];
        //
        for (NSInteger i=0; i<outCount; i++) {
            objc_property_t  property=properties[i];
            const void *propertyName=property_getName(property);
            NSString *key=[NSString stringWithUTF8String:propertyName];
            
            
             // 继承于NSObject的类都会有这几个在NSObject中的属性
            if ([key isEqualToString:@"description"]
                || [key isEqualToString:@"debugDescription"]
                || [key isEqualToString:@"hash"]
                || [key isEqualToString:@"superclass"]) {
                
                continue;
                
            }
            //类中含有其他类的情况
            // 我们只是测试，不做通用封装，因此这里不额外写方法做通用处理，只是写死测试一下效果
//            if ([key isEqualToString:@"testModel"]) {
//                if ([self respondsToSelector:@selector(toDictionary)]) {
//                    id testModel = [self.testModel toDictionary];
//                    if (testModel != nil) {
//                        [dict setObject:testModel forKey:key];
//                    }
//                    continue;
//                }
//            }
            SEL getter=[self propertyGetterWithKey:key];
            if (getter!=nil) {
                // 获取方法的签名
                NSMethodSignature *signature = [self methodSignatureForSelector:getter];
                // 根据方法签名获取NSInvocation对象
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
                // 设置target
                [invocation setTarget:self];
                
                // 设置selector
                [invocation setSelector:getter];
                
                // 方法调用
                [invocation invoke];
                
                // 接收返回的值
                __unsafe_unretained NSObject *propertyValue = nil;
                [invocation getReturnValue:&propertyValue];
                
                
                
                if (propertyValue!=nil) {
                    [dict setObject:propertyValue forKey:key];
                }else
                {
                    [dict setObject:@"" forKey:key];
                }
                
            }
  
        }
        
        free(properties);
        return dict;
    }
    free(properties);
    return nil;
}
#pragma mark - private
//get
-(SEL)propertyGetterWithKey:(NSString *)key
{
    if (key!=nil) {
        SEL getter=NSSelectorFromString(key);
        
        if ([self respondsToSelector:getter]) {
            return getter;
        }
    }
    
    return nil;
}
//set
-(SEL)propertySetterWithKey:(NSString *)key
{
    NSString *propertySetter=key.capitalizedString;
    propertySetter=[NSString stringWithFormat:@"set%@",propertySetter];
    SEL setter=NSSelectorFromString(propertySetter);
    if ([self respondsToSelector:setter]) {
        return setter;
    }
    return nil;
}
#pragma mark - HYBEmptyPropertyProperty
-(NSDictionary*)defaultValueForEmptyProperty
{
    return @{@"name" : [NSNull null],
             @"title" : [NSNull null],
             @"count" : @(1),
             @"commentCount" : @(1),
             @"classVersion" : @"0.0.1"};
}
@end
