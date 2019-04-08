//
//  AllClassifyProductVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/22.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "AllClassifyProductVC.h"
#import "ChooseTableView.h"
#import "ClassifyProductCollectionView.h"
#import "ProductVM.h"
#import "ClassifyModel.h"
#import "ProductModel.h"
#import "ThirdClassifyVC.h"
#import "ZWHProductListViewController.h"

@interface AllClassifyProductVC ()<ChooseTableDeledate,ProductCollectionDeledate>
@property(nonatomic,strong)ChooseTableView *chooseTableView;
@property(nonatomic,strong)ClassifyProductCollectionView *classifyCollectionView;
@property(nonatomic,strong)NSMutableArray *classyArray;
@property(nonatomic,strong)NSMutableArray *nexttArray;
@end

@implementation AllClassifyProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"全部商品";
    [self.view addSubview:self.chooseTableView];
    [self.view addSubview:self.classifyCollectionView];
    [self getClassify];
}
#pragma mark - 懒加载
-(ChooseTableView*)chooseTableView
{
    if (!_chooseTableView) {
        _chooseTableView=[[ChooseTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth*0.25, ScreenHeight-64) Data:self.classyArray];
        _chooseTableView.chooseTableDeledate=self;
        
    }
    return _chooseTableView;
    
}
-(ClassifyProductCollectionView *)classifyCollectionView
{
    if (!_classifyCollectionView) {
        
        _classifyCollectionView=[[ClassifyProductCollectionView alloc]initWithFrame:CGRectMake(ScreenWidth*0.25, 0, ScreenWidth*0.75, ScreenHeight-64) Data:nil];
        _classifyCollectionView.backgroundColor=defaultColor1;
        _classifyCollectionView.productCollectionDeledate=self;
    }
    return _classifyCollectionView;
    
}
#pragma mark - net
-(void)getClassify
{
    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":@"013",@"intresul":@"0"}];
    [ProductVM ClassifyListSysmodel:sysmodel Success:^(id responseData) {
        
        self.classyArray=[ClassifyModel getDatawithdic:(NSDictionary*)responseData];
        self.chooseTableView.dataArray=self.classyArray;
    } Fail:^(id erro) {
        
    }];
}
-(void)getProductWithClassiy:(NSString*)classify
{

    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":@"013",@"para2":classify}];
    [ProductVM ClassifyListSysmodel:sysmodel Success:^(id responseData) {
        NSLog(@"responseData:%@",responseData);
        self.nexttArray=[ClassifyModel getDatawithdic:(NSDictionary*)responseData];
        self.classifyCollectionView.dataArray=self.nexttArray;
    } Fail:^(id erro) {
        
    }];
}

#pragma mark - choose product
-(void)didRow:(ChooseTableView *)chooseTableView Index:(NSInteger)index
{
    ClassifyModel *model=self.classyArray[index];
    [self getProductWithClassiy:model.code];
}
-(void)didItem:(ClassifyProductCollectionView *)classiCollectionView Index:(NSInteger)index
{
    NSLog(@"点击二级分类");
    ClassifyModel *model=self.nexttArray[index];
     ThirdClassifyVC *vc=[[ThirdClassifyVC alloc]init];
     vc.title=model.name;
     vc.classify=model.code;
     [self.navigationController pushViewController:vc animated:YES];
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
