//
//  UserDefineController.m
//  FengHuaKe
//
//  Created by chenheng on 2019/6/28.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "UserDefineController.h"
#define NSLog(FORMAT, ...) fprintf(stderr, "%s:%zd\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String])
@interface UserDefineController ()

@end

@implementation UserDefineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSDictionary *dic = @{@"para1":UniqUserID,@"para2":@"U",@"para3":@"",@"para4":@""};
    [DataProcess requestDataWithURL:FolderLink_List RequestStr:GETRequestStr(nil, dic, @1, @100, nil) Result:^(id obj, id erro) {
        NSLog(@"结果===>%@",obj);
        NSLog(@"wwwwerro===>%@",erro);
        
    }];
    
//    UIView * topView = [[UIView alloc]init];
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
