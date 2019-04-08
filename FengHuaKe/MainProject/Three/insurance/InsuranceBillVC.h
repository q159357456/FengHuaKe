//
//  InsuranceBillVC.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/26.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InsuranceModel.h"

@interface InsuranceBillVC : ZWHBaseViewController
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *codename;
@property(nonatomic,strong)InsuranceModel *model;
@property(nonatomic,assign)BOOL isTravel;
@end
