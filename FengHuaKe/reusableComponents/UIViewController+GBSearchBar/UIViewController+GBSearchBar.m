//
//  UIViewController+GBSearchBar.m
//  FengHuaKe
//
//  Created by chenheng on 2019/4/24.
//  Copyright © 2019年 gongbo. All rights reserved.
//

#import "UIViewController+GBSearchBar.h"
static NSString *GBSearchBarKey = @"GBSearchBarKey";
static NSString *GBTableviewKey = @"GBTableviewKey";
@implementation UIViewController (GBSearchBar)

-(void)setsearchbar{
    
    //搜索栏
    self.searchBar = [[ZWHSearchBar alloc]initWithFrame:CGRectMake(0, 0, WIDTH_PRO(260), 30)];
    self.navigationItem.titleView = self.searchBar;
    self.searchBar.placeholder = @"请输入搜索内容";
    self.searchBar.layer.borderColor = LINECOLOR.CGColor;
    self.searchBar.layer.borderWidth = 0.8f;
//    self.searchBar.delegate = self;
//    QMUIButton *cancel = [[QMUIButton alloc]init];
//    [cancel setTitle:@"取消" forState:0];
//    [cancel setTitleColor:[UIColor whiteColor] forState:0];
//    cancel.titleLabel.font = HTFont(30);
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cancel];
//    [cancel addTarget:self action:@selector(cancelWith:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)setSearchBar:(ZWHSearchBar *)searchBar
{
    objc_setAssociatedObject(self, &GBSearchBarKey, searchBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(ZWHSearchBar *)searchBar
{
    return objc_getAssociatedObject(self,&GBSearchBarKey);
}

@end
