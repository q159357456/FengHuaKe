//
//  AboutUsViewController.m
//  FengHuaKe
//
//  Created by chenheng on 2019/6/28.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"关于我们";
    UILabel *label  = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, ScreenWidth/2, 50*MULPITLE)];
    label.qmui_borderColor = [UIColor groupTableViewBackgroundColor];
    label.qmui_borderWidth = 1;
    label.qmui_borderPosition = QMUIViewBorderPositionBottom;
    label.text = @"软件版本";
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    UILabel *label1  = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2,0, ScreenWidth/2-20, 50*MULPITLE)];
    label1.qmui_borderColor = [UIColor groupTableViewBackgroundColor];
    label1.qmui_borderWidth = 1;
    label1.qmui_borderPosition = QMUIViewBorderPositionBottom;
    label1.text = app_Version;
    label1.textColor = [UIColor lightGrayColor];
    label1.textAlignment = NSTextAlignmentRight;
    
    [self.view addSubview:label];
    [self.view addSubview:label1];
    
    
    UIButton * topUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:topUpBtn];
    [topUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250, 50*MULPITLE));
        make.bottom.mas_equalTo(self.view).offset(-50);
        make.centerX.mas_equalTo(self.view);
        
    }];
    topUpBtn.backgroundColor = MainColor;
    [topUpBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [topUpBtn addTarget:self action:@selector(loginout) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}
-(void)loginout{
    EMError *error = [[EMClient sharedClient] logout:YES];
    if (!error) {
        NSLog(@"退出成功");
        [QMUITips showInfo:@"登录已过期，请重新登录"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [userDefault removeObjectForKey:@"token"];
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:nil userInfo:nil];
        });
        
    }
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
