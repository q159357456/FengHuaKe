//
//  ADInfoModel.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/20.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADInfoModel : NSObject
@property(nonatomic,copy)NSString *AD_Name;
@property(nonatomic,copy)NSString *PicAddress1;
+(NSMutableArray *)getDatawithdic:(NSDictionary *)dic;
@end
