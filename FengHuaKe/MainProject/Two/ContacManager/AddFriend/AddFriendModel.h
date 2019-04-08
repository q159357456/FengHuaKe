//
//  AddFriendModel.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddFriendModel : NSObject
@property(nonatomic,copy)NSString *headurl;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *myid;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *sex;
+(NSMutableArray *)getDatawithdic:(NSDictionary *)dic;
@end
