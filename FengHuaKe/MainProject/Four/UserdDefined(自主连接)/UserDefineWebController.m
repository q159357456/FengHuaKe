//
//  UserDefineWebController.m
//  FengHuaKe
//
//  Created by 秦根 on 2019/6/29.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "UserDefineWebController.h"

@interface UserDefineWebController ()

@end

@implementation UserDefineWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    // Do any additional setup after loading the view.
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
