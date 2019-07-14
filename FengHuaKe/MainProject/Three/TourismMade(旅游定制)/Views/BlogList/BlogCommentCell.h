//
//  BlogCommentCell.h
//  FengHuaKe
//
//  Created by 秦根 on 2019/7/13.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BlogCommentCell : UITableViewCell
@property(nonatomic,copy)void(^rePlyCallBack)(NSString *code);
-(void)loadData:(CommentListModel*)model;
+(CGFloat)cellHeight:(CommentListModel*)model;
@end

NS_ASSUME_NONNULL_END
