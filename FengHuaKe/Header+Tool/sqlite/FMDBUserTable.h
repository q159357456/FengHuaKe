//
//  FMDBUserTable.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/17.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDBhleper.h"
#import "MyfriendModel.h"
@interface FMDBUserTable : NSObject
@property(nonatomic,strong)FMDatabase *db;
//创建单例
+(FMDBUserTable*) shareInstance;
//增加
-(void)insertUser:(MyfriendModel *)model;

//删除
-(void)deleteTable :(NSString *)friendid;
//查找
-(NSMutableArray *)getUserData;
//精确查找
-(MyfriendModel*)findDtaWith:(NSString*)frendid;
//更新
-(void)updateUser:(MyfriendModel*)model;
-(void)deleteTable;

@end
