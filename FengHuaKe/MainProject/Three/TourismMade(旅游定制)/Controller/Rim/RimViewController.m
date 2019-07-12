//
//  RimViewController.m
//  FengHuaKe
//
//  Created by chenheng on 2019/7/12.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "RimViewController.h"

@interface RimViewController ()

@end

@implementation RimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    DefineWeakSelf;
    NSDictionary * param = @{@"para1":@"014",@"para2":@"",@"para3":@"Mshop"};
    [DataProcess requestDataWithURL:Case_CustomerService RequestStr:GETRequestStr(nil, param, @1, @100, nil) Result:^(id obj, id erro) {
            NSLog(@"obj===>%@",obj);
   
    }];
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
