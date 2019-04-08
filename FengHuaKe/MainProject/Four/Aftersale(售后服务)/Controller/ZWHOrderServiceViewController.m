//
//  ZWHOrderServiceViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/30.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHOrderServiceViewController.h"
#import "ZWHAfterListViewController.h"

#import "FDSlideBar.h"
#import "FDSlideContentView.h"

@interface ZWHOrderServiceViewController ()<FDSlideContentViewDataSource>

@property(nonatomic,strong)FDSlideBar *sliderBar;
@property(nonatomic,strong)FDSlideContentView *contentView;

@property(nonatomic,strong)NSArray *codeState;

@end

@implementation ZWHOrderServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"售后列表";
    _codeState = @[@"",@"A",@"B",@"C"];
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
    _sliderBar.itemWidth = ScreenWidth / 4;
    _sliderBar.itemColor = [UIColor blackColor];
    _sliderBar.itemsTitle = @[@"售后申请",@"处理中",@"待评价",@"申请记录"];
    _sliderBar.itemSelectedColor = ZWHCOLOR(@"#4BA4FF");
    _sliderBar.sliderColor = ZWHCOLOR(@"#4BA4FF");
    
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
    _contentView = [[FDSlideContentView alloc]initWithFrame:CGRectMake(0, y, SCREEN_WIDTH, SCREEN_HEIGHT-y-a)];
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
    ZWHAfterListViewController *listVc = [[ZWHAfterListViewController alloc]init];
    listVc.state = _codeState[index];
    [self addChildViewController:listVc];
    return listVc;
}




@end
