//
//  ClassifyModel.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/22.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassifyModel : NSObject
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *createdate;
@property(nonatomic,copy)NSString *fristclassify;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *modifydate;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *parentid;
@property(nonatomic,copy)NSString *property;
@property(nonatomic,copy)NSString *sortnum;
@property(nonatomic,copy)NSString *state;
@property(nonatomic,assign)BOOL selected;
+(NSMutableArray *)getDatawithdic:(NSDictionary *)dic;
+(NSMutableArray *)getDatawithArray:(NSArray *)dataArray;
@end
