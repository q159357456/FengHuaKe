//
//  RoomDetailVC.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoomDetailVC : ZWHBaseViewController
@property(nonatomic,copy)NSString *roomID;
@property(nonatomic,copy)NSString *hotelID;

@end
@interface InfoView: UIView
@property(nonatomic,strong)UILabel *lable1;
@property(nonatomic,strong)UILabel *lable2;
@end
