//
//  TopScroView.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/22.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopScroButton.h"
@class TopScroView;
@protocol TopScroDelegate <NSObject>
@optional
-(void)touchTag:(TopScroView*)topScroView index:(NSInteger)index;
@end
@interface TopScroView : UIScrollView
{
    NSInteger _seleindex;
}
@property(nonatomic,assign)id<TopScroDelegate>topScroDelegate;
-(void)buttClick:(TopScroButton*)butt;
-(instancetype)initWithFrame:(CGRect)frame Data:(NSArray*)data;
@end
