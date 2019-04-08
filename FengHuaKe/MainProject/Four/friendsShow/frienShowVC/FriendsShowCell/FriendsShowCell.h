//
//  FriendsShowCell.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/3.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsCommentView.h"
@class FriendsShowModel;
@protocol FriendsShowDelegate<NSObject>
- (void)didClickLikeButtonInCell:(UITableViewCell *)cell;
- (void)didClickcCommentButtonInCell:(UITableViewCell *)cell;
-(void)deletComentComment:(CommentItemModel*)model InCell:(UITableViewCell *)cell;
-(void)deletCellWithModel:(FriendsShowModel*)model;
@end
@class FriendsShowModel;
@interface FriendsShowCell : UITableViewCell<CommentViewDelegate>
@property (nonatomic, weak) id<FriendsShowDelegate> delegate;
@property (nonatomic, strong) FriendsShowModel *model;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) void (^moreButtonClickedBlock)(NSIndexPath *indexPath);
@property (nonatomic, copy) void (^didClickCommentLabelBlock)(NSString *commentId, CGRect rectInWindow, NSIndexPath *indexPath);
@end
