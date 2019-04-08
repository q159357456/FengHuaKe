//
//  GroupMember.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/23.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupMember : NSObject
@property(nonatomic,copy)NSString *adminif;
@property(nonatomic,copy)NSString *background;
@property(nonatomic,copy)NSString *blockif;
@property(nonatomic,copy)NSString *allowinvite;
@property(nonatomic,copy)NSString *create_date;
@property(nonatomic,copy)NSString *groupid;
@property(nonatomic,copy)NSString *iscustom;
@property(nonatomic,copy)NSString *istop;
@property(nonatomic,copy)NSString *jointime;
@property(nonatomic,copy)NSString *logonurl;
@property(nonatomic,copy)NSString *memberid;
@property(nonatomic,copy)NSString *menickname;
@property(nonatomic,copy)NSString *muteif;
@property(nonatomic,copy)NSString *notdisturb;
@property(nonatomic,copy)NSString *ownerif;
@property(nonatomic,copy)NSString *quittime;
@property(nonatomic,copy)NSString *shownick;
@property(nonatomic,copy)NSString *state;
+(NSMutableArray *)getDatawithdic:(NSDictionary *)dic;
@end
