//
//  ZWHFMDBManager.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/20.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHFMDBManager.h"

@implementation ZWHFMDBManager

//创建单例
+(ZWHFMDBManager *)shareDatabase
{
    static dispatch_once_t onceToken;
    static ZWHFMDBManager *manager=nil;
    dispatch_once(&onceToken, ^{
        manager=[[ZWHFMDBManager alloc]init];
        [manager createDB];
    });
    [manager openDb];
    return manager;
}
//创建数据库
-(void)createDB
{
    if(self.db != nil)
    {
        return;
    }
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbFilePath = [filePath stringByAppendingString:@"/gongbo4.db"];
    NSLog(@"%@",dbFilePath);
    self.db = [FMDatabase databaseWithPath:dbFilePath];
}
//打开数据库
-(void)openDb
{
    if (![self.db open]) {
        [self.db open];
    }
    //为数据库设置缓存，提高查询效率
    [self.db setShouldCacheStatements:YES];
}


/**
 * 创建表
 */
-(void)creatTableWith:(NSObject *)model{
    
    if (![self.db open]) {
        NSLog(@"数据库打开失败!");
        return;
    }

    
    NSString *tableName = NSStringFromClass([model class]);
    NSArray *propertyArray = [self getAllPropertiesWith:model];
    
    if(![self.db tableExists:tableName])
    {
        NSString *sqlStr = [NSString stringWithFormat:@"CREATE TABLE %@(",tableName];
        
        for (NSInteger i=0; i<propertyArray.count; i++) {
            NSString *propertyStr = [NSString stringWithFormat:@"%@ TEXT,",propertyArray[i]];
            if (i==propertyArray.count-1) {
                propertyStr = [propertyStr stringByReplacingOccurrencesOfString:@"," withString:@")"];
            }
            sqlStr = [NSString stringWithFormat:@"%@%@",sqlStr,propertyStr];
        }
        
        BOOL res = [self.db executeUpdate:sqlStr];
        if (res) {
            NSLog(@"创建表格成功");
        }else {
            NSLog(@"创建表格失败");
        }
    }
    else{
        NSLog(@"已存在表:%@",tableName);
    }
}


/**
 * 加入数据
 */
