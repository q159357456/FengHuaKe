//
//  ProductDetailModel.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/20.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ProductDetailModel.h"

@implementation ProductDetailModel
+(NSArray *)getDatawithdic:(NSDictionary *)dic
{
    ProductDetailModel *model=[[ProductDetailModel alloc]init];

    [model setValuesForKeysWithDictionary:dic];
    model.PictureList=[PictureModel getDatawithdic:model.PictureList];
    
    model.SpecList=[SpecModel getDatawithdic:model.SpecList];
   
    model.ColorList=[ColorModel getDatawithdic:model.ColorList];
   
    model.ModelList=[SizeModel getDatawithdic:model.ModelList];
    
    model.ProductSpecList=[ProductSpecModel getDatawithdic:model.ProductSpecList];
 
    return @[model];
}

+(NSDictionary *)mj_objectClassInArray{
    return @{@"PictureList":@"PictureModel",@"SpecList":@"SpecModel",@"ColorList":@"ColorModel",@"ModelList":@"SizeModel",@"ProductSpecList":@"ProductSpecModel",@"SpecTree":@"SpecTreeModel"};
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end

@implementation ProductSpecModel
+(NSMutableArray *)getDatawithdic:(NSArray *)array
{
    NSMutableArray *array1=[NSMutableArray array];
    for (NSDictionary *dic1 in array) {
        
        
        ProductSpecModel *model=[[ProductSpecModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        
        [array1 addObject:model];
    }
    
    
    return array1;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end

@implementation SpecModel
+(NSMutableArray *)getDatawithdic:(NSArray *)array
{
    NSMutableArray *array1=[NSMutableArray array];
    for (NSDictionary *dic1 in array) {
        
        
        SpecModel *model=[[SpecModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        
        [array1 addObject:model];
    }
    
    
    return array1;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end

@implementation ColorModel
+(NSMutableArray *)getDatawithdic:(NSArray *)array
{
    NSMutableArray *array1=[NSMutableArray array];
    for (NSDictionary *dic1 in array) {
        
        
        ColorModel *model=[[ColorModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        
        [array1 addObject:model];
    }
    
    
    return array1;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end

@implementation SizeModel
+(NSMutableArray *)getDatawithdic:(NSArray *)array
{
    NSMutableArray *array1=[NSMutableArray array];
    for (NSDictionary *dic1 in array) {
        
        
        SizeModel *model=[[SizeModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        
        [array1 addObject:model];
    }
    
    
    return array1;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end

@implementation PictureModel
+(NSMutableArray *)getDatawithdic:(NSArray *)array
{
    NSMutableArray *array1=[NSMutableArray array];
    for (NSDictionary *dic1 in array) {
        
        
        PictureModel *model=[[PictureModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        
        [array1 addObject:model];
    }
    
    
    return array1;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end

@implementation SpecTreeModel
+(NSMutableArray *)getDatawithdic:(NSArray *)array
{
    NSMutableArray *array1=[NSMutableArray array];
    for (NSDictionary *dic1 in array) {
        
        
        SpecTreeModel *model=[[SpecTreeModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        model.Table=[TableModel getDatawithdic:model.Table];
        [array1 addObject:model];
    }
    
    
    return array1;
}
+(NSDictionary *)mj_objectClassInArray{
    return @{@"Table":@"TableModel"};
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end

@implementation TableModel
+(NSMutableArray *)getDatawithdic:(NSArray *)array
{
    NSMutableArray *array1=[NSMutableArray array];
    for (NSDictionary *dic1 in array) {
        
        
       TableModel *model=[[TableModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        
        [array1 addObject:model];
    }
    
    
    return array1;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
