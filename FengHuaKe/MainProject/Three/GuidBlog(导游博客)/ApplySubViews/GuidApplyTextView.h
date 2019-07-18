//
//  GuidApplyTextView.h
//  FengHuaKe
//
//  Created by chenheng on 2019/7/18.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GuidApplyTextView : UIView
@property(nonatomic,copy)NSString *outPutTxt;
@property(nonatomic,strong)UITextView * textview;
@property(nonatomic,assign)BOOL not_edit_avilble;
@property(nonatomic,strong)UILabel * label;
@end

NS_ASSUME_NONNULL_END
