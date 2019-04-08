//
//  BillTopView.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/17.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BillTopDelegate <NSObject>
@optional
-(void)touchTagindex:(NSInteger)index;
@end
@interface BillTopView : UIView
-(instancetype)initWithFrame:(CGRect)frame Array:(NSArray*)array;
@property(nonatomic,assign)id<BillTopDelegate>delegate;
-(void)choose:(UIButton*)butt;
@end
