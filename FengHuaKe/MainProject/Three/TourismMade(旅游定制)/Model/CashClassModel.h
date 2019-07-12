//
//  CashClassModel.h
//  FengHuaKe
//
//  Created by chenheng on 2019/7/12.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CashClassModel : NSObject
@property(nonatomic,copy)NSString * SubsetClassify;
@property(nonatomic,copy)NSString * code;
@property(nonatomic,copy)NSString * createdate;
@property(nonatomic,copy)NSString * createuser;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,assign)NSInteger issystem;
@property(nonatomic,assign)NSInteger memberuse;
@property(nonatomic,assign)NSInteger parentid;
@end

NS_ASSUME_NONNULL_END
