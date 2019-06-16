//
//  GuidApplyAddPicView.h
//  FengHuaKe
//
//  Created by chenheng on 2019/6/14.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuidApplyBaseView.h"
NS_ASSUME_NONNULL_BEGIN

@interface GuidApplyAddPicView : GuidApplyBaseView
-(instancetype)initWithFrame:(CGRect)frame Num:(NSInteger)num;
@property(nonatomic,strong)NSArray * picData;
@end

NS_ASSUME_NONNULL_END
