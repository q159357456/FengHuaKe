//
//  ZWHInsuranceViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHInsuranceViewController.h"
#import "FDSlideBar.h"
#import "FDSlideContentView.h"

#import "ZWHInsuranceListViewController.h"


@interface ZWHInsuranceViewController ()

@property(nonatomic,strong)UIScrollView *insurScroView;
@property(nonatomic,strong)FDSlideBar *sliderBar;
@property(nonatomic,strong)FDSlideContentView *contentView;

@end

@implementation ZWHInsuranceViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _insurScroView = [[UIScrollView alloc]init];
    [_insurScroView setScrollEnabled:NO];
    _insurScroView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_insurScroView];
    [_insurScroView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(ZWHNavHeight);
    }];
}




@end
