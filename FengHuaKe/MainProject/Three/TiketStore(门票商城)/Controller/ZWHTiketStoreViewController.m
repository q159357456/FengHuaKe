//
//  ZWHTiketStoreViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/17.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHTiketStoreViewController.h"
#import "ZWHClassifyModel.h"
#import "TravelListModel.h"
#import "ZWHTiketCollectionViewCell.h"
#import "ZWHTicketTableViewCell.h"
#import "ZWHCityModel.h"
#import "TicketListModel.h"
#import "ZWHAdvertModel.h"
#import "ZWHTicketDetailViewController.h"
#import "ZWHTicketListViewController.h"
#import "ZWHNorSearchViewController.h"

@interface ZWHTiketStoreViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate>

@property(nonatomic,strong)UITableView *ticketTable;
@property(nonatomic,strong)SDCycleScrollView *topScrView;

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)UISearchBar *searchBar;

@property(nonatomic,strong)QMUIButton  *cityB;

@property(nonatomic,strong)UIView *headerView;

//8类
@property(nonatomic,strong)NSArray *topClassifyArr;

@property(nonatomic,strong)QMUIGridView *topGridView;

@property(nonatomic,assign)BOOL isShowMore;

@property(nonatomic,strong)NSMutableArray *topListData;

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,assign)NSString *cityCode;

//广告
@property(nonatomic,strong)NSMutableArray *advertArr;

@property (nonatomic, strong) NSMutableString *currentSearchText;

@end

@implementation ZWHTiketStoreViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    if (_ticketTable) {
        [self scrollViewDidScroll:_ticketTable];
    }
}


-(UIImage *)navigationBarBackgroundImage{
    return [UIImage new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _topListData = [NSMutableArray array];
    _currentSearchText = [NSMutableString string];
    [self getClassify];
}

-(void)setUI{
    
    self.dataArray = [NSMutableArray array];
    self.index = 1;
    
    _ticketTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-HEIGHT_PRO(50)) style:UITableViewStylePlain];
    [self.view addSubview:_ticketTable];
    [_ticketTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(self.view);
    }];
    _ticketTable.delegate = self;
    _ticketTable.dataSource = self;
    _ticketTable.separatorStyle = 0;
    _ticketTable.backgroundColor = LINECOLOR;
    _ticketTable.showsVerticalScrollIndicator = NO;
    [_ticketTable registerClass:[ZWHTicketTableViewCell class] forCellReuseIdentifier:@"ZWHTicketTableViewCell"];
    self.keyTableView = _ticketTable;
    [self setHeader];
    [self setNavigatController];
    [self setRefresh];
    
}


#pragma mark - 网络请求

//判断市是否有缓存
-(void)getCityCode{
    if ([userCity length]>0) {
    }else{
        [userDefault setObject:@"东莞市" forKey:@"usercity"];
        [userDefault synchronize];
    }
    [[ZWHFMDBManager shareDatabase] creatTableWith:[ZWHCityModel new]];
    NSArray *cityArr = [[ZWHFMDBManager shareDatabase] findDtaWith:[ZWHCityModel new] withKey:@"name" withValue:userCity];
    if (cityArr.count>0) {
        ZWHCityModel *model = [ZWHCityModel mj_objectWithKeyValues:cityArr[0]];
        self.cityCode = model.code;
        [self getDataSource];
    }else{
        MJWeakSelf
        [HttpHandler getAddressCity:@{@"para2":userCity} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
            NSLog(@"%@",obj);
            NSArray *arr = [HttpTool getArrayWithData:obj[@"sysmodel"][@"strresult"]];
            ZWHCityModel *model = [ZWHCityModel mj_objectWithKeyValues:arr[0]];
            [[ZWHFMDBManager shareDatabase]insertGroup:model];
            weakSelf.cityCode = model.code;
            [weakSelf getDataSource];
        } failed:^(id obj) {
            
        }];
    }
}