-(void)insertGroup:(NSObject *)model
{
    
    if (![self.db open]) {
        NSLog(@"数据库打开失败!");
        return;
    }
    
    
    
    
    NSString *tableName = NSStringFromClass([model class]);
    NSArray *propertyArray = [self getAllPropertiesWith:model];
    NSDictionary *dict = [model mj_keyValues];
    
    NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO %@(",tableName];
    
    NSString *valuesqlStr = @"VALUES(";
    
    for (NSInteger i=0; i<propertyArray.count; i++) {
        NSString *propertyStr = [NSString stringWithFormat:@"%@,",propertyArray[i]];
        NSString *valueStr = [NSString stringWithFormat:@"'%@',",[dict objectForKey:propertyArray[i]]];
        if (i==propertyArray.count-1) {
            propertyStr = [propertyStr stringByReplacingOccurrencesOfString:@"," withString:@")"];
            valueStr = [valueStr stringByReplacingOccurrencesOfString:@"," withString:@")"];
        }
        sqlStr = [NSString stringWithFormat:@"%@%@",sqlStr,propertyStr];
        valuesqlStr = [NSString stringWithFormat:@"%@%@",valuesqlStr,valueStr];
    }
    
    NSString *inserStr = [NSString stringWithFormat:@"%@ %@",sqlStr,valuesqlStr];
    BOOL b = [self.db executeUpdate:inserStr];
    if (b) {
        NSLog(@"插入成功");
    }else{
        NSLog(@"插入失败");
    }
}


/**
 * 更新数据
 */
-(void)updateTable:(NSObject *)model WithKey:(NSString *)key
{
    
    NSString *tableName = NSStringFromClass([model class]);
    NSArray *propertyArray = [self getAllPropertiesWith:model];
    NSDictionary *dict = [model mj_keyValues];
    
    FMResultSet *rs = [self.db executeQuery:[NSString stringWithFormat:@"select * from %@ where %@ = '%@'",tableName,key,dict[key]]];
    
    NSLog(@"%@",[NSString stringWithFormat:@"select * from %@ where %@ = '%@'",tableName,key,dict[key]]);
    
    if ([rs next]) {
        NSString *sqlStr = [NSString stringWithFormat:@"UPDATE %@ SET ",tableName];
        for (NSInteger i=0; i<propertyArray.count; i++) {
            NSString *propertyStr = [NSString stringWithFormat:@"%@='%@',",propertyArray[i],[dict objectForKey:propertyArray[i]]];
            if (i == propertyArray.count-1) {
                propertyStr = [propertyStr stringByReplacingOccurrencesOfString:@"," withString:@""];
                propertyStr = [NSString stringWithFormat:@"%@ WHERE %@ = '%@'",propertyStr,key,dict[key]];
            }
            sqlStr = [NSString stringWithFormat:@"%@%@",sqlStr,propertyStr];
        }
        
        NSLog(@"%@",sqlStr);
        BOOL operaResult = [self.db executeUpdate:sqlStr];
        if(operaResult==YES){
            NSLog(@"update userTable success");
        }else{
            NSLog(@"update userTable fail");
        }
    }else{
        NSLog(@"数据库不存在此条数据");
    }
}



/**
 * 查找数据
 */
-(NSArray *)getAllDataWith:(NSObject *)table
{
    NSString *tableName = NSStringFromClass([table class]);
    NSArray *propertyArray = [self getAllPropertiesWith:table];
    FMResultSet *rs = [self.db executeQuery:[NSString stringWithFormat:@"select * from %@",tableName]];
    NSMutableArray *array=[NSMutableArray array];
    while ([rs next]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        for (NSInteger i=0; i<propertyArray.count; i++) {
            [dict setValue:[rs stringForColumn:propertyArray[i]] forKey:propertyArray[i]];
        }
        [array addObject:dict];
    }
    return array;
}



/**
 * 精确查找
 */
-(NSArray *)findDtaWith:(NSObject *)table withKey:(NSString *)key withValue:(NSString *)value
{
    NSString *tableName = NSStringFromClass([table class]);
    NSArray *propertyArray = [self getAllPropertiesWith:table];
    FMResultSet *rs = [self.db executeQuery:[NSString stringWithFormat:@"select * from %@ where %@ = '%@'",tableName,key,value]];
    NSMutableArray *array=[NSMutableArray array];
    while ([rs next]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        for (NSInteger i=0; i<propertyArray.count; i++) {
            [dict setValue:[rs stringForColumn:propertyArray[i]] forKey:propertyArray[i]];
        }
        [array addObject:dict];
    }
    return array;
}




/**
 * 删除指定数据
 */
-(void)deleteWithTable:(NSObject *)model WithKey:(NSString *)key WithValue:(NSString *)value
{
    NSString *tableName = NSStringFromClass([model class]);
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = '%@'",tableName,key,value];
    if([self.db tableExists:tableName])
    {
        BOOL b = [self.db executeUpdate:sql];
        if (b) {
            NSLog(@"删除成功");
        }else{
            NSLog(@"删除失败");
        }
    }
}



/**
 * 删除表中所有数据
 */
-(void)deleteTableWith:(NSObject *)model
{
    NSString *tableName = NSStringFromClass([model class]);
    if([self.db tableExists:tableName])
    {
        [self.db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@",tableName]];
        NSLog(@"删除成功");
    }
    
    
}

//获取对象的所有属性

- (NSArray *)getAllPropertiesWith:(NSObject *)model{
    
    u_int count = 0;
    
    //传递count的地址
    
    objc_property_t *properties = class_copyPropertyList([model class], &count);
    
    NSMutableArray *propertyArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count; i++) {
        
        //得到的propertyName为C语言的字符串
        
        const char *propertyName = property_getName(properties[i]);
        
        [propertyArray addObject:[NSString stringWithUTF8String:propertyName]];
        
        // NSLog(@"%@",[NSString stringWithUTF8String:propertyName]);
        
        
    }
    free(properties);
    
    return propertyArray;
}


@end
