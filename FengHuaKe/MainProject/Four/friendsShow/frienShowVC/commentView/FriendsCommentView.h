//
//  FriendsCommentView.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/3.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsShowModel.h"
@class FriendsCommentView;
@protocol CommentViewDelegate <NSObject>
-(void)LongPressComment:(CommentItemModel*)mdel;
@end

@interface FriendsCommentView : UIView

- (void)setupWithLikeItemsArray:(NSArray *)likeItemsArray commentItemsArray:(NSArray *)commentItemsArray;

@property (nonatomic, copy) void (^didClickCommentLabelBlock)(NSString *commentId, CGRect rectInWindow);
@property(nonatomic,weak)id<CommentViewDelegate>commentViewDelegate;
@end
