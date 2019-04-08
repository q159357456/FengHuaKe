//
//  ConfirmBillVC.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmBillVC : UIViewController
@property(nonatomic,strong)NSArray *billData;
@property(nonatomic,copy)NSString *totalPrice;
//是否为购物车下单【立即下单 false】
@property(nonatomic,assign)BOOL blresult;

//1立即下单  2购物车下单
@property(nonatomic,assign)NSInteger state;


@end
