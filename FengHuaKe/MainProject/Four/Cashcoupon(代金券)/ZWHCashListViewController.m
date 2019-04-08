//
//  ZWHCashListViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/7/30.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHCashListViewController.h"
#import "ZWHCashListTableViewCell.h"
#import "ZWHCashcoupon.h"
#import "ZWHCashcouponViewController.h"

@interface ZWHCashListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *cashListTable;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger index;

//状态
@property(nonatomic,strong)NSString *stateStr;

@end

@implementation ZWHCashListViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%ld",_stateIndex);
    self.view.backgroundColor = ZWHCOLOR(@"#F9F9F9");
    self.view.backgroundColor = [UIColor redColor];
    [self setUI];
    [self setRefresh];
}


-(void)getDataSource{
    NSNumber *startIndex = [NSNumber numberWithInteger:_index];
    switch (_stateIndex) {
        case 0:
            _stateStr = @"N";
            break;
        case 1:
            _stateStr = @"Y";
            break;
        case 2:
            _stateStr = @"V";
            break;
        default:
            break;
    }
    MJWeakSelf
    [HttpHandler getCoupon:@{@"para1":UniqUserID,@"para2":userType,@"para3":_stateStr} start:startIndex end:@10 querytype:@"0" Success:^(id obj) {
        NSArray *ary = obj[@"DataList"];
        if (ary.count == 0) {
            [weakSelf.cashListTable.mj_header endRefreshing];
            [weakSelf.cashListTable.mj_footer endRefreshingWithNoMoreData];
        }else{
            [weakSelf.dataArray addObjectsFromArray: [ZWHCashcoupon mj_objectArrayWithKeyValuesArray:ary]];
            [weakSelf.cashListTable.mj_header endRefreshing];
            [weakSelf.cashListTable.mj_footer endRefreshing];
        }
        [weakSelf.cashListTable reloadData];
    } failed:^(id obj) {
        [weakSelf.cashListTable.mj_header endRefreshing];
        [weakSelf.cashListTable.mj_footer endRefreshing];
    }];
}

-(void)setRefresh{
    //if (_stateIndex == 0) {
        MJWeakSelf
        _cashListTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.dataArray = [NSMutableArray array];
            weakSelf.index = 1;
            [weakSelf getDataSource];
        }];
        _cashListTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakSelf.index ++ ;
            [weakSelf getDataSource];
        }];
        [_cashListTable.mj_header beginRefreshing];
    //}
}

#pragma mark 创建UI
-(void)setUI{
    _dataArray = [NSMutableArray array];
    _index = 1;
    _cashListTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-ZWHNavHeight-100) style:UITableViewStylePlain];
    [self.view addSubview:_cashListTable];
    [_cashListTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    _cashListTable.delegate = self;
    _cashListTable.dataSource = self;
    _cashListTable.separatorStyle = 0;
    _cashListTable.backgroundColor = LINECOLOR;
    [_cashListTable registerClass:[ZWHCashListTableViewCell class] forCellReuseIdentifier:@"ZWHCashListTableViewCell"];
    
}



#pragma mark Uitableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_PRO(160);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWHCashListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHCashListTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.stateIndex = self.stateIndex;
    if (_dataArray.count > 0) {
        cell.model = _dataArray[indexPath.row];
    }
    return cell;
}





@end
