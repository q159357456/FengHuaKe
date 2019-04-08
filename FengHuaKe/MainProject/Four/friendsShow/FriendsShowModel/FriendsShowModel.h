//
//  FriendsShowModel.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/3.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LikeItemMode,CommentItemModel;
@interface FriendsShowModel : NSObject
@property (nonatomic, copy) NSString *logonurl;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *memberid;
@property (nonatomic, copy) NSString *melike;
@property (nonatomic, strong) NSArray *PicList;

@property (nonatomic, assign, getter = isLiked) BOOL liked;

@property (nonatomic, strong) NSArray<LikeItemMode *> *LikeList;
@property (nonatomic, strong) NSArray<CommentItemModel *> *CommentList;

@property (nonatomic, assign) BOOL isOpening;

@property (nonatomic, assign, readonly) BOOL shouldShowMoreButton;
+(NSMutableArray *)getDatawithdic:(NSDictionary *)dic;
@end

@interface LikeItemMode :NSObject
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *memberid;
@property (nonatomic, copy) NSAttributedString *attributedContent;
+(NSMutableArray *)getDatawitArray:(NSArray *)array;
@end

@interface CommentItemModel :NSObject
@property (nonatomic, copy) NSString *details;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *memberid;
@property (nonatomic, copy) NSString *parentid;
@property (nonatomic, copy) NSString *secondUserName;
@property (nonatomic, copy) NSString *secondUserId;

@property (nonatomic, copy) NSAttributedString *attributedContent;
+(NSMutableArray *)getDatawitArray:(NSArray *)array;

@end

@interface PicItemMode:NSObject
@property(nonatomic,copy)NSString *url;
+(NSMutableArray *)getDatawitArray:(NSArray *)array;
@end

