//
//  ZWHServiceModel.h
//  FengHuaKe
//
//  Created by Syrena on 2018/12/25.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZWHServiceModel : ZSBaseModel

@property(nonatomic,copy)NSString *shopid;
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *memberid;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *tips;
@property(nonatomic,copy)NSString *quantity;
@property(nonatomic,copy)NSString *ring_id;

@property(nonatomic,copy)NSString *evaluate_01;
@property(nonatomic,copy)NSString *logonurl;

@end

NS_ASSUME_NONNULL_END
