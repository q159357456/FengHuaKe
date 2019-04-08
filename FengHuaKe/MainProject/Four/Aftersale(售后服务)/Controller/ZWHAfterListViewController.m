//
//  ZWHAfterListViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/30.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHAfterListViewController.h"
#import "ZWHOrderListTableViewCell.h"
#import "ZWHAfterListTableViewCell.h"
#import "ZWHAfterSaleViewController.h"

@interface ZWHAfterListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *orderTable;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger index;

@end

@implementation ZWHAfterListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setRefresh];
    NOTIFY_ADD(refreshList, NOTIF_AFTER);
}

#pragma mark - 通知刷新
-(void)refreshList{
    if ([_state isEqualToString:@""]||[_state isEqualToString:@"A"]) {
        [self.orderTable.mj_header beginRefreshing];
    }
}

-(void)dealloc{
    NOTIFY_REMOVEALL;
}

-(void)setUI{
    
    _dataArray = [NSMutableArray array];
    _index = 1;
    
    
    _orderTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-ZWHNavHeight-100) style:UITableViewStyleGrouped];
    [self.view addSubview:_orderTable];
    [_orderTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    _orderTable.delegate = self;
    _orderTable.dataSource = self;
    _orderTable.separatorStyle = 0;
    _orderTable.backgroundColor = [UIColor whiteColor];
    [_orderTable registerClass:[ZWHAfterListTableViewCell class] forCellReuseIdentifier:@"ZWHAfterListTableViewCell"];
    self.keyTableView = _orderTable;
}

#pragma mark - 网络请求
-(void)getDataSource{
    NSNumber *startIndex = [NSNumber numberWithInteger:_index];
    MJWeakSelf
    
    
    if (_state.length>0) {
        [HttpHandler getPOServiceList:@{@"para1":UniqUserID,@"para2":userType,@"para3":_state} start:startIndex end:@10 querytype:@"0" Success:^(id obj) {
            NSLog(@"%@",obj);
            if (ReturnValue == 1) {
                NSArray *ary = obj[@"DataList"];
                if (ary.count == 0) {
                    [weakSelf.orderTable.mj_header endRefreshing];
                    weakSelf.orderTable.mj_footer.hidden = YES;
                }else{
                    [weakSelf.dataArray addObjectsFromArray: [ZWHOrderListModel mj_objectArrayWithKeyValuesArray:ary]];
                    [weakSelf.orderTable.mj_header endRefreshing];
                    [weakSelf.orderTable.mj_footer endRefreshing];
                    weakSelf.orderTable.mj_footer.hidden = NO;
                }
                [weakSelf.orderTable reloadData];
                if (weakSelf.dataArray.count==0) {
                    [weakSelf showEmptyViewWithImage:[UIImage imageNamed:@"nodata"] text:@"" detailText:@"" buttonTitle:@"" buttonAction:nil];
                    weakSelf.emptyView.backgroundColor = [UIColor whiteColor];
                    //weakSelf.emptyView.userInteractionEnabled = NO;
                }else{
                    [weakSelf hideEmptyView];
                }
            }
        } failed:^(id obj) {
            [weakSelf.orderTable.mj_header endRefreshing];
            [weakSelf.orderTable.mj_footer endRefreshing];
        }];
    }else{
        [HttpHandler getPOServiceLicence:@{@"para1":UniqUserID,@"para2":userType} start:startIndex end:@10 querytype:@"0" Success:^(id obj) {
            NSLog(@"%@",obj);
            if (ReturnValue == 1) {
                NSArray *ary = obj[@"DataList"];
                if (ary.count == 0) {
                    [weakSelf.orderTable.mj_header endRefreshing];
                    weakSelf.orderTable.mj_footer.hidden = YES;
                }else{
                    [weakSelf.dataArray addObjectsFromArray: [ZWHOrderListModel mj_objectArrayWithKeyValuesArray:ary]];
                    [weakSelf.orderTable.mj_header endRefreshing];
                    [weakSelf.orderTable.mj_footer endRefreshing];
                    weakSelf.orderTable.mj_footer.hidden = NO;
                }
                [weakSelf.orderTable reloadData];
                if (weakSelf.dataArray.count==0) {
                    [weakSelf showEmptyViewWithImage:[UIImage imageNamed:@"nodata"] text:@"" detailText:@"" buttonTitle:@"" buttonAction:nil];
                    weakSelf.emptyView.backgroundColor = [UIColor whiteColor];
                }else{
                    [weakSelf hideEmptyView];
                }
            }
        } failed:^(id obj) {
            [weakSelf.orderTable.mj_header endRefreshing];
            [weakSelf.orderTable.mj_footer endRefreshing];
        }];
    }
    
    
}

