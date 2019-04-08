//
//  TicektBillVC.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/22.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketSingleModel.h"
@interface TicektBillVC : UIViewController
@property(nonatomic,strong)TicketSubSonModel *model;
@end
@interface TimePrice :NSObject
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,assign)BOOL slected;
@end
