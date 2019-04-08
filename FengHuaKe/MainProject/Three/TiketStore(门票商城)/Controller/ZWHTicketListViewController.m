//
//  ZWHTicketListViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/22.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHTicketListViewController.h"
#import "ZWHCityModel.h"
#import "ZWHTicketTableViewCell.h"
#import "ZWHTicketDetailViewController.h"

@interface ZWHTicketListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)UITableView *ticketTable;

@property(nonatomic,assign)NSString *cityCode;

@property(nonatomic,strong)UIView *sectionView;

@end

@implementation ZWHTicketListViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //[IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索结果";
    [self setUI];
}

-(void)setUI{
    
    self.dataArray = [NSMutableArray array];
    self.index = 1;
    
    
    _ticketTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-HEIGHT_PRO(50)) style:UITableViewStylePlain];
    [self.view addSubview:_ticketTable];
    [_ticketTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(ZWHNavHeight);
    }];
    _ticketTable.delegate = self;
    _ticketTable.dataSource = self;
    _ticketTable.separatorStyle = 0;
    _ticketTable.backgroundColor = LINECOLOR;
    _ticketTable.showsVerticalScrollIndicator = NO;
    [_ticketTable registerClass:[ZWHTicketTableViewCell class] forCellReuseIdentifier:@"ZWHTicketTableViewCell"];
    self.keyTableView = _ticketTable;
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
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //[dict setValue:self.cityCode forKey:@"para2"];
    [dict setValue:@"1" forKey:@"para4"];
    if (_secode.length>0) {
        [dict setValue:_secode forKey:@"para1"];
    }
    if (_searchName.length>0) {
        [dict setValue:_searchName forKey:@"para5"];
    }
    
    MJWeakSelf
    [HttpHandler getTicketList:dict start:startIndex end:@10 querytype:@"0" Success:^(id obj) {
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
        if (weakSelf.dataArray.count==0) {
            weakSelf.ticketTable.mj_footer.hidden = YES;
            weakSelf.sectionView.hidden = YES;
            [weakSelf showEmptyViewWithImage:[UIImage imageNamed:@"nodata"] text:@"" detailText:@"" buttonTitle:@"" buttonAction:nil];
            //weakSelf.emptyView.backgroundColor = [UIColor whiteColor];
        }
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
    //[_ticketTable.mj_header beginRefreshing];
    [weakSelf getCityCode];
}

#pragma mark - uitabledelegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HEIGHT_PRO(40);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    _sectionView = [[UIView alloc]init];
    _sectionView.backgroundColor = LINECOLOR;
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [_sectionView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(_sectionView);
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
        make.left.right.bottom.equalTo(_sectionView);
        make.height.mas_equalTo(1);
    }];
    
    return _sectionView;
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
    
    if (scrollView == _ticketTable) {
        
        CGFloat navhig = ISIphoneX==0?64.0f:88.0f;
        
        //让组标题悬停
        if (scrollView.contentOffset.y >= navhig) {
            scrollView.contentInset = UIEdgeInsetsMake(navhig, 0, 0, 0);
        }else{
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
    }
}


@end
