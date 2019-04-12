//
//  ChooseCityVC_New.h
//  ZHONGHUILAOWU
//
//  Created by 秦根 on 2018/7/15.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseCityVC_New : UIViewController
@property(nonatomic,copy)void(^backBlock)(NSString *code,NSString*name);
@end
