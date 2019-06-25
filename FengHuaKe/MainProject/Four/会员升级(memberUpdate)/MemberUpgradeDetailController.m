//
//  MemberUpgradeDetailController.m
//  FengHuaKe
//
//  Created by chenheng on 2019/6/25.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "MemberUpgradeDetailController.h"

@interface MemberUpgradeDetailController ()

@end

@implementation MemberUpgradeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubViews];
    // Do any additional setup after loading the view.
}
-(void)initSubViews{
    UIView * topview = [[UIView alloc]init];
    UIView * middleView = [[UIView alloc]init];
    UIView * bottomView = [[UIView alloc]init];
    
    topview.backgroundColor = [UIColor whiteColor];
    middleView.backgroundColor = [UIColor whiteColor];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    topview.frame = CGRectMake(0, 0, ScreenWidth, 100*MULPITLE);
    middleView.frame = CGRectMake(0, CGRectGetMaxY(topview.frame), ScreenWidth, 93*MULPITLE);
    bottomView.frame = CGRectMake(0, CGRectGetMaxY(middleView.frame)+10, ScreenWidth, self.view.height-93*MULPITLE-100*MULPITLE);
    UIButton * topUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    topUpBtn.backgroundColor = MainColor;
    [topUpBtn setTitle:@"充值" forState:UIControlStateNormal];
    
    [self.view addSubview:topUpBtn];
    [self.view addSubview:topview];
    [self.view addSubview:middleView];
    [self.view addSubview:bottomView];
    
    UILabel * label = [[UILabel alloc]init];
    label.text = @"套餐详情";
    label.qmui_borderColor = [UIColor lightGrayColor];
    label.qmui_borderWidth = 1;
    label.qmui_borderPosition = QMUIViewBorderPositionBottom;
    label.frame = CGRectMake(0, 0, ScreenWidth,  50*MULPITLE);
    [bottomView addSubview:label];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
