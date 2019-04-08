//
//  ZWHMyinsuranceViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/9/7.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHMyinsuranceViewController.h"
#import "FDSlideBar.h"
#import "FDSlideContentView.h"
#import "ZWHMyinsuranceListViewController.h"

@interface ZWHMyinsuranceViewController ()<FDSlideContentViewDataSource>

@property(nonatomic,strong)FDSlideBar *sliderBar;
@property(nonatomic,strong)FDSlideContentView *contentView;

@end

@implementation ZWHMyinsuranceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的保险";
    [self setupSlideBar];
    [self setupScollContentView];
    
}

//设置滑动条
-(void)setupSlideBar{
    _sliderBar = [[FDSlideBar alloc]init];
    [self.view addSubview:_sliderBar];
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = LINECOLOR;
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sliderBar.mas_bottom).offset(-1);
        make.height.mas_equalTo(1);
        make.left.right.equalTo(self.view);
    }];
    _sliderBar.backgroundColor = [UIColor whiteColor];
    _sliderBar.itemWidth = ScreenWidth / 2;
    _sliderBar.itemColor = [UIColor blackColor];
    _sliderBar.itemsTitle = @[@"全部",@"已失效"];
    _sliderBar.itemSelectedColor = ZWHCOLOR(@"#4BA4FF");
    _sliderBar.sliderColor = ZWHCOLOR(@"#4BA4FF");
    [_sliderBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(ZWHNavHeight);
        make.height.mas_equalTo(_sliderBar.height);
    }];
    [_sliderBar layoutIfNeeded];
    
    MJWeakSelf
    [_sliderBar slideBarItemSelectedCallback:^(NSUInteger idx) {
        NSLog(@"%ld",idx);
        [weakSelf.contentView scrollSlideContentViewToIndex:idx];
    }];
    
}

//设置滑动控制器
-(void)setupScollContentView{
    CGFloat y = CGRectGetMaxY(_sliderBar.frame);
    CGFloat a = ZWHNavHeight;
    _contentView = [[FDSlideContentView alloc]initWithFrame:CGRectMake(0, y+a, SCREEN_WIDTH, SCREEN_HEIGHT-y-a)];
    _contentView.dataSource = self;
    
    [self.view addSubview:_contentView];
    MJWeakSelf
    [_contentView slideContentViewScrollFinished:^(NSUInteger index) {
        [weakSelf.sliderBar selectSlideBarItemAtIndex:index];
    }];
}


#pragma 滑动条代理方法
- (NSInteger)numOfContentView{
    return 4;
}

//返回控制器
- (UIViewController *)slideContentView:(FDSlideContentView *)contentView viewControllerForIndex:(NSUInteger)index{
    ZWHMyinsuranceListViewController *listVc = [[ZWHMyinsuranceListViewController alloc]init];
    [self addChildViewController:listVc];
    return listVc;
}



@end
