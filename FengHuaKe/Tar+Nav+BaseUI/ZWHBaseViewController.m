//
//  ZWHBaseViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/9.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHBaseViewController.h"

@interface ZWHBaseViewController ()


@end

@implementation ZWHBaseViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(BOOL)shouldCustomNavigationBarTransitionWhenPopAppearing{
    return true;
}

-(BOOL)shouldCustomNavigationBarTransitionWhenPushAppearing{
    return true;
}

-(UIImage *)navigationBarBackgroundImage{
    return [UIImage qmui_imageWithColor:MAINCOLOR];
}

-(UIColor *)titleViewTintColor{
    return [UIColor whiteColor];
}

-(void)setTitleStr:(NSString *)titleStr{
    UILabel *lab = [[UILabel alloc]init];
    lab.text = titleStr;
    lab.textColor = [UIColor whiteColor];
    lab.font = HTFont(28);
    [lab sizeToFit];
    self.navigationItem.titleView = lab;
}






@end
