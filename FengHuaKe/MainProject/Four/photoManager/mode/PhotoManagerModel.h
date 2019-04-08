//
//  PhotoManagerModel.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/10.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoManagerModel : NSObject
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *createdate;
@property (nonatomic, copy) NSString *createuser;
@property (nonatomic, copy) NSString *memberid;
@property (nonatomic, copy) NSString *logonurl;
@property (nonatomic, copy) NSString *modifydate;
@property (nonatomic, copy) NSString *modifyuser;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *nums;
@property (nonatomic, copy) NSString *photos_logo_url;
@property (nonatomic, copy) NSString *publicif;
@property (nonatomic, copy) NSString *putdate;
@property (nonatomic, copy) NSString *remark;
+(NSMutableArray *)getDatawithdic:(NSDictionary *)dic;
@end
