//
//  GuidModel.h
//  FengHuaKe
//
//  Created by chenheng on 2019/6/14.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GuidModel : NSObject
@property(nonatomic,copy)NSString * memberid;
@property(nonatomic,copy)NSString * membertype;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,assign)NSInteger * age;
@property(nonatomic,copy)NSString * birthdate;
@property(nonatomic,copy)NSString * education;
@property(nonatomic,copy)NSString * guide_card;
@property(nonatomic,copy)NSString * statu;
@property(nonatomic,copy)NSString * applydate;
@property(nonatomic,copy)NSString * auditdate;
@property(nonatomic,assign)NSInteger fansnums;
@property(nonatomic,assign)NSInteger likenums;
@property(nonatomic,assign)NSInteger focusnums;
@property(nonatomic,assign)NSInteger collectnums;
@end

NS_ASSUME_NONNULL_END
