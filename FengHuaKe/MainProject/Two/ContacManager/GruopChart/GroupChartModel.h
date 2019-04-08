//
//  GroupChartModel.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupChartModel : NSObject
@property(nonatomic,copy)NSString *allowinvite;
@property(nonatomic,copy)NSString *create_date;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *groupid;
@property(nonatomic,copy)NSString *groupname;
@property(nonatomic,copy)NSString *maxusers;
@property(nonatomic,copy)NSString *members_only;
@property(nonatomic,copy)NSString *owner;
@property(nonatomic,copy)NSString *publicif;
@property(nonatomic,copy)NSString *qrcode;
@property(nonatomic,copy)NSString *istop;

+(NSMutableArray *)getDatawithdic:(NSDictionary *)dic;
+(NSMutableArray *)getDatawitharray:(NSArray *)array;

@end
