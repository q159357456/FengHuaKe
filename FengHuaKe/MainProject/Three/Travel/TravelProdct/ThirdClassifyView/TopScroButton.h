//
//  TopScroButton.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/22.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopScroButton : UIButton
@property(nonatomic,strong)UILabel *textLable;
@property(nonatomic,strong)UIView *bottomView;
-(instancetype)initWithFrame:(CGRect)frame Text:(NSString*)text;
@end
