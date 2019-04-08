//
//  FMDBGroupTable.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/17.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "FMDBGroupTable.h"

@implementation FMDBGroupTable
//创建单例
+(FMDBGroupTable*) shareInstance
{
    static dispatch_once_t onceToken;
    static FMDBGroupTable *sharedInstance=nil;
    dispatch_once(&onceToken, ^{
        sharedInstance=[[FMDBGroupTable alloc]init];
    });
    [sharedInstance createUser];
    return sharedInstance;
}
-(void)createUser
{
    self.db=[FMDBhleper shareDatabase].db;
    if(![self.db tableExists:@"GroupTable"])
    {
        [self.db executeUpdate:@"CREATE TABLE GroupTable(myid TEXT,mygroupid TEXT,groupname TEXT,issystem TEXT,nums TEXT,createdate TEXT,createuser TEXT,modifydate TEXT,modifyuser TEXT,show TEXT)"];
        NSLog(@"create GroupTable success");
        
    }
    else{
        NSLog(@"已存在表GroupTable");
    }
    
    
}
//增加
-(void)insertGroup:(MyGroupModel*)model
{
    //CREATE TABLE GroupTable(myid TEXT,mygroupid TEXT,groupname TEXT,issystem TEXT,show TEXT,nums TEXT,createdate TEXT,createuser TEXT,modifydate TEXT,modifyuser TEXT
    BOOL b= [self.db executeUpdate:@"INSERT INTO GroupTable(myid,mygroupid,groupname,issystem,nums,createdate,createuser,modifydate,modifyuser,show) VALUES(?,?,?,?,?,?,?,?,?,?)",model.myid,model.mygroupid,model.groupname,model.issystem,model.nums,model.createdate,model.createuser,model.modifydate,model.modifyuser,model.show];
    if(b==YES){
        NSLog(@"inser GroupTable success");
    }
}
//删除
-(void)deleteTable :(MyGroupModel *)model
{
    self.db=[FMDBhleper shareDatabase].db;
    if([self.db tableExists:@"GroupTable"])
    {
        [self.db executeUpdate:@"delete from GroupTable where mygroupid=?",model.mygroupid];
        NSLog(@"删除成功");
    }
    
}
//查找
-(NSMutableArray *)getGroupData
{
    //myid,mygroupid,groupname,issystem,show,nums,createdate,createuser,modifydate,modifyuser
    NSMutableArray *array=[NSMutableArray array];
    FMResultSet *rs = [self.db executeQuery:@"select * from GroupTable"];
    while ([rs next]) {
        MyGroupModel *group=[[MyGroupModel alloc]init];
        group.myid=[rs stringForColumn:@"myid"];
        group.mygroupid=[rs stringForColumn:@"mygroupid"];
        group.groupname=[rs stringForColumn:@"groupname"];
        group.issystem=[rs stringForColumn:@"issystem"];
        group.nums=[rs stringForColumn:@"nums"];
        group.createdate=[rs stringForColumn:@"createdate"];
        group.createuser=[rs stringForColumn:@"createuser"];
        group.modifydate=[rs stringForColumn:@"modifydate"];
        group.modifyuser=[rs stringForColumn:@"modifyuser"];
        group.show = [rs stringForColumn:@"show"];
        [array addObject:group];
    }
    return array;
}

//更新
-(void)updateGroup:(MyGroupModel*)model
{
    FMResultSet *rs = [self.db executeQuery:@"select * from GroupTable where mygroupid = ?",model.mygroupid];
 //myid,mygroupid,groupname,issystem,show,nums,createdate,createuser,modifydate,modifyuser
    if ([rs next]) {
        BOOL operaResult = [self.db executeUpdate:@"UPDATE GroupTable SET myid=?,groupname=?,issystem=?,nums=?,createdate=?,createuser=?,modifydate=?,modifyuser=?,show=? WHERE mygroupid=?",model.myid,model.groupname,model.issystem,model.nums,model.createdate,model.createuser,model.modifydate,model.modifyuser,model.show,model.mygroupid];
        if(operaResult==YES){
            NSLog(@"更新组成功");
        }else{
            NSLog(@"更新失败");
        }
    }else{
        NSLog(@"数据库不存在此条数据%@",model.mygroupid);
    }
}
-(void)deleteTable
{
    
    self.db=[FMDBhleper shareDatabase].db;
    if([self.db tableExists:@"GroupTable"])
    {
        [self.db executeUpdate:@"delete from GroupTable"];
        NSLog(@"删除成功");
    }
    
    
}
@end
