//
//  GBSegmentView.h
//  FengHuaKe
//
//  Created by chenheng on 2019/4/23.
//  Copyright © 2019年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GBSegmentView : UIView
+(instancetype)initialSegmentViewFrame:(CGRect)frame DataSource:(NSArray<NSString*>*)dataSource CallBack:(void(^)(NSInteger index))callBack;
@end

NS_ASSUME_NONNULL_END
