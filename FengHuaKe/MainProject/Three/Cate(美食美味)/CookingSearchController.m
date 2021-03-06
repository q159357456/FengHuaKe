//
//  CookingSearchController.m
//  FengHuaKe
//
//  Created by 秦根 on 2019/7/16.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "CookingSearchController.h"
#import "ChooseCityVC_New.h"
#import "FilterView.h"
@interface CookingSearchController ()<UISearchBarDelegate>
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)QMUIButton  *cityB;
@end

@implementation CookingSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigatController];
    NSArray *array=@[@"位置区域",@"智能排序",@"筛选"];
    FilterView * filter = [[FilterView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 44*MULPITLE) Titles:array];
    [self.view addSubview:filter];
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
-(void)choosecity{
    
    ChooseCityVC_New *vc = [[ChooseCityVC_New alloc]init];
    vc.backBlock = ^(NSString *code, NSString *name) {
        [_cityB setTitle:name forState:0];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- UISearchBarDelegate
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    // 获得需要进行搜索的关键字, 此种方式获取的词汇：比如拼音输入beijing时，获取的是bei jing
    //      self.currentSearchText = [[searchBar.text stringByReplacingCharactersInRange:range withString:text] mutableCopy];
    
    // 项目中使用的这个，此种方式获取的是用户输入的拼音，比如beijing，就是beijing
    // range代表用户输入的字符长度, text是用户输入的字符
//    if (!range.length) {
//        // 给当前搜索的字符串拼接字符
//        [self.currentSearchText appendFormat:@"%@", text];
//    } else {
//        // 表示用户删除了一个字符,删除当前搜索字符串最后一个字符
//        [self.currentSearchText  deleteCharactersInRange:NSMakeRange(self.currentSearchText.length-1,1)]; //
//        
//    }
    
    //  手动调用一次此方法开始搜索，因为项目中发送服务器请求的方法在这里面处理的
//    [self searchBar:searchBar textDidChange:self.currentSearchText];
    
    
    //[UISearchBar placeholderHidden:searchBar Text:text Editor:YES];
    
    return YES;
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
