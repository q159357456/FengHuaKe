//
//  FriendsShowModel.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/3.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "FriendsShowModel.h"
extern const CGFloat contentLabelFontSize;
extern CGFloat maxContentLabelHeight;

@implementation FriendsShowModel
{
    CGFloat _lastContentWidth;
}
@synthesize msg = _msg;
-(void)setMsg:(NSString *)msg
{
    _msg=msg;
}
- (NSString *)msgContent
{
    CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 70;
    if (contentW != _lastContentWidth) {
        _lastContentWidth = contentW;
        CGRect textRect = [_msg boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:contentLabelFontSize]} context:nil];
        if (textRect.size.height > maxContentLabelHeight) {
            _shouldShowMoreButton = YES;
        } else {
            _shouldShowMoreButton = NO;
        }
    }
    
    return _msg;
}

- (void)setIsOpening:(BOOL)isOpening
{
    if (!_shouldShowMoreButton) {
        _isOpening = NO;
    } else {
        _isOpening = isOpening;
    }
}

+(NSMutableArray *)getDatawithdic:(NSDictionary *)dic
{
   
    NSMutableArray *array=[NSMutableArray array];
    for (NSDictionary *dic1 in dic[@"DataList"]) {
        
        
        FriendsShowModel *model=[[FriendsShowModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        
        model.CommentList=[CommentItemModel getDatawitArray:model.CommentList];
        model.LikeList=[LikeItemMode getDatawitArray:model.LikeList];
        model.PicList=[PicItemMode getDatawitArray:model.PicList];
        [array addObject:model];
    }
    
    
    return array;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end


@implementation LikeItemMode
+(NSMutableArray *)getDatawitArray:(NSArray *)array
{
    NSMutableArray *barray=[NSMutableArray array];
    for (NSDictionary *dic1 in array) {
        
        
       LikeItemMode *model=[[LikeItemMode alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        
        [barray addObject:model];
    }
    
    
    return barray;
 
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end

@implementation CommentItemModel
+(NSMutableArray *)getDatawitArray:(NSArray *)array
{
    NSMutableArray *barray=[NSMutableArray array];
    for (NSDictionary *dic1 in array) {
        
        
        CommentItemModel *model=[[CommentItemModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        
        [barray addObject:model];
    }
    
    
    return barray;

}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end

@implementation PicItemMode
+(NSMutableArray *)getDatawitArray:(NSArray *)array
{
    NSMutableArray *bArray=[NSMutableArray array];
    for (NSDictionary *dic1 in array)
    {
        [bArray addObject:dic1[@"url"]];
    }
    return bArray;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end

