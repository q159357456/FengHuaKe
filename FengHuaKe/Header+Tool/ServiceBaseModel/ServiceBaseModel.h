//
//  ServiceBaseModel.h
//  FengHuaKe
//
//  Created by chenheng on 2019/6/25.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class SysmodelBaseModel;
@interface ServiceBaseModel : NSObject
@property(nonatomic,strong)NSArray *  DataList;
@property(nonatomic,copy)NSString * endindex;
@property(nonatomic,copy)NSString * startindex;
@property(nonatomic,copy)NSString *  timestamp;
@property(nonatomic,copy)NSString *  sign;
@property(nonatomic,copy)NSString *  msg;
@property(nonatomic,assign)NSInteger err;
@property(nonatomic,strong)SysmodelBaseModel * sysmodel;
@end

@interface DatalistBaseModel : NSObject
@property(nonatomic,copy)NSString * COMPANY;
@property(nonatomic,copy)NSString * CREATE_DATE;
@property(nonatomic,assign)NSInteger IsUpdate;
@property(nonatomic,copy)NSString *  MG001;
@property(nonatomic,copy)NSString *  MG002;
@property(nonatomic,copy)NSString *  MG003;
@property(nonatomic,copy)NSString *  MG004;
@property(nonatomic,copy)NSString *  MG005;
@property(nonatomic,copy)NSString *  MG021;
@end

@interface SysmodelBaseModel : NSObject
@property(nonatomic,assign)NSInteger blresult;
@property(nonatomic,assign)NSInteger intresult;
@property(nonatomic,copy)NSString *  strresult;
@property(nonatomic,copy)NSString *  para1;
@property(nonatomic,copy)NSString *  para2;
@property(nonatomic,copy)NSString *  para3;
@property(nonatomic,copy)NSString *  para4;
@property(nonatomic,copy)NSString *  para5;
@property(nonatomic,copy)NSString *  para6;
@property(nonatomic,copy)NSString *  para7;
@property(nonatomic,copy)NSString *  para8;
@property(nonatomic,copy)NSString *  para9;
@end
NS_ASSUME_NONNULL_END
