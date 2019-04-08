//
//  ZWHProductStoreViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/9.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHProductStoreViewController.h"
#import "ZWHProductListCollectionViewCell.h"
#import "ZWHProductSearchViewController.h"
#import "ZWHProductListViewController.h"
#import "ZWHClassifyViewController.h"
#import "ZWHProductDetailViewController.h"
#import "UIViewController+NavBarHidden.h"
#import "ZWHNorSearchViewController.h"
#import "ZWHScanViewController.h"
#import "ZWHProductPagingViewController.h"

#import "ProductModel.h"
#import "CatageModel.h"
#import "ClassifyModel.h"
#import "ZWHAdvertModel.h"


@interface ZWHProductStoreViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger index;

@property(nonatomic,strong)SDCycleScrollView *topScrView;


@property(nonatomic,strong)NSMutableArray *topClassifyArr;
@property(nonatomic,strong)NSMutableArray *advertArr;



@end

@implementation ZWHProductStoreViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //[self setInViewWillAppear];
    if (_collectionView) {
        [self scrollViewDidScroll:_collectionView];
    }
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //[self setInViewWillDisappear];
}


-(UIImage *)navigationBarBackgroundImage{
    return [UIImage new];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self getClassify];
    
}

#pragma mark - 获取七大类
-(void)getClassify{
    [self showEmptyViewWithLoading];
    MJWeakSelf;
    [HttpHandler getClassifyList:@{@"para1":_code,@"intresult":@"7"} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        [weakSelf hideEmptyView];
        if (ReturnValue==1) {
            weakSelf.topClassifyArr = [ClassifyModel mj_objectArrayWithKeyValuesArray:obj[@"DataList"]];
            ClassifyModel *model = [[ClassifyModel alloc]init];
            model.name = @"全部";
            [weakSelf.topClassifyArr addObject:model];
            [self setUI];
            [self setRefresh];
            [self getAdSource];
        }else{
            [weakSelf showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(getClassify)];
        }
    } failed:^(id obj) {
        [weakSelf hideEmptyView];
        [weakSelf showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(getClassify)];
    }];
}

#pragma mark - 获得广告
-(void)getAdSource{
    MJWeakSelf;
    //轮播图广告
    [HttpHandler getSystemGetADInfo:@{@"para2":_adcode} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        if (ReturnValue == 1) {
            weakSelf.advertArr = [ZWHAdvertModel mj_objectArrayWithKeyValuesArray:obj[@"DataList"]];
            NSMutableArray *adArr = [NSMutableArray array];
            for (ZWHAdvertModel *model in weakSelf.advertArr) {
                [adArr addObject:[NSString stringWithFormat:@"%@%@",SERVER_IMG,model.PicAddress1]];
            }
            weakSelf.topScrView.imageURLStringsGroup = adArr;
        }
    } failed:^(id obj) {
        
    }];
}

