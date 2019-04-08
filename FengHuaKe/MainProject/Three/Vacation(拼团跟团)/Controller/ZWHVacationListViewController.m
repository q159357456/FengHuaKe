//
//  ZWHVacationListViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/27.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHVacationListViewController.h"

#import "ZWHVacationListTableViewCell.h"
#import "TravelListModel.h"
#import "ZWHVacationDetailViewController.h"

@interface ZWHVacationListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger index;

@property(nonatomic,strong)UITableView *listTable;

@end

@implementation ZWHVacationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setRefresh];
}

-(void)setUI{
    self.dataArray = [NSMutableArray array];
    self.index = 1;
    
    _listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-HEIGHT_PRO(50)) style:UITableViewStylePlain];
    [self.view addSubview:_listTable];
    [_listTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(ZWHNavHeight);
    }];
    _listTable.delegate = self;
    _listTable.dataSource = self;
    _listTable.separatorStyle = 0;
    _listTable.backgroundColor = LINECOLOR;
    _listTable.showsVerticalScrollIndicator = NO;
    [_listTable registerClass:[ZWHVacationListTableViewCell class] forCellReuseIdentifier:@"ZWHVacationListTableViewCell"];
    self.keyTableView = _listTable;
    _listTable.estimatedRowHeight = 200;
    _listTable.rowHeight = UITableViewAutomaticDimension;
}

-(void)getDataSource{
    NSNumber *startIndex = [NSNumber numberWithInteger:_index];
    
    MJWeakSelf
    
    //新闻
    [HttpHandler getTravelList:@{@"para1":_code,@"para2":_secode} start:startIndex end:@(10) querytype:@"0" Success:^(id obj) {
        [weakSelf.listTable.mj_header endRefreshing];
        [weakSelf.listTable.mj_footer endRefreshing];
        if (ReturnValue==1) {
            NSArray *ary = obj[@"DataList"];
            if (ary.count == 0) {
                [weakSelf.listTable.mj_footer endRefreshingWithNoMoreData];
            }else{
                [weakSelf.dataArray addObjectsFromArray: [TravelListModel mj_objectArrayWithKeyValuesArray:ary]];
            }
            [weakSelf.listTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            if (weakSelf.dataArray.count==0) {
                weakSelf.listTable.mj_header.hidden = YES;
                weakSelf.listTable.mj_footer.hidden = YES;
                [weakSelf showEmptyViewWithImage:[UIImage imageNamed:@"nodata"] text:@"" detailText:@"" buttonTitle:@"" buttonAction:nil];
            }
        }
    } failed:^(id obj) {
        [weakSelf.listTable.mj_header endRefreshing];
        [weakSelf.listTable.mj_footer endRefreshing];
    }];
    
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
    [self getDataSource];
}



#pragma mark - uitableviewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWHVacationListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHVacationListTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = 0;
    cell.model = _dataArray[indexPath.row];
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TravelListModel *model = _dataArray[indexPath.row];
    ZWHVacationDetailViewController *vc = [[ZWHVacationDetailViewController alloc]init];
    vc.code = model.productno;
    vc.InsuranceCode = _InsuranceCode;
    vc.title = @"景点详情";
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
