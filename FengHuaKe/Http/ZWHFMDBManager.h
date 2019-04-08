//
//  ZWHFMDBManager.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/20.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface ZWHFMDBManager : NSObject

@property(nonatomic,strong)FMDatabase *db;
//单例模式
+(ZWHFMDBManager *) shareDatabase;


-(void)creatTableWith:(NSObject *)model;


-(void)insertGroup:(NSObject *)model;

-(NSArray *)findDtaWith:(NSObject *)table withKey:(NSString *)key withValue:(NSString *)value;

-(void)deleteWithTable:(NSObject *)model WithKey:(NSString *)key WithValue:(NSString *)value;

-(void)deleteTableWith:(NSObject *)model;

-(NSArray *)getAllDataWith:(NSObject *)table;

-(void)updateTable:(NSObject *)model WithKey:(NSString *)key;

@end
