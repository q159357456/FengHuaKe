//
//  ThirdClassifyVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/22.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ThirdClassifyVC.h"
#import "TopScroView.h"
#import "ProductVM.h"
#import "ClassifyModel.h"
#import "ProductModel.h"
#import "ProductCollectionViewCell.h"
#import "ProductDetailVC.h"
#define RMB @"¥"
@interface ThirdClassifyVC ()<UICollectionViewDelegate,UICollectionViewDataSource,TopScroDelegate>
@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,copy)NSString *productClassify;
@end

@implementation ThirdClassifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self getThirdtWithClassiy:self.classify];
    // Do any additional setup after loading the view.
}
#pragma mark - 懒加载

#pragma mark -UI
-(void)setUI
{
    if (self.array.count) {
        TopScroView *top=[[TopScroView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40) Data:self.array];
        top.topScroDelegate=self;
        TopScroButton *button=(TopScroButton*)[top viewWithTag:1];
        [top buttClick:button];
        [self.view addSubview:top];
         UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0,45, ScreenWidth, ScreenHeight-64-45) collectionViewLayout:layout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.showsVerticalScrollIndicator=NO;
        _collectionView.showsHorizontalScrollIndicator=NO;
        _collectionView.mj_footer=self.footer;
        _collectionView.mj_header=self.header;
        _collectionView.backgroundColor=defaultColor1;
        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:@"ProductCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ProductCollectionViewCell"];
        [self.view addSubview:_collectionView];
    }else
    {
          UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) collectionViewLayout:layout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.showsVerticalScrollIndicator=NO;
        _collectionView.showsHorizontalScrollIndicator=NO;
        _collectionView.mj_footer=self.footer;
        _collectionView.mj_header=self.header;
        _collectionView.backgroundColor=defaultColor1;
        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:@"ProductCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ProductCollectionViewCell"];
        [self.view addSubview:_collectionView];
    }

    
}
#pragma mark - TopScroDelegate
-(void)touchTag:(TopScroView *)topScroView index:(NSInteger)index
{
    NSLog(@"touch %ld",index);
    ClassifyModel *model=self.array[index-1];
    self.productClassify=model.code;
    [self.dataArray removeAllObjects];
    [self getProductListClassiy:model.code];
    
}
#pragma mark - net
//获得三级分类
-(void)getThirdtWithClassiy:(NSString*)classify
{
    
    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":@"013",@"para2":classify}];
    DefineWeakSelf;
    [ProductVM ClassifyListSysmodel:sysmodel Success:^(id responseData) {
        NSLog(@"responseData:%@",responseData);
       weakSelf.array=[ClassifyModel getDatawithdic:(NSDictionary*)responseData];
       [weakSelf setUI];
        if (!weakSelf.array.count) {
            weakSelf.productClassify=weakSelf.classify;
            [weakSelf getProductListClassiy:weakSelf.classify];
        }
        
    } Fail:^(id erro) {
        
    }];
}
//获得产品列表
-(void)getProductListClassiy:(NSString*)classify
{
    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":@"013"}];
    NSString *start=[NSString stringWithFormat:@"%ld",self.startIndex];
    NSString *end=[NSString stringWithFormat:@"%ld",self.endIndex];
    DefineWeakSelf;
    [ProductVM ProductListSysmodel:sysmodel Startindex:start Endindex:end Success:^(id responseData) {
        NSArray *result=[ProductModel getDatawithdic:(NSDictionary*)responseData];
        [weakSelf.dataArray addObjectsFromArray:result];
        [weakSelf EndFreshWithArray:result];
        [weakSelf.collectionView reloadData];
    } Fail:^(id erro) {
        
    }];
}
#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    ProductModel *model=self.dataArray[indexPath.row];
    [cell.productImage sd_setImageWithURL:[NSURL URLWithString:[DataProcess PicAdress:model.url]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
    cell.lable1.text=[NSString stringWithFormat:@"%@",model.proname];
    cell.lable2.text=[NSString stringWithFormat:@"%@%@",RMB,model.saleprice];
    return cell;
}

#pragma mark -UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth-30)/2, (ScreenWidth-30)/2+60);
}
//设置section的上左下右边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //上  左   下  右
    
    
    return UIEdgeInsetsMake(10,10,10,10);
    
    
}
// 两个cell之间的最小间距，是由API自动计算的，只有当间距小于该值时，cell会进行换行
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 1;
    
}
// 两行之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    
    return 10;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductModel *model=self.dataArray[indexPath.row];
    ProductDetailVC *vc=[[ProductDetailVC alloc]init];
    vc.productNo=model.productno;
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark -  fresh
-(void)headerFresh
{
    [self getProductListClassiy:self.productClassify];
}
-(void)footFresh
{
    [self getProductListClassiy:self.productClassify];
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
