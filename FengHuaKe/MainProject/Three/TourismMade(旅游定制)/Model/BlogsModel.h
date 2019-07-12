//
//  BlogsModel.h
//  FengHuaKe
//
//  Created by chenheng on 2019/7/12.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlogsModel : NSObject
@property(nonatomic,copy)NSString * auditdate;
@property(nonatomic,copy)NSString * audituser ;
@property(nonatomic,copy)NSString * author;
@property(nonatomic,copy)NSString * classify;
@property(nonatomic,copy)NSString * classifyName;
@property(nonatomic,copy)NSString * code;
@property(nonatomic,copy)NSString * commentNum;
@property(nonatomic,copy)NSString * content;
@property(nonatomic,copy)NSString * createdate;
@property(nonatomic,copy)NSString * createuser;
@property(nonatomic,copy)NSString *  img;
@property(nonatomic,copy)NSString * tips;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * logo;
@property(nonatomic,assign)NSInteger  likenums;
@property(nonatomic,assign)NSInteger  sortnum;
@property(nonatomic,assign)NSInteger  statu;
@end

NS_ASSUME_NONNULL_END
