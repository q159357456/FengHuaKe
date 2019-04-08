//
//  AreaModel.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/14.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaModel : NSObject
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *name;
+(NSMutableArray *)getDatawithdic:(NSArray *)data;
@end
