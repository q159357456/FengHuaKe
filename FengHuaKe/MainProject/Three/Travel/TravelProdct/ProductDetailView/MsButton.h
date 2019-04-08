//
//  MsButton.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MsButton : UIButton
@property (nonatomic ,strong) UILabel *headLabel;
@property (nonatomic ,strong) UILabel *msgLabel;
@property(nonatomic, retain)UIImageView *jiantou;
- (id)initWithFrame:(CGRect)frame Head:(NSString *)head Message:(NSString *)msg;

@end
