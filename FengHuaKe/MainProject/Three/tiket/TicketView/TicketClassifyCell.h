//
//  TicketClassifyCell.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/20.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketClassifyModel.h"
typedef void (^FunBlock)(id);
@interface TicketClassifyCell : UITableViewCell
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,copy)FunBlock funBlock;
@end
