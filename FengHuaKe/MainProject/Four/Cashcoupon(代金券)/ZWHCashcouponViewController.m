//
//  ZWHCashcouponViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/7/30.
//  Copyright © 2018年 gongbo. All rights reserved.
//


#import "FDSlideBar.h"
#import "FDSlideContentView.h"
#import "ZWHCashcouponViewController.h"
#import "ZWHCashListViewController.h"



@interface ZWHCashcouponViewController ()<FDSlideContentViewDataSource>
@property(nonatomic,strong)FDSlideBar *sliderBar;
@property(nonatomic,strong)FDSlideContentView *contentView;
@end

@implementation ZWHCashcouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"代金券";
    self.view.backgroundColor = [UIColor whiteColor];
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
    //获取数目
    MJWeakSelf
    [HttpHandler getCoupon:@{@"para1":UniqUserID,@"para2":userType,@"para3":@"N"} start:@1 end:@10 querytype:@"0" Success:^(id obj) {
        //NSInteger abc = ReturnValue;
        NSLog(@"%ld",ReturnValue);
        NSString *str = obj[@"sysmodel"][@"strresult"];
        NSDictionary *strrDict = [HttpTool getArrayWithData:str][0];
        NSLog(@"%@\n%@",[HttpTool getArrayWithData:str],[HttpTool takeOffNullWithDict:strrDict]);
        NSString *nstr;
        NSString *ystr;
        NSString *vstr;
        if([[HttpTool getArrayWithData:str][0][@"N"] isEqual:[NSNull null]]){
            nstr = @"未使用(0)";
        }else{
            nstr = [NSString stringWithFormat:@"未使用(%@)",[HttpTool getArrayWithData:str][0][@"N"]];
        }
        
        if([[HttpTool getArrayWithData:str][0][@"Y"] isEqual:[NSNull null]]){
            ystr = @"已使用(0)";
        }else{
            ystr = [NSString stringWithFormat:@"已使用(%@)",[HttpTool getArrayWithData:str][0][@"Y"]];
        }
        
        if([[HttpTool getArrayWithData:str][0][@"V"] isEqual:[NSNull null]]){
            vstr = @"已过期(0)";
        }else{
            vstr = [NSString stringWithFormat:@"已过期(%@)",[HttpTool getArrayWithData:str][0][@"V"]];
        }
        _sliderBar.backgroundColor = [UIColor whiteColor];
        _sliderBar.itemWidth = ScreenWidth / 3;
        _sliderBar.itemColor = [UIColor blackColor];
        _sliderBar.itemsTitle = @[nstr,ystr,vstr];
        _sliderBar.itemSelectedColor = ZWHCOLOR(@"#4BA4FF");
        _sliderBar.sliderColor = ZWHCOLOR(@"#4BA4FF");
    } failed:^(id obj) {
    }];
    
    
    
    
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
    return 3;
}

//返回控制器
- (UIViewController *)slideContentView:(FDSlideContentView *)contentView viewControllerForIndex:(NSUInteger)index{
    ZWHCashListViewController *listVc = [[ZWHCashListViewController alloc]init];
    listVc.stateIndex = index;
    return listVc;
}


@end
