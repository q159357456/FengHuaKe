//
//  ZWHMyinsuranceListViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/9/7.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHMyinsuranceListViewController.h"
#import "InsuranceModel.h"
#import "ZWHMyinsuranceTableViewCell.h"

@interface ZWHMyinsuranceListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *orderTable;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger index;

@end

@implementation ZWHMyinsuranceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setRefresh];
}

-(void)setUI{
    
    _dataArray = [NSMutableArray array];
    _index = 1;
    
    
    _orderTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-ZWHNavHeight-100) style:UITableViewStylePlain];
    [self.view addSubview:_orderTable];
    [_orderTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    _orderTable.delegate = self;
    _orderTable.dataSource = self;
    _orderTable.separatorStyle = 0;
    _orderTable.backgroundColor = LINECOLOR;
    [_orderTable registerClass:[ZWHMyinsuranceTableViewCell class] forCellReuseIdentifier:@"ZWHMyinsuranceTableViewCell"];
    self.keyTableView = _orderTable;
}

#pragma mark - 网络请求
-(void)getDataSource{
    NSNumber *startIndex = [NSNumber numberWithInteger:_index];
    MJWeakSelf
    
    
    [HttpHandler getPOList:@{@"para1":UniqUserID,@"para2":userType,@"intresult":@"0",@"para3":@"insure"} start:startIndex end:@10 querytype:@"0" Success:^(id obj) {
        NSLog(@"%@",obj);
        if (ReturnValue == 1) {
            NSArray *ary = obj[@"DataList"];
            NSLog(@"%@",ary);
            if (ary.count == 0) {
                [weakSelf.orderTable.mj_header endRefreshing];
                weakSelf.orderTable.mj_footer.hidden = YES;
            }else{
                [InsuranceModel mj_objectClassInArray];
                [weakSelf.dataArray addObjectsFromArray: [InsuranceModel mj_objectArrayWithKeyValuesArray:ary]];
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
    return _dataArray.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_PRO(90);
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWHMyinsuranceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHMyinsuranceTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = 0;
    cell.model = _dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}



@end
