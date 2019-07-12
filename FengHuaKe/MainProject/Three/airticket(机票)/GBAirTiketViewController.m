//
//  GBAirTiketViewController.m
//  FengHuaKe
//
//  Created by chenheng on 2019/4/9.
//  Copyright © 2019年 gongbo. All rights reserved.
//

#import "GBAirTiketViewController.h"

@interface GBAirTiketViewController ()

@end

@implementation GBAirTiketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    [self setTop];
    NSLog(@"ididiid ==> %@",UniqUserID);
    if ([UniqUserID isEqualToString:@"0000000003"]) {
        UIImageView * imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nodata"]];
//        imageview.frame = self.webview.frame;
        [self.view addSubview:imageview];
        [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.mas_equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(80*MULPITLE, 80*MULPITLE));
        }];
    }else
    {
          [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://b2b.meiya.com/content/dist/html/guest-index.html"]]];
    }
  
  
    // Do any additional setup after loading the view.
}
-(void)setTop{
    
    UIView *top = [[UIView alloc]init];
    top.backgroundColor = MAINCOLOR;
    top.frame = CGRectMake(0, 0, SCREEN_WIDTH, NavigationContentTopConstant);
    [self.view addSubview:top];
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"机票";
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.text = @"账号:Opxiaoyin";
    UILabel *label3 = [[UILabel alloc]init];
    label3.text = @"密码:Op22010355";
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [top addSubview:label1];
    [top addSubview:label2];
    [top addSubview:label3];
    [top addSubview:btn];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(top);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label1.mas_right);
        make.size.mas_equalTo(CGSizeMake(120*MULPITLE, 17));
        make.bottom.mas_equalTo(top.mas_centerY);
    }];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label1.mas_right);
        make.size.mas_equalTo(CGSizeMake(120*MULPITLE, 17));
        make.top.mas_equalTo(top.mas_centerY);
    }];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(top.mas_centerY).offset(8);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.left.mas_equalTo(top.mas_left).offset(15);
    }];
    
    label1.textColor = UIColorWhite;
    label2.textColor = UIColorWhite;
    label3.textColor = UIColorWhite;
    
    label2.font = ZWHFont(12);
    label3.font = ZWHFont(12);
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
