//
//  TicketClassifyModel.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/20.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TicketClassifyModel : NSObject
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *createdate;
@property(nonatomic,copy)NSString *fristclassify;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *modifydate;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *parentid;
@property(nonatomic,copy)NSString *property ;
@property(nonatomic,copy)NSString *sortnum;
@property(nonatomic,copy)NSString *state;
+(NSMutableArray *)getDatawithdic:(NSDictionary *)dic;
@end
