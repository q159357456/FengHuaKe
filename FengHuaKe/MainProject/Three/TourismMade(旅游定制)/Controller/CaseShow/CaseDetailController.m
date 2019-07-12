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
    NSDictionary * param1 =  @{@"para1":@"B001",@"para2":self.code?self.code:@"",@"para3":@""};
    DefineWeakSelf;
    [DataProcess requestDataWithURL:Case_Single RequestStr:GETRequestStr(nil, nil, @1, @100, nil) Result:^(id obj, id erro) {
        
        [weakSelf.blogArr  addObjectsFromArray:[BlogsModel mj_objectArrayWithKeyValuesArray:obj[@"DataList"]]];
        [weakSelf.tableView reloadData];
        
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
