//
//  InsuranceVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/23.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "InsuranceVC.h"
#import "SDCycleScrollView.h"
#import "InsuranceVM.h"
#import "InsuranceTopListCell.h"
#import "InsuranceChooseCell.h"
#import "InsuranceListCell.h"
#import "InsuranceSingleVC.h"
#import "TiketHotCollecCell.h"
#import "ZWHInsuranceCollectionViewCell.h"

#import "ZWHAdvertModel.h"
#define inter @"01201"
#define extrar @"01202"
@interface InsuranceVC ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *topListData;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,copy)NSString *listParame;

@property(nonatomic,strong)NSMutableArray *advertArr;

@property(nonatomic,assign)NSInteger index;

@property(nonatomic,strong)SDCycleScrollView *topScrView;

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation InsuranceVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

-(UIImage *)navigationBarBackgroundImage{
    
    if (![UniqUserID isEqualToString:@"0000000003"]) {
          return [UIImage new];
    }
    return [UIImage qmui_imageWithColor:MAINCOLOR];
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"旅游保险";
    self.view.backgroundColor=[UIColor whiteColor];
 
    
    if ([UniqUserID isEqualToString:@"0000000003"]) {
        [self showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(getDataSource)];
        return;
    }
    [self.view addSubview:self.tableview];
    self.keyTableView = self.tableview;
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
    [self setHeader];
    [self getAdSource];
    [self setRefresh];
    [self TopList];
    //[self InsureList];
}
-(void)getDataSource{
    
    [self showHudInView:self.view hint:@""];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideHud];
    });
}

-(void)setHeader{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:self.topScrView];
    
    UILabel *lab = [[UILabel alloc]init];
    lab.text = @"旅游首选";
    lab.textColor = [UIColor blackColor];
    lab.font = HTFont(24);
    [headerView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(WIDTH_PRO(8));
        make.top.equalTo(_topScrView.mas_bottom).offset(HEIGHT_PRO(8));
    }];
    
    // 初始化一个布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset =UIEdgeInsetsMake(0,0,0, 0);
    
    // 设置最小行距
    flowLayout.minimumLineSpacing = HEIGHT_PRO(8);
    // 设置最小间距
    flowLayout.minimumInteritemSpacing = WIDTH_PRO(8);
    
    // 设置格子大小
    flowLayout.itemSize = CGSizeMake(WIDTH_PRO(135), HEIGHT_PRO(110));
    // 设置组边界
    flowLayout.sectionInset = UIEdgeInsetsMake(WIDTH_PRO(0), WIDTH_PRO(8), WIDTH_PRO(0), WIDTH_PRO(8));
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 初始化集合视图
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    
    // 设置背景色
    _collectionView.backgroundColor = [UIColor whiteColor];
    // 设置代理和数据源
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerClass:[ZWHInsuranceCollectionViewCell class] forCellWithReuseIdentifier:@"ZWHInsuranceCollectionViewCell"];
    [headerView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(headerView);
        make.height.mas_offset(HEIGHT_PRO(130));
        make.top.equalTo(lab.mas_bottom);
    }];
    [_collectionView layoutIfNeeded];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = LINECOLOR;
    [headerView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(headerView);
        make.height.mas_equalTo(1);
        make.top.equalTo(_collectionView.mas_bottom);
    }];
    [line layoutIfNeeded];
    
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.topScrView.frame.size.height+_collectionView.frame.size.height+HEIGHT_PRO(30));
    self.tableview.tableHeaderView = headerView;
}

