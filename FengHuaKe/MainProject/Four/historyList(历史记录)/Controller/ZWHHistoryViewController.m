//
//  ZWHHistoryViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/6.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHHistoryViewController.h"
#import "ZWHHistoryCollectionViewCell.h"
#import "ZWHCollectModel.h"
#import "ZWHProductDetailViewController.h"

@interface ZWHHistoryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger index;

@end

@implementation ZWHHistoryViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"历史记录";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    [self setRefresh];
}

-(void)setUI{
    
    _dataArray = [NSMutableArray array];
    _index = 1;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"清空" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    [btn addTarget:self action:@selector(cleanCollectWith:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    
    // 初始化一个布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset =UIEdgeInsetsMake(0,0,0, 0);
    
    // 设置最小行距
    flowLayout.minimumLineSpacing = HEIGHT_PRO(8);
    // 设置最小间距
    flowLayout.minimumInteritemSpacing = WIDTH_PRO(0);
    // 设置格子大小
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/4, HEIGHT_PRO(215));
    // 设置组边界
    flowLayout.sectionInset = UIEdgeInsetsMake(WIDTH_PRO(8), WIDTH_PRO(8), 0, WIDTH_PRO(8));
    //flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, HEIGHT_PRO(40));
    // 初始化集合视图
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    
    // 设置背景色
    _collectionView.backgroundColor = ZWHCOLOR(@"#F9F9F9");
    // 设置代理和数据源
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.collectionView registerClass:[ZWHHistoryCollectionViewCell class] forCellWithReuseIdentifier:@"ZWHHistoryCollectionViewCell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
    
    //创建长按手势监听
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(myHandleTableviewCellLongPressed:)];
    longPress.minimumPressDuration = 1.0;
    //将长按手势添加到需要实现长按操作的视图里
    [self.collectionView addGestureRecognizer:longPress];
}

#pragma mark - 网络请求
-(void)getDataSource{
    NSNumber *startIndex = [NSNumber numberWithInteger:_index];
    MJWeakSelf
    [HttpHandler getBrowseProductList:@{@"para1":UniqUserID,@"para2":userType} start:startIndex end:@10 querytype:@"0" Success:^(id obj) {
        NSLog(@"%@",obj);
        if (ReturnValue == 1) {
            NSArray *ary = obj[@"DataList"];
            if (ary.count == 0) {
                [weakSelf.collectionView.mj_header endRefreshing];
                [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [weakSelf.dataArray addObjectsFromArray: [ZWHCollectModel mj_objectArrayWithKeyValuesArray:ary]];
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

#pragma mark - 单条删除
- (void) myHandleTableviewCellLongPressed:(UILongPressGestureRecognizer *)gestureRecognizer {
    
    
    CGPoint pointTouch = [gestureRecognizer locationInView:self.collectionView];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"UIGestureRecognizerStateBegan");
        
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:pointTouch];
        if (indexPath == nil) {
            NSLog(@"空");
        }else{
            MJWeakSelf
            UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否删除该条记录？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sure = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //删除
                ZWHCollectModel *model = _dataArray[indexPath.row];
                [HttpHandler getBrowseProductDelete:@{@"para1":UniqUserID,@"para2":userType,@"para3":model.productno} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
                    if (ReturnValue == 1) {
                        [self showHint:@"取消成功"];
                        [_dataArray removeObject:model];
                        [weakSelf.collectionView deleteItemsAtIndexPaths:@[indexPath]];
                    }
                } failed:^(id obj) {
                    
                }];
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:1 handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alerVC addAction:sure];
            [alerVC addAction:cancel];
            [self presentViewController:alerVC animated:YES completion:^{
                
            }];
        }
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        //NSLog(@"UIGestureRecognizerStateChanged");
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        //NSLog(@"UIGestureRecognizerStateEnded");
    }
}

#pragma mark - 清空
-(void)cleanCollectWith:(UIButton *)btn{
    MJWeakSelf
    UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定清空全部记录？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [HttpHandler getBrowseProductDelete:@{@"para1":UniqUserID,@"para2":userType} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
            if (ReturnValue == 1) {
                [self showHint:@"清空成功"];
                [weakSelf.collectionView.mj_header beginRefreshing];
            }
        } failed:^(id obj) {
            
        }];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:1 handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alerVC addAction:sure];
    [alerVC addAction:cancel];
    [self presentViewController:alerVC animated:YES completion:^{
        
    }];
}


#pragma mark - uicollectView

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH - WIDTH_PRO(32))/3,HEIGHT_PRO(145));
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
        ZWHHistoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZWHHistoryCollectionViewCell" forIndexPath:indexPath];
    if (_dataArray.count>0) {
        cell.model = _dataArray[indexPath.row];
    }
    return cell;
}

/*-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        header.backgroundColor = [UIColor clearColor];
        //header.frame = CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(40));
        UILabel *lab = [[UILabel alloc]init];
        lab.text = @"6月27日";
        lab.font = HTFont(28);
        lab.textColor = ZWHCOLOR(@"#676D7A");
        [header addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(header).offset(WIDTH_PRO(8));
            make.centerY.equalTo(header);
        }];
        return header;
    }else{
        return nil;
    }
}*/


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"普通点击Section = %ld,Row = %ld",(long)indexPath.section,(long)indexPath.row);
    
    ZWHCollectModel *model = _dataArray[indexPath.item];
    
    ZWHProductDetailViewController *vc = [[ZWHProductDetailViewController alloc]init];
    vc.productNo = model.productno;
    [self.navigationController pushViewController:vc animated:YES];
}




@end
