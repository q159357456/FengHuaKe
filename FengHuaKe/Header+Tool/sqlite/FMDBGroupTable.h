//
//  FMDBGroupTable.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/17.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyGroupModel.h"
#import "FMDBhleper.h"
@interface FMDBGroupTable : NSObject
@property(nonatomic,strong)FMDatabase *db;
//创建单例
+(FMDBGroupTable*) shareInstance;
//增加
-(void)insertGroup:(MyGroupModel*)model;
//删除
-(void)deleteTable :(MyGroupModel *)model;
//查找
-(NSMutableArray *)getGroupData;

//更新
-(void)updateGroup:(MyGroupModel*)model;
-(void)deleteTable;
@end
