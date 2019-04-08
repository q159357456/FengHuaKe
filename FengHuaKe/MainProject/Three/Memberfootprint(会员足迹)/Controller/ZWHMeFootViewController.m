//
//  ZWHMeFootViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2019/2/15.
//  Copyright © 2019年 gongbo. All rights reserved.
//

#import "ZWHMeFootViewController.h"
#import "ZWHFootListViewController.h"

@interface ZWHMeFootViewController ()

@end

@implementation ZWHMeFootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"企业会员足迹";
    [self setUI];
}

-(void)setUI{
    UIView *classView = [[UIView alloc]initWithFrame:CGRectMake(0, ZWHNavHeight, SCREEN_WIDTH, HEIGHT_PRO(40))];
    classView.qmui_borderColor = LINECOLOR;
    classView.qmui_borderWidth = 1;
    classView.qmui_borderPosition = QMUIViewBorderPositionBottom;
    [self.view addSubview:classView];
}










@end
