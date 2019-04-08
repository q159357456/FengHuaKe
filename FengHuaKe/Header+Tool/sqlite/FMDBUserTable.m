//
//  FMDBUserTable.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/17.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "FMDBUserTable.h"

@implementation FMDBUserTable
+(FMDBUserTable*) shareInstance
{
    static dispatch_once_t onceToken;
    static FMDBUserTable *sharedInstance=nil;
    dispatch_once(&onceToken, ^{
        sharedInstance=[[FMDBUserTable alloc]init];
    });
    [sharedInstance createUser];
    return sharedInstance;
}
-(void)createUser
{
    self.db=[FMDBhleper shareDatabase].db;
    if(![self.db tableExists:@"userTable"])
    {
        [self.db executeUpdate:@"CREATE TABLE userTable(myid TEXT,friendid TEXT,friendnickname TEXT,friendusertype TEXT,mygroupid TEXT,status TEXT,create_date TEXT,loginurl TEXT)"];
        NSLog(@"create userTable success");
        
    }
    else{
            NSLog(@"已存在表userTable");
    }
    
    
}
//增加
-(void)insertUser:(MyfriendModel *)model
{
    BOOL b= [self.db executeUpdate:@"INSERT INTO userTable(myid,friendid,friendnickname,friendusertype,mygroupid,status,create_date,loginurl) VALUES(?,?,?,?,?,?,?,?)",model.myid,model.friendid,model.friendnickname,model.friendusertype,model.mygroupid,model.status,model.create_date,model.loginurl];
    if(b==YES){
        NSLog(@"inser userTable success");
    }
}
//删除
-(void)deleteTable :(NSString *)friendid
{
    self.db=[FMDBhleper shareDatabase].db;
    if([self.db tableExists:@"userTable"])
    {
        [self.db executeUpdate:@"delete from userTable where friendid=?",friendid];
        NSLog(@"删除成功");
    }
}
//查找
-(NSMutableArray *)getUserData
{
    NSMutableArray *array=[NSMutableArray array];
    FMResultSet *rs = [self.db executeQuery:@"select * from userTable"];
    while ([rs next]) {
        MyfriendModel *group=[[MyfriendModel alloc]init];
        group.create_date=[rs stringForColumn:@"create_date"];
        group.friendnickname=[rs stringForColumn:@"friendnickname"];
        group.friendid=[rs stringForColumn:@"friendid"];
        group.friendusertype=[rs stringForColumn:@"friendusertype"];
        group.mygroupid=[rs stringForColumn:@"mygroupid"];
        group.status=[rs stringForColumn:@"status"];
        group.myid=[rs stringForColumn:@"myid"];
        group.loginurl = [rs stringForColumn:@"loginurl"];
       
        [array addObject:group];
    }
    return array;
}


//更新
-(void)updateUser:(MyfriendModel*)model
{
    FMResultSet *rs = [self.db executeQuery:@"select * from userTable where friendid = ?",model.friendid];
    //(myid,friendid,friendnickname,friendusertype,mygroupid,status,create_date)
    if ([rs next]) {
        /*BOOL operaResult = [self.db executeUpdate:@"UPDATE userTable SET myid=?,friendnickname=?,friendusertype=?,mygroupid=?,status=?,create_date=? WHERE friendid=?,loginurl=?",model.myid,model.friendnickname,model.friendusertype,model.mygroupid,model.status,model.create_date,model.friendid,model.loginurl];*/
        BOOL operaResult = [self.db executeUpdate:@"UPDATE userTable SET myid=?,friendnickname=?,friendusertype=?,mygroupid=?,status=?,create_date=?,friendid=?,loginurl=? WHERE friendid = ? " ,model.myid,model.friendnickname,model.friendusertype,model.mygroupid,model.status,model.create_date,model.friendid,model.loginurl,model.friendid];
        if(operaResult==YES){
            NSLog(@"update userTable success");
        }
    }else{
        NSLog(@"数据库不存在此条数据%@",model.friendid);
    }
}
//精确查找
-(MyfriendModel*)findDtaWith:(NSString*)frendid
{
    FMResultSet *rs = [self.db executeQuery:@"select * from userTable where friendid = ?",frendid];
    NSMutableArray *array=[NSMutableArray array];
    while ([rs next]) {
        MyfriendModel *group=[[MyfriendModel alloc]init];
        group.create_date=[rs stringForColumn:@"create_date"];
        group.friendnickname=[rs stringForColumn:@"friendnickname"];
        group.friendid=[rs stringForColumn:@"friendid"];
        group.friendusertype=[rs stringForColumn:@"friendusertype"];
        group.mygroupid=[rs stringForColumn:@"mygroupid"];
        group.status=[rs stringForColumn:@"status"];
        group.myid=[rs stringForColumn:@"myid"];
        group.loginurl = [rs stringForColumn:@"loginurl"];
        
        [array addObject:group];
    }
    return array[0];
}
-(void)deleteTable
{
    
    self.db=[FMDBhleper shareDatabase].db;
    if([self.db tableExists:@"userTable"])
    {
        [self.db executeUpdate:@"delete from userTable"];
        NSLog(@"删除成功");
    }
    
    
}
@end
