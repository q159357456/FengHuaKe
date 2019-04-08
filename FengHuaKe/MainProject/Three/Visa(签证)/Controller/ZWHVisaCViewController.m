//
//  ZWHVisaCViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/12/20.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHVisaCViewController.h"
#import "ZWHSearchBar.h"
#import "ClassifyModel.h"
#import "ZWHVisaCollectionViewCell.h"
#import "CatageModel.h"
#import "ZWHVisaDetailViewController.h"

@interface ZWHVisaCViewController ()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)ZWHSearchBar *searchBar;

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)NSMutableArray *topClassifyArr;

@property(nonatomic, strong)QMUIFloatLayoutView *floatLayoutView;

//标记选择的目的地按钮
@property(nonatomic, strong)QMUIButton *selectBtn;
@property(nonatomic, strong)QMUILabel *desLab;
@property(nonatomic, strong)QMUILabel *lab;


@end

@implementation ZWHVisaCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setsearchbar];
    self.view.backgroundColor = [UIColor whiteColor];
    [self getClassify];
}

#pragma mark - 自定义searchbar
-(void)setsearchbar{
    //搜索栏
    _searchBar = [[ZWHSearchBar alloc]initWithFrame:CGRectMake(0, 0, WIDTH_PRO(260), 30)];
    self.navigationItem.titleView = _searchBar;
    _searchBar.placeholder = @"搜索全球签证目的地";
    _searchBar.layer.borderColor = LINECOLOR.CGColor;
    _searchBar.layer.borderWidth = 0.8f;
    _searchBar.delegate = self;
}

#pragma mark - 获取目的地分类
-(void)getClassify{
    [self showEmptyViewWithLoading];
    MJWeakSelf;
    [HttpHandler getCaseClass:@{@"para1":@"D001"} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        //[weakSelf hideEmptyView];
        if (ReturnValue==1) {
            weakSelf.topClassifyArr = [ClassifyModel mj_objectArrayWithKeyValuesArray:obj[@"DataList"]];
            ClassifyModel *model = [[ClassifyModel alloc]init];
            model.name = @"全部";
            [weakSelf.topClassifyArr insertObject:model atIndex:0];
            [weakSelf setUI];
            [weakSelf getHotData];
            [weakSelf setRefresh];
        }else{
            [weakSelf showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(getClassify)];
        }
    } failed:^(id obj) {
        [weakSelf hideEmptyView];
        [weakSelf showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(getClassify)];
    }];
}

#pragma mark - 网络请求
/**
 *获得热门目的地列表数据
 */
-(void)getHotData{
    _dataArray = [NSMutableArray array];
    _index = 1;
    MJWeakSelf;
    [HttpHandler getCaseHot:@{@"para1":@"D001"} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        [weakSelf hideEmptyView];
        [weakSelf.collectionView.mj_header endRefreshing];
        if (ReturnValue==1) {
            weakSelf.collectionView.mj_footer.hidden = YES;
            weakSelf.dataArray = [CatageModel mj_objectArrayWithKeyValuesArray:obj[@"DataList"]];
            [weakSelf.collectionView reloadData];
        }else{
            [weakSelf showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(getClassify)];
        }
    } failed:^(id obj) {
        weakSelf.collectionView.mj_footer.hidden = YES;
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf hideEmptyView];
        [weakSelf showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(getClassify)];
    }];
}




/**
 *获得目的地列表数据
 */
-(void)getDataSource{
    NSNumber *startIndex = [NSNumber numberWithInteger:_index];
    ClassifyModel *model = _topClassifyArr[_selectBtn.tag];
    MJWeakSelf
    [HttpHandler getCaseList:@{@"para1":@"D001",@"para2":model.code} start:startIndex end:@10 querytype:@"0" Success:^(id obj) {
        NSLog(@"%@",obj);
        if (ReturnValue == 1) {
            NSArray *ary = obj[@"DataList"];
            if (ary.count == 0) {
                [weakSelf.collectionView.mj_header endRefreshing];
                weakSelf.collectionView.mj_footer.hidden = YES;
                //[weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [weakSelf.dataArray addObjectsFromArray: [CatageModel mj_objectArrayWithKeyValuesArray:ary]];
                [weakSelf.collectionView.mj_header endRefreshing];
                [weakSelf.collectionView.mj_footer endRefreshing];
                weakSelf.collectionView.mj_footer.hidden = NO;
            }
            [weakSelf.collectionView reloadData];
            if (weakSelf.dataArray.count==0) {
                //[weakSelf showEmptyViewWithImage:[UIImage imageNamed:@"nodata"] text:@"" detailText:@"" buttonTitle:@"" buttonAction:nil];
                //weakSelf.emptyView.backgroundColor = [UIColor whiteColor];
            }else{
                [weakSelf hideEmptyView];
            }
        }
    } failed:^(id obj) {
        weakSelf.collectionView.mj_footer.hidden = YES;
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
}

-(void)setRefresh{
    MJWeakSelf
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.dataArray = [NSMutableArray array];
        weakSelf.index = 1;
        if (weakSelf.selectBtn.tag==0) {
            [weakSelf getHotData];
        }else{
            [weakSelf getDataSource];
        }
        
    }];
    
    _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.index ++ ;
        if (weakSelf.selectBtn.tag==0) {
            [weakSelf.collectionView.mj_footer endRefreshing];
        }else{
            [weakSelf getDataSource];
        }
    }];
    //[_collectionView.mj_header beginRefreshing];

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
    flowLayout.itemSize = CGSizeMake(WIDTH_PRO(114), HEIGHT_PRO(105));
    // 设置组边界
    flowLayout.sectionInset = UIEdgeInsetsMake(WIDTH_PRO(8), WIDTH_PRO(8), WIDTH_PRO(8), WIDTH_PRO(8));
    //self.floatLayoutView;
    CGSize floatLayoutViewSize = [self.floatLayoutView sizeThatFits:CGSizeMake(SCREEN_WIDTH-WIDTH_PRO(16), CGFLOAT_MAX)];
    flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, floatLayoutViewSize.height+HEIGHT_PRO(30+30+20)+7);
    // 初始化集合视图
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    
    // 设置背景色
    _collectionView.backgroundColor = [UIColor whiteColor];
    // 设置代理和数据源
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[ZWHVisaCollectionViewCell class] forCellWithReuseIdentifier:@"ZWHVisaCollectionViewCell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(ZWHNavHeight);
    }];
    
    self.keyCollectionView = _collectionView;
}




