//
//  GBNavigationController.h
//  Restaurant
//
//  Created by 张帆 on 16/9/28.
//  Copyright © 2016年 工博计算机. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBNavigationController : UINavigationController
@property(nonatomic,copy)void(^diffBack)();
@end
