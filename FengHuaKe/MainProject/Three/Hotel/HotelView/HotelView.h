//
//  HotelView.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelView : UIView
@property(nonatomic,strong)UILabel *lable;
-(instancetype)initWithFrame:(CGRect)frame Title:(NSString*)title;
@end
