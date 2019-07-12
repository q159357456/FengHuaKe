//
//  CatageModel.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/13.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CatageModel : NSObject
@property(nonatomic,copy)NSString *author;
@property(nonatomic,copy)NSString *classname;
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *createdate;
@property(nonatomic,copy)NSString *createuser;
@property(nonatomic,copy)NSString *fristclass;
@property(nonatomic,copy)NSString *fromdate;
@property(nonatomic,copy)NSString *imgsrc;
@property(nonatomic,copy)NSString *istop;
@property(nonatomic,copy)NSString *likenum;
@property(nonatomic,copy)NSString *looknum;
@property(nonatomic,copy)NSString *melike;
@property(nonatomic,copy)NSString *modifydate;
@property(nonatomic,copy)NSString *modifyuser;
@property(nonatomic,copy)NSString *secondclass;
@property(nonatomic,copy)NSString *sortnum;
@property(nonatomic,copy)NSString *tips ;
@property(nonatomic,copy)NSString *title ;
@property(nonatomic,copy)NSString *statu ;
@property(nonatomic,copy)NSString *handle ;
@property(nonatomic,copy)NSString *contact ;
@property(nonatomic,copy)NSString *shopid ;
@property(nonatomic,copy)NSString *breviary;
+(NSMutableArray *)getDatawithdic:(NSDictionary *)dic;
@end
