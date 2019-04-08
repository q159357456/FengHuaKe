//
//  RoomModel.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoomModel : NSObject
//@property(nonatomic,copy)NSString *spec;
//@property(nonatomic,copy)NSString *protype;
//@property(nonatomic,copy)NSString *color;
//@property(nonatomic,copy)NSString *modelnum;
//@property(nonatomic,copy)NSString *property;
//@property(nonatomic,copy)NSString *descr;
//@property(nonatomic,copy)NSString *saleunit;
//@property(nonatomic,copy)NSString *saleweight;
@property(nonatomic,copy)NSString *saleweightunit;
@property(nonatomic,copy)NSString *proname;
@property(nonatomic,copy)NSString *proplace;
@property(nonatomic,copy)NSString *brand;
@property(nonatomic,copy)NSString *fitobject;
@property(nonatomic,copy)NSString *fitsex;
@property(nonatomic,copy)NSString *fitscene;
@property(nonatomic,copy)NSString *material;
@property(nonatomic,copy)NSString *firstclassify;
@property(nonatomic,copy)NSString *secondclassify;
@property(nonatomic,copy)NSString *putaway;
@property(nonatomic,copy)NSString *bonus;
@property(nonatomic,copy)NSString *sellnums;
@property(nonatomic,copy)NSString *grade;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *pinkage;
@property(nonatomic,copy)NSString *freight;
@property(nonatomic,copy)NSString *protype;
@property(nonatomic,copy)NSString *spec;
@property(nonatomic,copy)NSString *color;
@property(nonatomic,copy)NSString *modelnum;
@property(nonatomic,copy)NSString * saleunit;
@property(nonatomic,copy)NSString * putaway1;
@property(nonatomic,copy)NSString *buyprice;
@property(nonatomic,copy)NSString *unit;
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *prono;
+(NSMutableArray *)getDatawitharray:(NSArray *)array;
@end
