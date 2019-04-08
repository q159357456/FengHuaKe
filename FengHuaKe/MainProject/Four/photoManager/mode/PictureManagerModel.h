//
//  PictureManagerModel.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/11.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictureManagerModel : NSObject
@property (nonatomic, copy) NSString *CommentList;
@property (nonatomic, copy) NSString *LikeList;
@property (nonatomic, copy) NSString *cancomment;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *createdate;
@property (nonatomic, copy) NSString * descr;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *likenums;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *memberid;
@property (nonatomic, copy) NSString *modifydate;
@property (nonatomic, copy) NSString * parentid;
@property (nonatomic, copy) NSString * parenttype;
@property (nonatomic, copy) NSString *picname;
@property (nonatomic, copy) NSString *putarea;
@property (nonatomic, copy) NSString *sortnum;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *url;
@property(nonatomic,assign)BOOL isSelected;
+(NSMutableArray *)getDatawithdic:(NSDictionary *)dic;
@end
