//
//  ZWHProductSearchViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/11.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHProductSearchViewController.h"

#import "ZWHProductListCollectionViewCell.h"

#import "ProductModel.h"

#import "ZWHProductDetailViewController.h"

@interface ZWHProductSearchViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger index;




@end

@implementation ZWHProductSearchViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索结果";
    
    [self setUI];
    [self setRefresh];
}

#pragma mark - 网络请求
-(void)getDataSource{
    NSNumber *startIndex = [NSNumber numberWithInteger:_index];
    if (_name.length==0) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        return;
    }
    MJWeakSelf
    [HttpHandler getProductList:@{@"para1":_code,@"para3":_name} start:startIndex end:@10 querytype:@"0" Success:^(id obj) {
        NSLog(@"%@",obj);
        if (ReturnValue == 1) {
            NSArray *ary = obj[@"DataList"];
            if (ary.count == 0) {
                [weakSelf.collectionView.mj_header endRefreshing];
                [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [weakSelf.dataArray addObjectsFromArray: [ProductModel mj_objectArrayWithKeyValuesArray:ary]];
                [weakSelf.collectionView.mj_header endRefreshing];
                [weakSelf.collectionView.mj_footer endRefreshing];
            }
            [weakSelf.collectionView reloadData];
            if (weakSelf.dataArray.count==0) {
                weakSelf.collectionView.mj_header.hidden = YES;
                weakSelf.collectionView.mj_footer.hidden = YES;
                [weakSelf showEmptyViewWithImage:[UIImage imageNamed:@"nodata"] text:@"" detailText:@"" buttonTitle:@"" buttonAction:nil];
                weakSelf.collectionView.backgroundColor = [UIColor whiteColor];
                //weakSelf.emptyView.backgroundColor = [UIColor whiteColor];
            }
        }
    } failed:^(id obj) {
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
}

-(void)setRefresh{
    MJWeakSelf
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.dataArray = [NSMutableArray array];
        weakSelf.index = 1;
        [weakSelf getDataSource];
    }];
    _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.index ++ ;
        [weakSelf getDataSource];
    }];
    //[_collectionView.mj_header beginRefreshing];
    [self getDataSource];
    
    
}


-(void)setUI{
    
    _dataArray = [NSMutableArray array];
    _index = 1;
    
    // 初始化一个布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset =UIEdgeInsetsMake(0,0,0, 0);
    
    // 设置最小行距
    flowLayout.minimumLineSpacing = HEIGHT_PRO(8);
    // 设置最小间距
    flowLayout.minimumInteritemSpacing = WIDTH_PRO(8);
    // 设置格子大小
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/4, HEIGHT_PRO(215));
    // 设置组边界
    flowLayout.sectionInset = UIEdgeInsetsMake(WIDTH_PRO(8), WIDTH_PRO(8), WIDTH_PRO(8), WIDTH_PRO(8));
    //flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, self.searchController.searchBar.frame.size.height);
    //flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH,HEIGHT_PRO(80));
    // 初始化集合视图
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    
    // 设置背景色
    _collectionView.backgroundColor = LINECOLOR;
    // 设置代理和数据源
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.collectionView registerClass:[ZWHProductListCollectionViewCell class] forCellWithReuseIdentifier:@"ZWHProductListCollectionViewCell"];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
}




#pragma mark - uicollectView

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH-WIDTH_PRO(24))/2,HEIGHT_PRO(220));
}

// 返回多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 每组返回多少个格子
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZWHProductListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZWHProductListCollectionViewCell" forIndexPath:indexPath];
    if (_dataArray.count>0) {
        cell.model = _dataArray[indexPath.row];
    }
    return cell;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductModel *model = _dataArray[indexPath.item];
    
    ZWHProductDetailViewController *vc = [[ZWHProductDetailViewController alloc]init];
    vc.productNo = model.productno;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
