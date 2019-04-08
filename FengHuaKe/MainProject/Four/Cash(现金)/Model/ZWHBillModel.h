//
//  ZWHBillModel.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/1.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZSBaseModel.h"

@interface ZWHBillModel : ZSBaseModel
@property(nonatomic,strong)NSString *type_text;
@property(nonatomic,strong)NSString *createtime;
@property(nonatomic,strong)NSString *amount;
@property(nonatomic,strong)NSString *integral;

@end
