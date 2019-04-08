//
//  ProductViewController.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ProductViewController.h"
#import "ProductVM.h"
#import "ProductCollectionViewCell.h"
#import "ProductModel.h"
#import "ProductDetailVC.h"
#import "AllClassifyProductVC.h"
#import "ClassifyModel.h"

#define RMB @"¥"
@interface ProductViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *classifyArry;
@property(nonatomic,strong)UIView *topView;
@end

@implementation ProductViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"旅游用品";
    [self.view addSubview:self.collectionView];
    [self getProductList];
    [self getSvenClasses];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - 懒加载
-(NSMutableArray *)classifyArry
{
    if (!_classifyArry) {
        _classifyArry=[NSMutableArray array];
    }
    return _classifyArry;
}
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
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
       
    }
    return _collectionView;
}
-(UIView *)topView
{
    if (!_topView) {
        _topView=[[UIView alloc]initWithFrame:CGRectMake(10,10, ScreenWidth-20, 80)];
//        _topView.backgroundColor=[UIColor redColor];
        NSInteger count=0;
        CGFloat margin=10;
        for (NSInteger i=0; i<2; i++) {
            for (NSInteger j=0; j<4; j++) {
                CGFloat w=_topView.width;
                CGFloat h=_topView.height;
                
                CGFloat bw=(w-margin*3)/4;
                CGFloat bh=(h-margin*3)/2;
                CGFloat x=j*(bw+margin);
                CGFloat y=i*(bh+margin) +margin;
               
                ClassifyModel *model=self.classifyArry[count];
                UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame=CGRectMake(x, y, bw, bh);
                [btn setTitle:model.name forState:0];
                [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
                [btn setTitleColor:[UIColor blackColor] forState:0];
                btn.titleLabel.font = [UIFont systemFontOfSize:13];
                btn.layer.cornerRadius = 8;
                btn.layer.borderColor = [UIColor clearColor].CGColor;
                btn.layer.borderWidth = 0;
                [btn.layer setMasksToBounds:YES];
                [_topView addSubview:btn];
                count++;
                btn.tag = count;
                [btn addTarget:self action:@selector(touchbtnClick:) forControlEvents:UIControlEventTouchUpInside];
                
                
            }
        }
        
    }
    return _topView;
}
#pragma mark - action
-(void)touchbtnClick:(UIButton*)butt
{
    switch (butt.tag) {
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            
        }
            break;
        case 5:
        {
            
        }
            break;
        case 6:
        {
            
        }
            break;
        case 7:
        {
            
        }
            break;
        case 8:
        {
            AllClassifyProductVC *vc=[[AllClassifyProductVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;

    }
    
}

#pragma mark private
-(void)headerFresh
{
    [self getProductList];
}
-(void)footFresh
{
    [self getProductList];
}

#pragma mark - net
//商品列表
-(void)getProductList
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
//7个分类
-(void)getSvenClasses
{
    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":@"013",@"intresult":@"7"}];
    [ProductVM ClassifyListSysmodel:sysmodel Success:^(id responseData) {
            NSLog(@"responseData:%@",responseData);
        self.classifyArry=[ClassifyModel getDatawithdic:(NSDictionary*)responseData];
        ClassifyModel *model=[[ClassifyModel alloc]init];
        model.name=@"全部";
        [self.classifyArry addObject:model];
         [self.collectionView addSubview:self.topView];
    
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
    
    
    return UIEdgeInsetsMake(100,10,10,10);
    
    
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
