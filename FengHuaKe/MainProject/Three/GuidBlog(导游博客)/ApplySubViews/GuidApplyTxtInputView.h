//
//  GuidApplyTxtInputView.h
//  FengHuaKe
//
//  Created by chenheng on 2019/6/14.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuidApplyBaseView.h"
NS_ASSUME_NONNULL_BEGIN

@interface GuidApplyTxtInputView : GuidApplyBaseView
@property(nonatomic,copy)NSString *outPutTxt;
@property(nonatomic,strong)UITextField * textfield;
@end

NS_ASSUME_NONNULL_END
