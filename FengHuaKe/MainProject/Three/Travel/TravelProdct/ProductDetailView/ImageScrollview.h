//
//  ImageScrollview.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageScrollview : UIScrollView<UIScrollViewDelegate>
@property(nonatomic, retain)UIScrollView *scro;
@property(nonatomic, retain)UIPageControl *pageControl;
-(instancetype)initWithFrame:(CGRect)frame andImageArr:(NSArray *)imageArr;

@end
