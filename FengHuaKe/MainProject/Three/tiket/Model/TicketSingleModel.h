//
//  TicketSingleModel.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/21.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TicketSingleModel : NSObject
@property(nonatomic,copy)NSString * productno;
@property(nonatomic,copy)NSString *shopid;
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
@property(nonatomic,copy)NSString *minsaleprice;
@property(nonatomic,copy)NSString *maxsaleprice;
@property(nonatomic,copy)NSString *remark;
@property(nonatomic,strong)NSArray *SpecTree;
+(NSMutableArray *)getDatawitharray:(NSArray *)array;
@end
@interface TicketSonTypeModel :NSObject
@property(nonatomic,copy)NSString *key;
@property(nonatomic,copy)NSString *Value;
@property(nonatomic,strong)NSArray *Table;
@property(nonatomic,assign)BOOL isShow;

+(NSMutableArray *)getDatawitharray:(NSArray *)array;
@end

@interface TicketSubSonModel :NSObject
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *prono;
@property(nonatomic,copy)NSString *spec;
@property(nonatomic,copy)NSString *color;
@property(nonatomic,copy)NSString *modelnum;
@property(nonatomic,copy)NSString *property;
@property(nonatomic,copy)NSString *descr;
@property(nonatomic,copy)NSString *saleunit;
@property(nonatomic,copy)NSString *saleweight;
@property(nonatomic,copy)NSString *saleweightunit;
@property(nonatomic,copy)NSString *putaway;
@property(nonatomic,copy)NSString *buyprice;
@property(nonatomic,copy)NSString *amv;
@property(nonatomic,copy)NSString *tax;
@property(nonatomic,copy)NSString *saleprice1;
@property(nonatomic,copy)NSString *saleprice2;
@property(nonatomic,copy)NSString *saleprice3;
@property(nonatomic,copy)NSString *saleprice4;
@property(nonatomic,copy)NSString *saleprice5;
@property(nonatomic,copy)NSString *bonus;
@property(nonatomic,copy)NSString *unit;
@property(nonatomic,copy)NSString *pcs;
@property(nonatomic,copy)NSString *ratio;
@property(nonatomic,copy)NSString *safestock;
@property(nonatomic,copy)NSString *url;
+(NSMutableArray *)getDatawitharray:(NSArray *)array;
@end

