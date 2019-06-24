//
//  MemberUpgradeController.m
//  FengHuaKe
//
//  Created by chenheng on 2019/6/24.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "MemberUpgradeController.h"
#define NSLog(FORMAT, ...) fprintf(stderr, "%s:%zd\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String])
@interface MemberUpgradeController ()

@end

@implementation MemberUpgradeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSDictionary *dic = @{@"para1":UniqUserID,@"para2":MEMBERTYPE};
    [DataProcess requestDataWithURL:MemberLevel_Current RequestStr:GETRequestStr(nil, dic, nil,nil, nil) Result:^(id obj, id erro) {
        NSLog(@"结果===>%@",obj);
        NSLog(@"erro===>%@",erro);
    }];
    
    
    // Do any additional setup after loading the view.
}
-(void)initSubViews{
    UIView * topview = [[UIView alloc]init];
    UIImageView * middleView = [[UIImageView alloc]init];
    UIView * bottomView = [[UIView alloc]init];
    [self.view addSubview:topview];
    [self.view addSubview:middleView];
    [self.view addSubview:bottomView];
    
    [topview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo(100*MULPITLE);
    }];
    
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(topview.mas_bottom).offset(10);
        make.left.mas_equalTo(self).offset(10);
        make.right.mas_equalTo(self).offset(-10);
        make.height.mas_equalTo(93*MULPITLE);
        
    }];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        
    }];
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
