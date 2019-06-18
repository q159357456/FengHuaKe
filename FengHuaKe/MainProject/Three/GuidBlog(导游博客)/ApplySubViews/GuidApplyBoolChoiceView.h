//
//  GuidApplyBoolChoiceView.h
//  FengHuaKe
//
//  Created by chenheng on 2019/6/14.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuidApplyBaseView.h"
NS_ASSUME_NONNULL_BEGIN

@interface GuidApplyBoolChoiceView : GuidApplyBaseView
{
    NSString *_value;
}
@property(nonatomic,strong)UISegmentedControl * seg;
@property(nonatomic,copy)NSString *value;
@end

NS_ASSUME_NONNULL_END
