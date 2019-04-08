//
//  ShopCarBottomView.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/15.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCarBottomView : UIView
@property(nonatomic,strong)UILabel *lable1;
@property(nonatomic,strong)UILabel *lable2;
@property(nonatomic,strong)UIButton *nextButton;
@property(nonatomic,strong)QMUIButton *allBtn;


-(void)hideAllBtn;
@end