-(void)getDataSource{
    NSNumber *startIndex = [NSNumber numberWithInteger:_index];
    
    MJWeakSelf
    [HttpHandler getTicketList:@{@"para2":self.cityCode,@"para4":@"1"} start:startIndex end:@10 querytype:@"0" Success:^(id obj) {
            NSArray *ary = obj[@"DataList"];
            if (ary.count == 0) {
                [weakSelf.ticketTable.mj_header endRefreshing];
                [weakSelf.ticketTable.mj_footer endRefreshingWithNoMoreData];
            }else{
                [weakSelf.dataArray addObjectsFromArray: [TicketListModel mj_objectArrayWithKeyValuesArray:ary]];
                [weakSelf.ticketTable.mj_header endRefreshing];
                [weakSelf.ticketTable.mj_footer endRefreshing];
            }
            [weakSelf.ticketTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        } failed:^(id obj) {
            [weakSelf.ticketTable.mj_header endRefreshing];
            [weakSelf.ticketTable.mj_footer endRefreshing];
        }];
}

-(void)setRefresh{
    MJWeakSelf
    _ticketTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.dataArray = [NSMutableArray array];
        weakSelf.index = 1;
        [weakSelf getCityCode];
    }];
    _ticketTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.index ++ ;
        [weakSelf getCityCode];
    }];
    [_ticketTable.mj_header beginRefreshing];
}



#pragma mark - 设置头部视图
-(void)setHeader{
    _headerView = [[UIView alloc]init];
    _headerView.backgroundColor = [UIColor whiteColor];
    [_headerView addSubview:self.topScrView];
    
    
    //8大类
    _topGridView = [[QMUIGridView alloc]initWithColumn:4 rowHeight:HEIGHT_PRO(90)];
    _topGridView.height = HEIGHT_PRO(180);
    //[self setShowdownWith:topGridView];
    [_headerView addSubview:_topGridView];
    [_topGridView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_headerView);
        make.top.equalTo(self.topScrView.mas_bottom);
        make.height.mas_equalTo(HEIGHT_PRO(180));
    }];
    [_topGridView layoutIfNeeded];
    for (NSInteger i=0;i<8;i++) {
        
        ZWHClassifyModel *model = _topClassifyArr[i];
        UIView *whitview = [[UIView alloc]init];
        UIImageView *img = [[UIImageView alloc]init];
        [whitview addSubview:img];
        UILabel *lab = [[UILabel alloc]init];
        lab.textAlignment = NSTextAlignmentCenter;
        [whitview addSubview:lab];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(WIDTH_PRO(40));
            make.height.mas_equalTo(HEIGHT_PRO(40));
            make.top.equalTo(whitview).offset(HEIGHT_PRO(15));
            make.centerX.equalTo(whitview);
        }];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(img.mas_bottom).offset(HEIGHT_PRO(6));
            make.left.right.equalTo(whitview);
        }];
        lab.font = HTFont(28);
        lab.text = model.name;
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,model.icon]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
        [_topGridView addSubview:whitview];
        
        //覆盖按钮
        QMUIButton *btn = [[QMUIButton alloc]init];
        btn.backgroundColor = [UIColor clearColor];
        [whitview addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(whitview);
        }];
        btn.tag = i;
        [btn addTarget:self action:@selector(topGirdViewWith:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    QMUIButton *btn = [[QMUIButton alloc]qmui_initWithImage:[UIImage imageNamed:@"WechatIMG31"] title:@"查看更多分类"];
    [btn setTintColorAdjustsTitleAndImage:MAINCOLOR];
    btn.imagePosition = QMUIButtonImagePositionRight;
    //btn.spacingBetweenImageAndTitle = 3;
    btn.titleLabel.font = HTFont(24);
    [_headerView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topGridView.mas_bottom);
        make.centerX.equalTo(_topGridView);
    }];
    [btn layoutIfNeeded];
    [btn addTarget:self action:@selector(showMoreClassify:) forControlEvents:UIControlEventTouchUpInside];
    
    //分割线
    UIView *midLine = [[UIView alloc]init];
    midLine.backgroundColor = LINECOLOR;
    [_headerView addSubview:midLine];
    [midLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn.mas_bottom).offset(HEIGHT_PRO(3));
        make.left.right.equalTo(_headerView);
        make.height.mas_equalTo(HEIGHT_PRO(10));
    }];
    
    QMUIButton *huobtn = [[QMUIButton alloc]init];
    [huobtn setTitle:@"热门景点" forState:0];
    huobtn.spacingBetweenImageAndTitle = 3;
    [btn setImagePosition:QMUIButtonImagePositionLeft];
    [huobtn setImage:[UIImage imageNamed:@"huo"] forState:0];
    huobtn.titleLabel.font = HTFont(24);
    [_headerView addSubview:huobtn];
    [huobtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(midLine.mas_bottom);
        make.left.equalTo(_headerView).offset(WIDTH_PRO(8));
        make.height.mas_equalTo(HEIGHT_PRO(30));
    }];
    [huobtn layoutIfNeeded];
    
    [_headerView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_headerView);
        make.top.equalTo(huobtn.mas_bottom).offset(HEIGHT_PRO(3));
        make.height.mas_equalTo(HEIGHT_PRO(135));
    }];
    [self.collectionView layoutIfNeeded];
    
    _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.topScrView.frame.size.height+_topGridView.frame.size.height+btn.frame.size.height+HEIGHT_PRO(30)+huobtn.frame.size.height+self.collectionView.frame.size.height);
    self.ticketTable.tableHeaderView = _headerView;
    [self getHotSpot];
}

