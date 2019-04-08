//
//  ZWHInvoiceModel.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/7.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZSBaseModel.h"

@interface ZWHInvoiceModel : ZSBaseModel

@property(nonatomic,copy)NSString *companyname;
@property(nonatomic,copy)NSString *taxid;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *bank;
@property(nonatomic,copy)NSString *account;

@property(nonatomic,copy)NSString *code;

@property(nonatomic,copy)NSString *state;

@end
