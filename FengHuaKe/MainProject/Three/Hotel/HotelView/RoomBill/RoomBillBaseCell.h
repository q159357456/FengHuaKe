//
//  RoomBillBaseCell.h
//  ZHONGHUILAOWU
//
//  Created by 秦根 on 2018/5/9.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#define PublishFont [UIFont systemFontOfSize:14]
@class RoomBillBaseCell;
@protocol PublishCountBaseDelegate <NSObject>
@optional
-(void)CellEvent:(RoomBillBaseCell*)cell Valuae:(id)valuae;
@end
@interface RoomBillBaseCell : UITableViewCell
@property(nonatomic,assign)id<PublishCountBaseDelegate>baseDelegate;
@property(nonatomic,strong)UILabel *lable;

@end
