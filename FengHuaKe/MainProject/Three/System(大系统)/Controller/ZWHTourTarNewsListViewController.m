//
//  ZWHTourTarNewsListViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/10.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHTourTarNewsListViewController.h"

#import "ZWHTourisTableViewCell.h"
#import "ZWHTravelsTableViewCell.h"
#import "ZWHTravelsLeftTableViewCell.h"
#import "ZWHNewsTableViewCell.h"
#import "CatageModel.h"
#import "CatageDetailWebVC.h"

@interface ZWHTourTarNewsListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *listTable;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger index;

@end

@implementation ZWHTourTarNewsListViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_state==0) {
        self.title = @"旅游攻略";
    }else if (_state==1){
        self.title = @"游记";
    }else{
        self.title = @"新闻";
    }
    [self setUI];
    [self setRefresh];
}

-(void)getDataSource{
    NSNumber *startIndex = [NSNumber numberWithInteger:_index];
    MJWeakSelf
    
    if (_state == 0) {
        [HttpHandler getNewGuides:@{} start:startIndex end:@10 querytype:@"0" Success:^(id obj) {
            NSArray *ary = obj[@"DataList"];
            if (ary.count == 0) {
                [weakSelf.listTable.mj_header endRefreshing];
                [weakSelf.listTable.mj_footer endRefreshingWithNoMoreData];
            }else{
                [weakSelf.dataArray addObjectsFromArray: [CatageModel mj_objectArrayWithKeyValuesArray:ary]];
                [weakSelf.listTable.mj_header endRefreshing];
                [weakSelf.listTable.mj_footer endRefreshing];
            }
            [weakSelf.listTable reloadData];
        } failed:^(id obj) {
            [weakSelf.listTable.mj_header endRefreshing];
            [weakSelf.listTable.mj_footer endRefreshing];
        }];
    }else if(_state == 1){
        [HttpHandler getNewNotes:@{} start:startIndex end:@10 querytype:@"0" Success:^(id obj) {
            NSArray *ary = obj[@"DataList"];
            if (ary.count == 0) {
                [weakSelf.listTable.mj_header endRefreshing];
                [weakSelf.listTable.mj_footer endRefreshingWithNoMoreData];
            }else{
                [weakSelf.dataArray addObjectsFromArray: [CatageModel mj_objectArrayWithKeyValuesArray:ary]];
                [weakSelf.listTable.mj_header endRefreshing];
                [weakSelf.listTable.mj_footer endRefreshing];
            }
            [weakSelf.listTable reloadData];
        } failed:^(id obj) {
            [weakSelf.listTable.mj_header endRefreshing];
            [weakSelf.listTable.mj_footer endRefreshing];
        }];
    }else{
        [HttpHandler getNewNews:@{} start:startIndex end:@10 querytype:@"0" Success:^(id obj) {
            NSArray *ary = obj[@"DataList"];
            if (ary.count == 0) {
                [weakSelf.listTable.mj_header endRefreshing];
                [weakSelf.listTable.mj_footer endRefreshingWithNoMoreData];
            }else{
                [weakSelf.dataArray addObjectsFromArray: [CatageModel mj_objectArrayWithKeyValuesArray:ary]];
                [weakSelf.listTable.mj_header endRefreshing];
                [weakSelf.listTable.mj_footer endRefreshing];
            }
            [weakSelf.listTable reloadData];
        } failed:^(id obj) {
            [weakSelf.listTable.mj_header endRefreshing];
            [weakSelf.listTable.mj_footer endRefreshing];
        }];
    }
}

-(void)setRefresh{
    MJWeakSelf
    _listTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.dataArray = [NSMutableArray array];
        weakSelf.index = 1;
        [weakSelf getDataSource];
    }];
    _listTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.index ++ ;
        [weakSelf getDataSource];
    }];
    [_listTable.mj_header beginRefreshing];
}

#pragma mark 创建UI
-(void)setUI{
    _dataArray = [NSMutableArray array];
    _index = 1;
    _listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-ZWHNavHeight-100) style:UITableViewStylePlain];
    [self.view addSubview:_listTable];
    [_listTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    _listTable.delegate = self;
    _listTable.dataSource = self;
    _listTable.separatorStyle = 0;
    _listTable.backgroundColor = LINECOLOR;
    [_listTable registerClass:[ZWHTourisTableViewCell class] forCellReuseIdentifier:@"ZWHTourisTableViewCell"];
    [_listTable registerClass:[ZWHTravelsTableViewCell class] forCellReuseIdentifier:@"ZWHTravelsTableViewCell"];
    [_listTable registerClass:[ZWHTravelsLeftTableViewCell class] forCellReuseIdentifier:@"ZWHTravelsLeftTableViewCell"];
    [_listTable registerClass:[ZWHNewsTableViewCell class] forCellReuseIdentifier:@"ZWHNewsTableViewCell"];
}



#pragma mark Uitableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_state==0) {
        return HEIGHT_PRO(160);
    }else if (_state==1){
        return HEIGHT_PRO(130);
    }
    return HEIGHT_PRO(90);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_state==0) {
        ZWHTourisTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHTourisTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        cell.model = _dataArray[indexPath.row];
        return cell;
    }else if(_state == 1){
        if (indexPath.row%2!=0) {
            ZWHTravelsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHTravelsTableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = 0;
            cell.model = _dataArray[indexPath.row];
            return cell;
        }else{
            ZWHTravelsLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHTravelsLeftTableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = 0;
            cell.model = _dataArray[indexPath.row];
            return cell;
        }
    }else{
        ZWHNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHNewsTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        cell.model = _dataArray[indexPath.row];
        return cell;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CatageModel *model = _dataArray[indexPath.row];
    CatageDetailWebVC *vc=[[CatageDetailWebVC alloc]init];
    vc.code=model.code;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
