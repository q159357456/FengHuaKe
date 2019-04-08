//
//  ZWHBaseNavigationViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/30.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHBaseNavigationViewController.h"

@interface ZWHBaseNavigationViewController ()

@end

@implementation ZWHBaseNavigationViewController

+ (void)initialize {
    //设置bar背景
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    //    attrs[NSShadowAttributeName] = [NSValue valueWithUIOffset:UIOffsetMake(0, 0)];
    attrs[NSFontAttributeName] =[UIFont boldSystemFontOfSize:20];
    [navBar setTitleTextAttributes:attrs];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


@end
