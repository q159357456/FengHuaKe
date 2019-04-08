//
//  MyGroupModel.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/17.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyGroupModel : NSObject
@property(nonatomic,copy)NSString *myid;
@property(nonatomic,copy)NSString *mygroupid;
@property(nonatomic,copy)NSString *groupname;
@property(nonatomic,copy)NSString *issystem;
@property(nonatomic,copy)NSString *show;
@property(nonatomic,copy)NSString *nums;
@property(nonatomic,copy)NSString *createdate;
@property(nonatomic,copy)NSString *createuser;
@property(nonatomic,copy)NSString *modifydate;
@property(nonatomic,copy)NSString *modifyuser;
@property(nonatomic,strong)NSMutableArray *frenndsArray;
+(NSMutableArray *)getDatawithdic:(NSDictionary *)dic;
@end