/**
 * 查看更多分类
 */
-(void)showMoreClassify:(QMUIButton *)btn{
    _isShowMore = !_isShowMore;
    if (_isShowMore) {
        if (_topClassifyArr.count==8) {
            [QMUITips showSucceed:@"已全部展示"];
            _isShowMore = NO;
            btn.imageView.transform = CGAffineTransformIdentity;
            return;
        }
    }
    
    CGFloat frameHig = _headerView.frame.size.height - _topGridView.frame.size.height;
    
    btn.imageView.transform = _isShowMore?CGAffineTransformMakeRotation(M_PI):CGAffineTransformIdentity;
    for (UIView *view in _topGridView.subviews) {
        [view removeFromSuperview];
    }
    NSInteger number = _isShowMore?_topClassifyArr.count:8;
    for (NSInteger i=0;i<number;i++) {
        ZWHClassifyModel *model = _topClassifyArr[i];
        UIView *whitview = [[UIView alloc]init];
        UIImageView *img = [[UIImageView alloc]init];
        [whitview addSubview:img];
        UILabel *lab = [[UILabel alloc]init];
        lab.textAlignment = NSTextAlignmentCenter;
        [whitview addSubview:lab];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(WIDTH_PRO(40));
            make.height.mas_equalTo(HEIGHT_PRO(40));
            make.top.equalTo(whitview).offset(HEIGHT_PRO(15));
            make.centerX.equalTo(whitview);
        }];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(img.mas_bottom).offset(HEIGHT_PRO(6));
            make.left.right.equalTo(whitview);
        }];
        lab.font = HTFont(28);
        lab.text = model.name;
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,model.icon]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
        [_topGridView addSubview:whitview];
        
        //覆盖按钮
        QMUIButton *btn = [[QMUIButton alloc]init];
        btn.backgroundColor = [UIColor clearColor];
        [whitview addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(whitview);
        }];
        btn.tag = i;
        [btn addTarget:self action:@selector(topGirdViewWith:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    CGFloat hig;
    if (number%4==0) {
        hig = number/4 * HEIGHT_PRO(90);
    }else{
        hig = (number/4+1) * HEIGHT_PRO(90);
    }
    
    [_topGridView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_headerView);
        make.top.equalTo(self.topScrView.mas_bottom);
        make.height.mas_equalTo(hig);
    }];
    [_topGridView updateConstraintsIfNeeded];
    
    
    _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, hig+frameHig);
    _ticketTable.tableHeaderView = _headerView;
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
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchBar.delegate = self;
    UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
    [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    searchField.textColor = [UIColor whiteColor];
    [_searchBar setImage:[UIImage imageNamed:@"search"] forSearchBarIcon:UISearchBarIconSearch state:0];
    self.navigationItem.titleView = _searchBar;
    
    _cityB = [[QMUIButton alloc]init];
    [_cityB setTitleColor:[UIColor whiteColor] forState:0];
    [_cityB setTitle:[userCity stringByReplacingOccurrencesOfString:@"市" withString:@""] forState:0];
    [_cityB setImage:[UIImage imageNamed:@"groupdown"] forState:0];
    [_cityB setImagePosition:QMUIButtonImagePositionRight];
    [_cityB setTintColorAdjustsTitleAndImage:[UIColor whiteColor]];
    _cityB.titleLabel.font = HTFont(28);
    [_cityB sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_cityB];
}

