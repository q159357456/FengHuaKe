//
//  MyfriendModel.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyfriendModel : NSObject
@property(nonatomic,copy)NSString *create_date;
@property(nonatomic,copy)NSString *friendcircleright;
@property(nonatomic,copy)NSString *friendid;
@property(nonatomic,copy)NSString *friendnickname;
@property(nonatomic,copy)NSString *friendusertype;
@property(nonatomic,copy)NSString *mygroupid;
@property(nonatomic,copy)NSString *myid;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *loginurl;
+(NSMutableArray *)getDatawithdic:(NSDictionary *)dic;
+(NSMutableArray *)getNewDataWithDic:(NSDictionary *)dic;
@end
