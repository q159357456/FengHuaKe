//
//  MemberUpgradeDetailController.m
//  FengHuaKe
//
//  Created by chenheng on 2019/6/25.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "MemberUpgradeDetailController.h"
#import "MemberUpgradeTopUpController.h"
@interface MemberUpgradeDetailController ()

@end

@implementation MemberUpgradeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
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
    topview.frame = CGRectMake(0, 0, ScreenWidth, 120*MULPITLE);
    middleView.frame = CGRectMake(0, CGRectGetMaxY(topview.frame), ScreenWidth, 70*MULPITLE);
    bottomView.frame = CGRectMake(0, CGRectGetMaxY(middleView.frame)+10, ScreenWidth, self.view.height-70*MULPITLE-120*MULPITLE - 50*MULPITLE-10);

    
  
    [self.view addSubview:topview];
    [self.view addSubview:middleView];
    [self.view addSubview:bottomView];
    
    UIButton * topUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:topUpBtn];
    [topUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(50*MULPITLE);
    }];
    topUpBtn.backgroundColor = MainColor;
    [topUpBtn setTitle:@"充值" forState:UIControlStateNormal];
    [topUpBtn addTarget:self action:@selector(topUp) forControlEvents:UIControlEventTouchUpInside];

    UIImageView * imageView = [[UIImageView alloc]init];
    [topview addSubview:imageView];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"memberUpgrade_%ld",self.index+1]];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    UILabel * label1 = [[UILabel alloc]init];
    UILabel * label2 = [[UILabel alloc]init];
    UILabel * label3 = [[UILabel alloc]init];
    label2.textAlignment = NSTextAlignmentRight;
    [middleView addSubview:label1];
    [middleView addSubview:label2];
    [middleView addSubview:label3];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(middleView).offset(14*MULPITLE);
        make.top.mas_equalTo(middleView).offset(10*MULPITLE);
        make.size.mas_equalTo(CGSizeMake(150*MULPITLE, 24*MULPITLE));
    }];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(middleView).offset(-14*MULPITLE);
        make.top.mas_equalTo(middleView).offset(10*MULPITLE);
        make.size.mas_equalTo(CGSizeMake(150*MULPITLE, 24*MULPITLE));
    }];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(middleView).offset(14*MULPITLE);
        make.top.mas_equalTo(label1.mas_bottom).offset(10*MULPITLE);
        make.size.mas_equalTo(CGSizeMake(150*MULPITLE, 24*MULPITLE));
    }];
    label1.font = ZWHFont(14*MULPITLE);
    label2.font = ZWHFont(14*MULPITLE);
    label1.text = [NSString stringWithFormat:@"%@礼包",self.model.MG002];
    label2.text = [NSString stringWithFormat:@"代理费%@/年",self.model.MG007];
    
    UILabel * label = [[UILabel alloc]init];
    label.text = @"  套餐详情";
    label.qmui_borderColor = [UIColor lightGrayColor];
    label.qmui_borderWidth = 1;
    label.qmui_borderPosition = QMUIViewBorderPositionBottom;
    label.frame = CGRectMake(0, 0, ScreenWidth,  50*MULPITLE);
    [bottomView addSubview:label];
    
    UITextView * textView = [[UITextView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), ScreenWidth, bottomView.height-label.height)];
    self.model.MG021 = [self.model.MG021 stringByReplacingOccurrencesOfString:@"\\n" withString:@"\r\n"];
    textView.text = self.model.MG021;
    [bottomView addSubview:textView];

    
}
-(void)topUp{
    MemberUpgradeTopUpController * vc = [[MemberUpgradeTopUpController alloc]init];
    vc.value = [self.model.MG007 floatValue];
    [self.navigationController pushViewController:vc animated:YES];
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