#pragma mark - 获得热门景点
-(void)getHotSpot{
    MJWeakSelf
    [HttpHandler getTravelList:@{@"para1":_code,@"para8":@"true"} start:@(1) end:@(20) querytype:@"0" Success:^(id obj) {
        if (ReturnValue == 1) {
            NSLog(@"%@",obj);
            weakSelf.topListData = [TravelListModel mj_objectArrayWithKeyValuesArray:obj[@"DataList"]];
            [weakSelf.collectionView reloadData];
        }
    } failed:^(id obj) {
        
    }];
    
    //轮播图广告
    [HttpHandler getSystemGetADInfo:@{@"para2":@"mp"} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
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

#pragma mark - 获得八大类
-(void)getClassify{
    [self showEmptyViewWithLoading];
    MJWeakSelf
    [HttpHandler getClassifyList:@{@"para1":_code,@"intresult":@"0",@"blresult":@"true"} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        [weakSelf hideEmptyView];
        if (ReturnValue==1) {
            weakSelf.topClassifyArr = [ZWHClassifyModel mj_objectArrayWithKeyValuesArray:obj[@"DataList"]];
            [weakSelf setUI];
        }else{
            [weakSelf showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(getClassify)];
        }
    } failed:^(id obj) {
        [weakSelf hideEmptyView];
        [weakSelf showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(getClassify)];
    }];
}

#pragma mark - 8大类跳转

-(void)topGirdViewWith:(UIButton *)btn{
    NSLog(@"%ld",btn.tag);
    ZWHClassifyModel *model = _topClassifyArr[btn.tag];
    ZWHTicketListViewController *vc = [[ZWHTicketListViewController alloc]init];
    vc.code = _code;
    vc.secode = model.code;
    vc.title = model.name;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - uitabledelegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HEIGHT_PRO(40);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = LINECOLOR;
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(view);
        make.height.mas_equalTo(HEIGHT_PRO(39));
    }];
    
    NSArray *array = @[@"全部",@"全城",@"智能排序"];
    for (NSInteger i=0; i<3; i++) {
        QMUIButton *btn = [[QMUIButton alloc]qmui_initWithImage:[UIImage imageNamed:@"clear_icon"] title:array[i]];
        btn.imagePosition = QMUIButtonImagePositionRight;
        btn.titleLabel.font = HTFont(28);
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [backView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(backView);
            make.left.equalTo(backView).offset(i*SCREEN_WIDTH/3);
            make.width.mas_equalTo(SCREEN_WIDTH/3);
        }];
        //btn.frame = CGRectMake(SCREEN_WIDTH/3*i, 0, SCREEN_WIDTH/3, HEIGHT_PRO(40));
    }
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = LINECOLOR;
    [backView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(view);
        make.height.mas_equalTo(1);
    }];
    
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_PRO(94);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWHTicketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHTicketTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = 0;
    cell.model = _dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWHTicketDetailViewController *vc = [[ZWHTicketDetailViewController alloc]init];
    TicketListModel *model = _dataArray[indexPath.row];
    vc.code = model.productno;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_searchBar endEditing:YES];
    
    if (scrollView == _ticketTable) {
        CGFloat minAlphaOffset = 0;//- 64;
        CGFloat maxAlphaOffset = 200;
        CGFloat offset = scrollView.contentOffset.y;
        CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
        //_barImageView.alpha = alpha;
        UIColor *color = [[UIColor alloc]initWithRed:75/255.0f green:164/255.0f blue:255/255.0f alpha:alpha];
        [self.navigationController.navigationBar setBackgroundImage:[DataProcess imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
        CGFloat navhig = ISIphoneX==0?64.0f:88.0f;
        
        //让组标题悬停
        if (_headerView) {
            if (scrollView.contentOffset.y >= _headerView.frame.size.height-navhig) {
                scrollView.contentInset = UIEdgeInsetsMake(navhig, 0, 0, 0);
            }else{
                scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            }
        }
    }
}

#pragma mark - uicollectviewdelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _topListData.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZWHTiketCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZWHTiketCollectionViewCell" forIndexPath:indexPath];
    cell.model = _topListData[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ZWHTicketDetailViewController *vc = [[ZWHTicketDetailViewController alloc]init];
    TravelListModel *model = _topListData[indexPath.row];
    vc.code = model.productno;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - uisearchbar
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    ZWHNorSearchViewController *vc = [[ZWHNorSearchViewController alloc]init];
    vc.code = _code;
    vc.state = 1;
    [self.navigationController pushViewController:vc animated:NO];
    return NO;
}

#pragma mark -- UISearchBarDelegate
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    // 获得需要进行搜索的关键字, 此种方式获取的词汇：比如拼音输入beijing时，获取的是bei jing
    //      self.currentSearchText = [[searchBar.text stringByReplacingCharactersInRange:range withString:text] mutableCopy];
    
    // 项目中使用的这个，此种方式获取的是用户输入的拼音，比如beijing，就是beijing
    // range代表用户输入的字符长度, text是用户输入的字符
    if (!range.length) {
        // 给当前搜索的字符串拼接字符
        [self.currentSearchText appendFormat:@"%@", text];
    } else {
        // 表示用户删除了一个字符,删除当前搜索字符串最后一个字符
        [self.currentSearchText  deleteCharactersInRange:NSMakeRange(self.currentSearchText.length-1,1)]; //
        
    }
    
    //  手动调用一次此方法开始搜索，因为项目中发送服务器请求的方法在这里面处理的
    [self searchBar:searchBar textDidChange:self.currentSearchText];
    
    
    //[UISearchBar placeholderHidden:searchBar Text:text Editor:YES];
    
    return YES;
}




#pragma mark - getter


-(UICollectionView *)collectionView{
    if (!_collectionView) {
        // 初始化一个布局对象
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.sectionInset =UIEdgeInsetsMake(0,0,0, 0);
        
        // 设置最小行距
        flowLayout.minimumLineSpacing = HEIGHT_PRO(10);
        // 设置最小间距
        flowLayout.minimumInteritemSpacing = WIDTH_PRO(10);
        
        // 设置格子大小
        flowLayout.itemSize = CGSizeMake(WIDTH_PRO(100), HEIGHT_PRO(130));
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
        [_collectionView registerClass:[ZWHTiketCollectionViewCell class] forCellWithReuseIdentifier:@"ZWHTiketCollectionViewCell"];
    }
    return _collectionView;
}

-(SDCycleScrollView *)topScrView{
    if (!_topScrView) {
        NSArray *array = @[[UIImage imageNamed:@"ceshi_3_1"]];
        _topScrView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(220)) delegate:self placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
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