#pragma mark - 网络请求
-(void)getDataSource{
    NSNumber *startIndex = [NSNumber numberWithInteger:_index];
    MJWeakSelf
    [HttpHandler getProductList:@{@"para1":_code} start:startIndex end:@10 querytype:@"0" Success:^(id obj) {
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
    [_collectionView.mj_header beginRefreshing];
    
    
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
    flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, HEIGHT_PRO(200)+HEIGHT_PRO(100));
    // 初始化集合视图
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    
    // 设置背景色
    _collectionView.backgroundColor = LINECOLOR;
    // 设置代理和数据源
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[ZWHProductListCollectionViewCell class] forCellWithReuseIdentifier:@"ZWHProductListCollectionViewCell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    //self.collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
    
    self.keyCollectionView = _collectionView;
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

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        header.backgroundColor = [UIColor clearColor];
        [header addSubview:self.topScrView];
        
        
        QMUIButton *searBtn = [[QMUIButton alloc]qmui_initWithImage:[UIImage imageNamed:@"search"] title:@"信息搜索"];
        [searBtn setTitleColor:[UIColor whiteColor] forState:0];
        searBtn.backgroundColor = [UIColor clearColor];
        searBtn.contentHorizontalAlignment = 1;
        searBtn.spacingBetweenImageAndTitle = WIDTH_PRO(8);
        [searBtn addTarget:self action:@selector(searchBtnWith:) forControlEvents:UIControlEventTouchUpInside];
        [searBtn sizeToFit];
        self.navigationItem.titleView = searBtn;
        
        QMUIGridView *topGridView = [[QMUIGridView alloc]initWithColumn:4 rowHeight:HEIGHT_PRO(50)];
        topGridView.separatorWidth = WIDTH_PRO(5);
        topGridView.separatorColor = [UIColor clearColor];
        
        for (NSInteger i=0; i<_topClassifyArr.count; i++) {
            UIView *backview = [[UIView alloc]init];
            [topGridView addSubview:backview];
            
            ClassifyModel *model = _topClassifyArr[i];
            QMUIButton *btn = [[QMUIButton alloc]init];
            [btn setTitleColor:[UIColor blackColor] forState:0];
            [btn setTitle:model.name forState:0];
            btn.layer.cornerRadius = 5;
            btn.layer.masksToBounds = YES;
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = [ZWHCOLOR(@"#AAAAAA") CGColor];
            btn.titleLabel.font = HTFont(26);
            btn.tag = i;
            [backview addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(backview);
                make.width.mas_equalTo(WIDTH_PRO(70));
                make.height.mas_equalTo(HEIGHT_PRO(30));
            }];
            [btn addTarget:self action:@selector(classifyWith:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [header addSubview:topGridView];
        [topGridView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(header);
            make.top.equalTo(_topScrView.mas_bottom);
            make.height.mas_equalTo(HEIGHT_PRO(100));
        }];
        
        return header;
    }else{
        return nil;
    }
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductModel *model = _dataArray[indexPath.item];
    
    ZWHProductDetailViewController *vc = [[ZWHProductDetailViewController alloc]init];
    vc.productNo = model.productno;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat minAlphaOffset = 0;//- 64;
    CGFloat maxAlphaOffset = 200;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
    //_barImageView.alpha = alpha;
    UIColor *color = [[UIColor alloc]initWithRed:75/255.0f green:164/255.0f blue:255/255.0f alpha:alpha];
    [self.navigationController.navigationBar setBackgroundImage:[DataProcess imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
}


-(void)backBtnWith:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

//搜索
-(void)searchBtnWith:(UIButton *)btn{
    //[self.navigationController popViewControllerAnimated:YES];
    ZWHNorSearchViewController *vc = [[ZWHNorSearchViewController alloc]init];
    vc.code = _code;
    vc.state = 0;
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark - 8大类
-(void)classifyWith:(UIButton *)btn{
    if (btn.tag < _topClassifyArr.count-1) {
        ClassifyModel *model = _topClassifyArr[btn.tag];
        [self showEmptyViewWithLoading];
        MJWeakSelf;
        [HttpHandler getClassifyList:@{@"para1":_code,@"para2":model.code} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
            [weakSelf hideEmptyView];
            if (ReturnValue==1) {
                NSArray *arr = obj[@"DataList"];
                if (arr.count > 0) {
                    NSArray *claArr = [ClassifyModel mj_objectArrayWithKeyValuesArray:arr];
                    ZWHProductPagingViewController *vc = [[ZWHProductPagingViewController alloc]init];
                    vc.code = weakSelf.code;
                    vc.classArr = claArr;
                    vc.title = model.name;
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                }else{
                    ZWHProductListViewController *vc = [[ZWHProductListViewController alloc]init];
                    vc.code = weakSelf.code;
                    vc.secode = model.code;
                    vc.title = model.name;
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                }
            }else{
            }
        } failed:^(id obj) {
            [weakSelf hideEmptyView];
        }];
    }else{
        ZWHClassifyViewController *vc = [[ZWHClassifyViewController alloc]init];
        vc.code = _code;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - getter

-(SDCycleScrollView *)topScrView{
    if (!_topScrView) {
        NSArray *array = @[[UIImage imageNamed:@"ceshi_3_1"]];
        _topScrView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(200)) delegate:self placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
        _topScrView.localizationImageNamesGroup = array;
        _topScrView.backgroundColor = [UIColor whiteColor];
        _topScrView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _topScrView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _topScrView.pageControlBottomOffset = 5;
        _topScrView.pageControlDotSize = CGSizeMake(WIDTH_PRO(7.5), HEIGHT_PRO(7));
        _topScrView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _topScrView.currentPageDotColor = MAINCOLOR;
        _topScrView.pageDotColor = [UIColor whiteColor];
        _topScrView.autoScroll = YES;
    }
    return _topScrView;
}


@end