#pragma mark - 获得广告
-(void)getAdSource{
    MJWeakSelf;
    //轮播图广告
    [HttpHandler getSystemGetADInfo:@{@"para2":@"bx"} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
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


#pragma mark - 懒加载
-(NSString *)listParame
{
    if (!_listParame) {
         // 01201 国内游  //出境游 01202
        _listParame=inter;
    }
    return _listParame;
}

-(UITableView *)tableview
{
    if (!_tableview) {
        
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _tableview.tableFooterView=[UIView new];
        [_tableview registerClass:[InsuranceTopListCell class] forCellReuseIdentifier:@"InsuranceTopListCell"];
        [_tableview registerClass:[InsuranceChooseCell class] forCellReuseIdentifier:@"InsuranceChooseCell"];
        [_tableview registerNib:[UINib nibWithNibName:@"InsuranceListCell" bundle:nil] forCellReuseIdentifier:@"InsuranceListCell"];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        
        
    }
    return _tableview;
}
#pragma mark - Data
-(void)TopList{
    NSString *start=@"1";
    NSString *end=@"20";
    DefineWeakSelf;
    [InsuranceVM InsureTopListSysmodel:@"" Startindex:start Endindex:end Success:^(id responseData) {
        weakSelf.topListData=[InsuranceModel getDatawithdic:responseData];
        NSIndexSet *set=[NSIndexSet indexSetWithIndex:0];
        [weakSelf.tableview reloadSections:set withRowAnimation:NO];
        [weakSelf.collectionView reloadData];
    } Fail:^(id erro) {
        
    }];
}
-(void)InsureList{
    NSNumber *startIndex = [NSNumber numberWithInteger:_index];
    MJWeakSelf
    [HttpHandler getInsureList:@{@"para1":self.code,@"para2":self.listParame} start:startIndex end:@(10) querytype:@"0" Success:^(id obj) {
        if (ReturnValue==1) {
            NSArray *ary = obj[@"DataList"];
            if (ary.count == 0) {
                [weakSelf.tableview.mj_header endRefreshing];
                [weakSelf.tableview.mj_footer endRefreshingWithNoMoreData];
            }else{
                [weakSelf.dataArray addObjectsFromArray: [InsuranceModel mj_objectArrayWithKeyValuesArray:ary]];
                [weakSelf.tableview.mj_header endRefreshing];
                [weakSelf.tableview.mj_footer endRefreshing];
            }
            NSIndexSet *set=[NSIndexSet indexSetWithIndex:1];
            [weakSelf.tableview reloadSections:set withRowAnimation:NO];
        }
    } failed:^(id obj) {
        [weakSelf.tableview.mj_header endRefreshing];
        [weakSelf.tableview.mj_footer endRefreshing];
    }];
}

-(void)setRefresh{
    MJWeakSelf
    _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.dataArray = [NSMutableArray array];
        weakSelf.index = 1;
        [weakSelf InsureList];
    }];
//    _tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        weakSelf.index ++ ;
//        [weakSelf InsureList];
//    }];
    [_tableview.mj_header beginRefreshing];
    
    
}

#pragma mark - uicollectviewdelagate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _topListData.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZWHInsuranceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZWHInsuranceCollectionViewCell" forIndexPath:indexPath];
    cell.model = _topListData[indexPath.item];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    InsuranceModel *model=self.topListData[indexPath.row];
    InsuranceSingleVC *vc=[[InsuranceSingleVC alloc]init];
    vc.code=model.code;
    vc.isTravel = _isTravel;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return self.dataArray.count;
        }
            break;
            
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            InsuranceChooseCell *cell=[tableView dequeueReusableCellWithIdentifier:@"InsuranceChooseCell"];
            DefineWeakSelf;
            cell.chooseModelBlock = ^(NSInteger index) {
                if (index==1) {
                    weakSelf.listParame=inter;
                    [weakSelf.tableview.mj_header beginRefreshing];
                }else
                {
                    weakSelf.listParame=extrar;
                    [weakSelf.tableview.mj_header beginRefreshing];
                }
            };
            return cell;
        }
            break;
        case 1:
        {
            InsuranceListCell *cell=[tableView dequeueReusableCellWithIdentifier:@"InsuranceListCell"];
            InsuranceModel *model=self.dataArray[indexPath.row];
            cell.model=model;
            cell.selectionStyle = 0;
            return cell;
        }
            break;

    }

    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            return 40;
        }
            break;
        case 1:
        {
            return 98;
        }
            break;

    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section ==1) {
        InsuranceModel *model=self.dataArray[indexPath.row];
        InsuranceSingleVC *vc=[[InsuranceSingleVC alloc]init];
        vc.code=model.code;
        vc.isTravel = _isTravel;
        [self.navigationController pushViewController:vc animated:YES];
    }else
    {
        return;
    }
    
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
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
