//
//  CaseDetailController.m
//  FengHuaKe
//
//  Created by chenheng on 2019/7/12.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "CaseDetailController.h"

@interface CaseDetailController ()

@end

@implementation CaseDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSDictionary * param1 =  @{@"para2":@"B001",@"para1":self.code?self.code:@"",@"para3":@""};
    DefineWeakSelf;
    [DataProcess requestDataWithURL:Case_Single RequestStr:GETRequestStr(nil,param1, nil, nil, nil) Result:^(id obj, id erro) {
        
        NSLog(@"obj===>%@",obj);
        if (obj[@"DataList"]) {
            [weakSelf.webview loadHTMLString:obj[@"DataList"][0][@"content"] baseURL:nil];
        }
       
        
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
