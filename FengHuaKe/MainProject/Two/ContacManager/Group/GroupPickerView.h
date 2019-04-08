//
//  GroupPickerView.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/18.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyGroupModel.h"
typedef void (^GroupBlok)(NSString *mygroupid);
@interface GroupPickerView : UIView
@property(nonatomic,copy)GroupBlok groupBlok;
-(instancetype)initWithBlock:(GroupBlok)groupBlok;
@end
