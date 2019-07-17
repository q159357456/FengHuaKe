//
//  CookingOrderController.h
//  FengHuaKe
//
//  Created by 秦根 on 2019/7/16.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
#import "CookingDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CookingOrderController : UIViewController
@property(nonatomic,strong)ProductModel * pmodel;
@property(nonatomic,strong)CookingDetailModel * cmodel;
@end

NS_ASSUME_NONNULL_END
