//
//  CommentListModel.h
//  FengHuaKe
//
//  Created by chenheng on 2019/7/12.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ReplyModel;
@interface CommentListModel : NSObject
@property(nonatomic,strong)NSArray * CommentList;
@property(nonatomic,copy)NSString * code;
@property(nonatomic,copy)NSString * createdate;
@property(nonatomic,copy)NSString * details;
@property(nonatomic,copy)NSString * logo;
@property(nonatomic,copy)NSString * memberid;
@property(nonatomic,copy)NSString * nickname;
@property(nonatomic,copy)NSString * parentid;
@property(nonatomic,copy)NSString * parenttype;
@property(nonatomic,assign)NSInteger publicif;
@property(nonatomic,assign)NSInteger status;
@end

@interface ReplyModel : CommentListModel

@end
NS_ASSUME_NONNULL_END
