//
//  GroupBuyMananger.h
//  FengHuaKe
//
//  Created by chenheng on 2019/7/19.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class GroupBuyParams;
@class CommonArguments;
@class GroupBuyClassify;
@interface GroupBuyMananger : NSObject
+(instancetype)singleton;
@property(nonatomic,assign)BOOL isGroupStyle;
@property(nonatomic,strong)GroupBuyClassify * ticket;
@property(nonatomic,strong)GroupBuyClassify * hotel;
@property(nonatomic,strong)GroupBuyClassify * travelspec;
@property(nonatomic,strong)GroupBuyClassify * repast;
@property(nonatomic,strong)GroupBuyClassify * travelgoods;
-(void)po_GroupBuyIdentify:(NSString*)identify;
-(void)backToGroupBuyWithProName:(NSString*)proName;
@end

@interface GroupBuyClassify :NSObject
@property(nonatomic,strong)CommonArguments *commonArguments;
@property(nonatomic,strong)GroupBuyParams *groupBuyParams;
@property(nonatomic,copy)NSString * proName;
@end

@interface CommonArguments : NSObject
@property(nonatomic,copy)NSString * shopid;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * memberid;
@property(nonatomic,copy)NSString * membertype;
@property(nonatomic,copy)NSString * firstclassify;
@property(nonatomic,copy)NSString * prono;
@property(nonatomic,copy)NSString * nums;
@property(nonatomic,copy)NSString * deadline;
@property(nonatomic,copy)NSString * remark;
@end

@interface GroupBuyParams : NSObject
@property(nonatomic,copy)NSString * para1;
@property(nonatomic,copy)NSString * para2;
@property(nonatomic,copy)NSString * para3;
@property(nonatomic,copy)NSString * para4;
@property(nonatomic,copy)NSString * para5;
@property(nonatomic,copy)NSString * para6;
@property(nonatomic,copy)NSString * para7;
@property(nonatomic,copy)NSString * para8;
@property(nonatomic,copy)NSString * para9;
@property(nonatomic,copy)NSString * intresult;
@property(nonatomic,copy)NSString * blresult;
@end
NS_ASSUME_NONNULL_END
