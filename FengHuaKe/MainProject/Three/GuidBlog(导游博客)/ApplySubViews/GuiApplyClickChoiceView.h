//
//  GuiApplyClickChoiceView.h
//  FengHuaKe
//
//  Created by chenheng on 2019/6/14.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuidApplyBaseView.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger,ClickSyle) {
    ClickSyle_1 = 0,
    ClickSyle_2,
    ClickSyle_3,
};
@interface GuiApplyClickChoiceView : GuidApplyBaseView
@property(nonatomic,strong)UILabel * clickLabel;

@end

NS_ASSUME_NONNULL_END
