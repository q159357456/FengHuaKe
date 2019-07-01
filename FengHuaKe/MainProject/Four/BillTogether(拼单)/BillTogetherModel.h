//
//  BillTogetherModel.h
//  FengHuaKe
//
//  Created by chenheng on 2019/7/1.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BillTogetherModel : ServiceBaseModel

@end

@interface BillTogetherContentModel : NSObject
@property(nonatomic,copy)NSString * billno;
@property(nonatomic,copy)NSString * cod;
@property(nonatomic,copy)NSString * memberid;
@property(nonatomic,copy)NSString * remark;
@property(nonatomic,copy)NSString * prono;
@property(nonatomic,copy)NSString * start_use;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString *state_text;
@property(nonatomic,assign)NSInteger used_nums;
@end
NS_ASSUME_NONNULL_END
