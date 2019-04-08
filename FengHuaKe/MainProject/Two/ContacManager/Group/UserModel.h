//
//  UserModel.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/22.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property(nonatomic,copy)NSString *create_date;
@property(nonatomic,copy)NSString *area;
@property(nonatomic,copy)NSString *label;
@property(nonatomic,copy)NSString *logonurl;
@property(nonatomic,copy)NSString *mileage;
@property(nonatomic,copy)NSString *myid;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *password ;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *signature;
@property(nonatomic,copy)NSString *usertype;
@property(nonatomic,copy)NSString *groupname;

@property(nonatomic,copy)NSString *piclist;



+(NSMutableArray *)getDatawithdic:(NSDictionary *)dic;
@end
