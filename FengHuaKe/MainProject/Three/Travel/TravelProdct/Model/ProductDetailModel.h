//
//  ProductDetailModel.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/20.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductDetailModel : NSObject
@property(nonatomic,copy)NSString *productno;
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
@property(nonatomic,copy)NSString *minsaleprice;
@property(nonatomic,copy)NSString *maxsaleprice;
@property(nonatomic,strong)NSArray *ProductSpecList;
@property(nonatomic,strong)NSArray *SpecList;
@property(nonatomic,strong)NSArray *ColorList;
@property(nonatomic,strong)NSArray *ModelList;
@property(nonatomic,strong)NSArray *PictureList;
@property(nonatomic,strong)NSArray *SpecTree;
@property(nonatomic,copy)NSString *total;
@property(nonatomic,assign)NSInteger favorite;
+(NSArray *)getDatawithdic:(NSDictionary *)dic;
@end

@interface ProductSpecModel :NSObject
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *prono;
@property(nonatomic,copy)NSString *protype;
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
@property(nonatomic,copy)NSString *remark;
@property(nonatomic,copy)NSString *appPCS;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,strong)NSString *PictureList;
@property(nonatomic,strong)NSString *nums;



+(NSMutableArray *)getDatawithdic:(NSArray *)array;
@end


@interface SpecModel :NSObject
@property(nonatomic,copy)NSString *spec;
+(NSMutableArray *)getDatawithdic:(NSArray *)array;
@end


@interface ColorModel :NSObject
@property(nonatomic,copy)NSString *color;
+(NSMutableArray *)getDatawithdic:(NSArray *)array;
@end


@interface SizeModel :NSObject
@property(nonatomic,copy)NSString *modelnum;
+(NSMutableArray *)getDatawithdic:(NSArray *)array;
@end


@interface PictureModel :NSObject
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *memberid;
@property(nonatomic,copy)NSString *parentid;
@property(nonatomic,copy)NSString *parenttype;
@property(nonatomic,copy)NSString *picname;
@property(nonatomic,copy)NSString *descr;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *putarea;
@property(nonatomic,copy)NSString *longitude;
@property(nonatomic,copy)NSString *latitude;
@property(nonatomic,copy)NSString *modelnum;
@property(nonatomic,copy)NSString *sortnum;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *cancomment;
@property(nonatomic,copy)NSString *createdate;
@property(nonatomic,copy)NSString *modifydate;
@property(nonatomic,copy)NSString *likenums;
+(NSMutableArray *)getDatawithdic:(NSArray *)array;

@end


@interface SpecTreeModel :NSObject
@property(nonatomic,copy)NSString *key;
@property(nonatomic,copy)NSString *Value;
@property(nonatomic,strong)NSArray *Table;
+(NSMutableArray *)getDatawithdic:(NSArray *)array;
@end

@interface TableModel :NSObject
@property(nonatomic,copy)NSString *spec;
@property(nonatomic,copy)NSString *modelnum;
@property(nonatomic,copy)NSString *color;
+(NSMutableArray *)getDatawithdic:(NSArray *)array;
@end


