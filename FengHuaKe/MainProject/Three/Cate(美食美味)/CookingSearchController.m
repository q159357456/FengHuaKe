//
//  CookingSearchController.m
//  FengHuaKe
//
//  Created by 秦根 on 2019/7/16.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "CookingSearchController.h"

@interface CookingSearchController ()<UISearchBarDelegate>
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)QMUIButton  *cityB;
@end

@implementation CookingSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
/**
 * 设置导航栏
 */
-(void)setNavigatController{
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, WIDTH_PRO(260), 30)];
    if (@available(iOS 11.0, *)) {
        [[_searchBar.heightAnchor constraintEqualToConstant:44] setActive:YES];
    }
    _searchBar.placeholder = @"信息搜索";
    _searchBar.qmui_placeholderColor = [UIColor blackColor];
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchBar.delegate = self;
    UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
    [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    searchField.textColor = [UIColor whiteColor];
    [_searchBar setImage:[UIImage imageNamed:@"search"] forSearchBarIcon:UISearchBarIconSearch state:0];
    self.navigationItem.titleView = _searchBar;
    
    _cityB = [[QMUIButton alloc]init];
    [_cityB setTitleColor:[UIColor whiteColor] forState:0];
    //    [_cityB setTitle:[userCity stringByReplacingOccurrencesOfString:@"市" withString:@""] forState:0];
    [_cityB setTitle:@"东莞" forState:0];
    [_cityB setImage:[UIImage imageNamed:@"groupdown"] forState:0];
    [_cityB setImagePosition:QMUIButtonImagePositionRight];
    [_cityB setTintColorAdjustsTitleAndImage:[UIColor whiteColor]];
    _cityB.titleLabel.font = HTFont(28);
    [_cityB sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_cityB];
    [_cityB addTarget:self action:@selector(choosecity) forControlEvents:UIControlEventTouchUpInside];
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