-(void)setRefresh{
    MJWeakSelf
    _orderTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.dataArray = [NSMutableArray array];
        weakSelf.index = 1;
        [weakSelf getDataSource];
    }];
   
    _orderTable.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        weakSelf.index ++ ;
        [weakSelf getDataSource];
    }];
    [_orderTable.mj_header beginRefreshing];
}

#pragma mark - uitabledelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_PRO(80);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HEIGHT_PRO(40);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

//显示订单号
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    ZWHOrderListModel *model = _dataArray[section];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(40))];
    view.backgroundColor = [UIColor whiteColor];
    
    UIView *butomLineZWH = [[UIView alloc]init];
    butomLineZWH.backgroundColor = LINECOLOR;
    [view addSubview:butomLineZWH];
    [butomLineZWH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(view);
        make.height.mas_equalTo(1);
    }];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(10))];
    line.backgroundColor = LINECOLOR;
    [view addSubview:line];
    
    UILabel *lab = [[UILabel alloc]init];
    lab.font = HTFont(28);
    lab.text = [NSString stringWithFormat:@"订单号:%@",model.billno];
    [view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(WIDTH_PRO(8));
        make.bottom.equalTo(view).offset(-HEIGHT_PRO(3));
        make.right.equalTo(view).offset(-WIDTH_PRO(8));
    }];
    
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWHAfterListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHAfterListTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = 0;
    cell.model = _dataArray[indexPath.section];
    cell.aftersale.hidden = [_state isEqualToString:@"C"]?YES:NO;
    if (!cell.aftersale.hidden) {
        if ([_state isEqualToString:@""]) {
            cell.aftersale.tag = indexPath.section;
            [cell.aftersale addTarget:self action:@selector(aftersaleMethod:) forControlEvents:UIControlEventTouchUpInside];
        }else if([_state isEqualToString:@"A"]){
            cell.aftersale.backgroundColor = [UIColor whiteColor];
            [cell.aftersale setTitleColor:[UIColor redColor] forState:0];
            cell.aftersale.userInteractionEnabled = NO;
            [cell.aftersale setTitle:@"正在处理" forState:0];
            cell.aftersale.layer.borderWidth = 0;
        }else if ([_state isEqualToString:@"B"]){
            cell.aftersale.tag = indexPath.section;
            [cell.aftersale setTitle:@"评价" forState:0];
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_state isEqualToString:@""]) {
        ZWHOrderListModel *model = _dataArray[indexPath.section];
        ZWHAfterSaleViewController *vc = [[ZWHAfterSaleViewController alloc]init];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([_state isEqualToString:@"A"] || [_state isEqualToString:@"C"]){
        [self showEmptyViewWithLoading];
        MJWeakSelf;
        ZWHOrderListModel *model = _dataArray[indexPath.section];
        [HttpHandler getPOServiceSingle:@{@"para1":UniqUserID,@"para2":userType,@"para3":model.shopid,@"para4":model.sellno} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
            [weakSelf hideEmptyView];
            if (ReturnValue==1) {
                NSArray *ary = obj[@"DataList"];
                if (ary.count>0) {
                    [ZWHOrderListModel mj_objectClassInArray];
                    ZWHOrderListModel *listmodel = [ZWHOrderListModel mj_objectArrayWithKeyValuesArray:ary][0];
                    ZWHAfterSaleViewController *vc = [[ZWHAfterSaleViewController alloc]init];
                    vc.Aftermodel = listmodel;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
        } failed:^(id obj) {
            [weakSelf hideEmptyView];
        }];
    }
}
#pragma mark - 申请售后
-(void)aftersaleMethod:(UIButton *)btn{
    ZWHOrderListModel *model = _dataArray[btn.tag];
    ZWHAfterSaleViewController *vc = [[ZWHAfterSaleViewController alloc]init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
