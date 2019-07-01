//
//  UserDefineModel.h
//  FengHuaKe
//
//  Created by 秦根 on 2019/6/29.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class DefineContentModel;
@interface UserDefineModel : ServiceBaseModel

@end

@interface DefineContentModel : NSObject
@property(nonatomic,copy)NSString * classify;
@property(nonatomic,copy)NSString * code;
@property(nonatomic,copy)NSString * display_text;
@property(nonatomic,copy)NSString * display_value;
@end
NS_ASSUME_NONNULL_END
