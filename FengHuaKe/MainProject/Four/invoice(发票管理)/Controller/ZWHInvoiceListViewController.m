//
//  ZWHInvoiceListViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/6.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHInvoiceListViewController.h"
#import "ZWHInvoiceTableViewCell.h"
#import "ZWHAddInvoiceViewController.h"
#import "ZWHInvoiceModel.h"

@interface ZWHInvoiceListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *invoiceTable;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger index;

@end

@implementation ZWHInvoiceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发票管理";
    [self setUI];
    [self setTableFooterView];
    [self setRefresh];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(invoiceRefresh) name:@"invoiceRefresh" object:nil];
}

-(void)invoiceRefresh{
    [self.invoiceTable.mj_header beginRefreshing];
}

#pragma mark - 网络请求
-(void)getDataSource{
    NSNumber *startIndex = [NSNumber numberWithInteger:_index];
    MJWeakSelf
    [HttpHandler getInvoiceList:@{@"para1":UniqUserID,@"para2":userType} start:startIndex end:@10 querytype:@"0" Success:^(id obj) {
        NSLog(@"%@",obj);
        if (ReturnValue == 1) {
            NSArray *ary = obj[@"DataList"];
            if (ary.count == 0) {
                [weakSelf.invoiceTable.mj_header endRefreshing];
                [weakSelf.invoiceTable.mj_footer endRefreshingWithNoMoreData];
            }else{
                [weakSelf.dataArray addObjectsFromArray: [ZWHInvoiceModel mj_objectArrayWithKeyValuesArray:ary]];
                [weakSelf.invoiceTable.mj_header endRefreshing];
                [weakSelf.invoiceTable.mj_footer endRefreshing];
            }
            [weakSelf.invoiceTable reloadData];
        }
    } failed:^(id obj) {
        [weakSelf.invoiceTable.mj_header endRefreshing];
        [weakSelf.invoiceTable.mj_footer endRefreshing];
    }];
}

-(void)setRefresh{
    MJWeakSelf
    _invoiceTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.dataArray = [NSMutableArray array];
        weakSelf.index = 1;
        [weakSelf getDataSource];
    }];
    _invoiceTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.index ++ ;
        [weakSelf getDataSource];
    }];
    [_invoiceTable.mj_header beginRefreshing];
}

-(void)setUI{
    _dataArray = [NSMutableArray array];
    _index = 1;
    _invoiceTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-ZWHNavHeight-100) style:UITableViewStyleGrouped];
    [self.view addSubview:_invoiceTable];
    [_invoiceTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-HEIGHT_PRO(45));
    }];
    _invoiceTable.delegate = self;
    _invoiceTable.dataSource = self;
    _invoiceTable.separatorStyle = 0;
    _invoiceTable.backgroundColor = LINECOLOR;
    _invoiceTable.estimatedRowHeight = 100;
    _invoiceTable.rowHeight = UITableViewAutomaticDimension;
    [_invoiceTable registerClass:[ZWHInvoiceTableViewCell class] forCellReuseIdentifier:@"ZWHInvoiceTableViewCell"];
}

//底部按钮
-(void)setTableFooterView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(45))];
    view.backgroundColor = LINECOLOR;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    [btn setTitle:@"添加新公司" forState:0];
    btn.backgroundColor = ZWHCOLOR(@"#4BA4FF");
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(addNewAdressWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WIDTH_PRO(220));
        make.height.mas_equalTo(HEIGHT_PRO(37));
        make.bottom.equalTo(view.mas_bottom);
        make.centerX.equalTo(view);
    }];
    
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(HEIGHT_PRO(45));
    }];
    
}

#pragma mark - 添加新地址
-(void)addNewAdressWithBtn:(UIButton *)btn{
    ZWHAddInvoiceViewController *vc = [[ZWHAddInvoiceViewController alloc]init];
    vc.title = @"新增公司";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - uitabledelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HEIGHT_PRO(5);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return HEIGHT_PRO(5);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = LINECOLOR;
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = LINECOLOR;
    return view;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZWHInvoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHInvoiceTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = 0;
    if (self.dataArray.count>0) {
        cell.model = self.dataArray[indexPath.section];
        cell.setdefaultB.tag = indexPath.section+100;
        cell.editB.tag = indexPath.section+100;
        cell.deleteB.tag = indexPath.section+100;
        [cell.setdefaultB addTarget:self action:@selector(setDefaultWithBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.editB addTarget:self action:@selector(editWithBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.deleteB addTarget:self action:@selector(deleteWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - 设置默认 编辑 删除

//设置默认
-(void)setDefaultWithBtn:(UIButton *)btn{
    ZWHInvoiceModel *model = _dataArray[btn.tag-100];
    MJWeakSelf
    [HttpHandler getInvoiceSetDefault:@{@"para1":UniqUserID,@"para2":userType,@"para3":model.code} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        if (ReturnValue==1) {
            [self showHint:@"设置成功"];
            [weakSelf.invoiceTable.mj_header beginRefreshing];
        }
    } failed:^(id obj) {
        [self showHint:@"设置失败"];
    }];
}

//编辑
-(void)editWithBtn:(UIButton *)btn{
    ZWHAddInvoiceViewController *vc = [[ZWHAddInvoiceViewController alloc]init];
    vc.myModel = _dataArray[btn.tag - 100];
    [self.navigationController pushViewController:vc animated:YES];
}

//删除
-(void)deleteWithBtn:(UIButton *)btn{
    ZWHInvoiceModel *model = _dataArray[btn.tag-100];
    MJWeakSelf
    [HttpHandler getInvoiceDelete:@{@"para1":UniqUserID,@"para2":userType,@"para3":model.code} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        if (ReturnValue == 1) {
            [self showHint:@"删除成功"];
            [weakSelf.invoiceTable.mj_header beginRefreshing];
        }
    } failed:^(id obj) {
        
    }];
}


@end
