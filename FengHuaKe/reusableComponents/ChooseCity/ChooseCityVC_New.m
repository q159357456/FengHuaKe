//
//  ChooseCityVC_New.m
//  ZHONGHUILAOWU
//
//  Created by 秦根 on 2018/7/15.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ChooseCityVC_New.h"
#import "HotCityCollectionView.h"
#import "AllCityTableView.h"
#import "AreaModel.h"
@interface ChooseCityVC_New ()<UISearchBarDelegate>
@property(nonatomic,strong)HotCityCollectionView *hotCityCollectionView;
@property(nonatomic,strong)AllCityTableView *allCityTableView;
@property(nonatomic,strong)UISearchBar *searchBar;
@end

@implementation ChooseCityVC_New
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"城市选择";
//    self.navigationItem.titleView = self.searchBar;
    self.allCityTableView = [[AllCityTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.3, SCREEN_HEIGHT - NavigationContentTopConstant)];
    UICollectionViewFlowLayout *layoutout=[[UICollectionViewFlowLayout alloc]init] ;
    self.hotCityCollectionView= [[HotCityCollectionView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.allCityTableView.frame), 0, SCREEN_WIDTH * 0.7, SCREEN_HEIGHT - NavigationContentTopConstant) collectionViewLayout:layoutout];
    [self.view addSubview:self.allCityTableView];
    [self.view addSubview:self.hotCityCollectionView];
    // Do any additional setup after loading the view.
}
-(void)FunEventName:(NSString *)eventName Para:(id)para
{
    if ([eventName isEqualToString:@"chooseprovince"]) {
        AreaModel *model =(AreaModel*)para;
        self.hotCityCollectionView.headLable.text=model.name;
        [self.hotCityCollectionView getCityDataWithProcode:model.code];
        
    }else if([eventName isEqualToString:@"chooseCity"])
    {
        
         AreaModel *model = (AreaModel*)para;
        if (self.backBlock) {
            self.backBlock(model.code, model.name);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else
    {
        return;
    }
}
-(UISearchBar *)searchBar
{
    if (!_searchBar) {
        
        _searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        _searchBar.placeholder=@"输入城市名称";
        _searchBar.returnKeyType = UIReturnKeySearch;
        _searchBar.delegate = self;
    }
    return _searchBar;
}
#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
{
   [searchBar resignFirstResponder];
    [self searchResult:searchBar.text];
}

-(void)searchResult:(NSString*)keyWord
{
    //SString *dt=[NSString stringWithFormat:@"A.shopname$LIKE$%%%@%%",gSHOPID];
//    NSString *condition = [NSString stringWithFormat:@"cityname$LIKE$%%%@%%",keyWord];
//    NSDictionary *dic=@{@"FromTableName":@"CMS_City",@"SelectField":@"*",@"Condition":condition,@"SelectOrderBy":@"",@"CipherText":CIPHERTEXT};
//    NSLog(@"%@",dic);
//    [[NetDataTool shareInstance]getNetData:PAPATH url:@"/SystemCommService.asmx/GetCommSelectDataInfo3" With:dic and:^(id responseObject) {
//        NSDictionary *dic1=[JsonTools getData:responseObject];
//        self.hotCityCollectionView.data =[RegionModel getDataWithDic:dic1 withStr:@"City"];
//        if (!self.hotCityCollectionView.data.count) {
//            self.hotCityCollectionView.headLable.text =@"没有搜索到相关结果";
//        }else
//        {
//            self.hotCityCollectionView.headLable.text =@"查询结果";
//        }
//
//    } Faile:^(NSError *error) {
//        NSLog(@"失败%@",error);
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