#pragma mark - uicollectView

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(WIDTH_PRO(114), HEIGHT_PRO(105));
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
    ZWHVisaCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZWHVisaCollectionViewCell" forIndexPath:indexPath];
    if (_dataArray.count>0) {
        cell.model = _dataArray[indexPath.row];
    }
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        header.backgroundColor = [UIColor whiteColor];
        
        
        [header addSubview:self.lab];
        [self.lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(header).offset(WIDTH_PRO(10));
            make.top.equalTo(header).offset(HEIGHT_PRO(7));
        }];
        
        [header addSubview:self.floatLayoutView];
        CGSize floatLayoutViewSize = [self.floatLayoutView sizeThatFits:CGSizeMake(SCREEN_WIDTH-WIDTH_PRO(16), CGFLOAT_MAX)];
        [self.floatLayoutView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(header).offset(WIDTH_PRO(8));
            make.top.equalTo(_lab.mas_bottom).offset(HEIGHT_PRO(15));
            make.right.equalTo(header).offset(-WIDTH_PRO(8));
            make.height.mas_equalTo(floatLayoutViewSize.height+HEIGHT_PRO(15));
            //make.bottom.equalTo(header).offset(-HEIGHT_PRO(15));
        }];
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = LINECOLOR;
        [header addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(header);
            make.top.equalTo(self.floatLayoutView.mas_bottom);
            make.height.mas_equalTo(7);
        }];
        
        
        [header addSubview:self.desLab];
        [_desLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(header).offset(WIDTH_PRO(10));
            make.top.equalTo(line.mas_bottom).offset(HEIGHT_PRO(7));
        }];
        
        if (_selectBtn.tag==0) {
            _desLab.text = @"热门目的地";
        }else{
            ClassifyModel *model = _topClassifyArr[_selectBtn.tag];
            _desLab.text = [NSString stringWithFormat:@"%@目的地",model.name];
        }
        
        
        header.frame = CGRectMake(0, 0,SCREEN_WIDTH, floatLayoutViewSize.height+HEIGHT_PRO(30+30+20)+7);
        return header;
    }else{
        return nil;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CatageModel *model = _dataArray[indexPath.row];
    ZWHVisaDetailViewController *vc = [[ZWHVisaDetailViewController alloc]init];
    vc.code = model.code;
    [self.navigationController pushViewController:vc animated:YES];
}







#pragma mark - 目的地选择
-(void)chooseDestinationWith:(QMUIButton *)btn{
    _selectBtn.backgroundColor = [UIColor whiteColor];
    [_selectBtn setTitleColor:[UIColor blackColor] forState:0];
    btn.backgroundColor = MAINCOLOR;
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    _selectBtn = btn;
    
    [self.collectionView.mj_header beginRefreshing];
}



#pragma mark - getter
-(QMUIFloatLayoutView *)floatLayoutView{
    if (!_floatLayoutView) {
        _floatLayoutView = [[QMUIFloatLayoutView alloc] init];
        _floatLayoutView.padding = UIEdgeInsetsZero;
        _floatLayoutView.itemMargins = UIEdgeInsetsMake(0, 0, 10, 10);
        _floatLayoutView.minimumItemSize = CGSizeMake(79, 26);
        
        for (NSInteger i=0; i<_topClassifyArr.count; i++) {
            
            ClassifyModel *model = _topClassifyArr[i];
            QMUIButton *btn = [[QMUIButton alloc]init];
            [btn setTitleColor:[UIColor blackColor] forState:0];
            [btn setTitle:model.name forState:0];
            btn.layer.cornerRadius = 5;
            btn.layer.masksToBounds = YES;
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = [ZWHCOLOR(@"#AAAAAA") CGColor];
            btn.titleLabel.font = HTFont(28);
            btn.contentEdgeInsets = UIEdgeInsetsMake(6, 10, 6, 10);
            btn.tag = i;
            if (i==0) {
                btn.backgroundColor = MAINCOLOR;
                [btn setTitleColor:[UIColor whiteColor] forState:0];
                _selectBtn = btn;
            }
            [btn addTarget:self action:@selector(chooseDestinationWith:) forControlEvents:UIControlEventTouchUpInside];
            [_floatLayoutView addSubview:btn];
        }
    }
    return _floatLayoutView;
}

-(QMUILabel *)lab{
    if (!_lab) {
        _lab = [[QMUILabel alloc]qmui_initWithFont:ZWHFont(14) textColor:[UIColor blackColor]];
        _lab.text = @"选择签证目的地";
    }
    return _lab;
}

-(QMUILabel *)desLab{
    if (!_desLab) {
        _desLab = [[QMUILabel alloc]qmui_initWithFont:ZWHFont(14) textColor:[UIColor blackColor]];
    }
    return _desLab;
}













@end
