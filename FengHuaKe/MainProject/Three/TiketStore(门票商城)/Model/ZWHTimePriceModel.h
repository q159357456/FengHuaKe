//
//  ZWHTimePriceModel.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/21.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZSBaseModel.h"

@interface ZWHTimePriceModel : ZSBaseModel

@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,assign)BOOL slected;

@end
