//
//  ZWHOrderListViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/8.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHOrderListViewController.h"
#import "ZWHOrderListTableViewCell.h"
#import "ZWHOrderModel.h"
#import "ZWHOrderListModel.h"
#import "ZWHOrderDetailViewController.h"
#import "ZWHOrderPayViewController.h"

@interface ZWHOrderListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *orderTable;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger index;


@end

@implementation ZWHOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    [self setRefresh];
    NOTIFY_ADD(refreshWith:, NOTIFICATION_ORDERLIST);
}

-(void)refreshWith:(NSNotification *)noti{
    if (_state==0 || _state==1) {
        NSLog(@"刷新");
        [_orderTable.mj_header beginRefreshing];
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
    [_orderTable registerClass:[ZWHOrderListTableViewCell class] forCellReuseIdentifier:@"ZWHOrderListTableViewCell"];
}

-(void)getDataSource{
        NSNumber *startIndex = [NSNumber numberWithInteger:_index];
        MJWeakSelf
    [HttpHandler getPOList:@{@"para1":UniqUserID,@"para2":userType,@"intresult":@(_state),@"para3":_poType} start:startIndex end:@10 querytype:@"0" Success:^(id obj) {
            NSLog(@"%@",obj);
            if (ReturnValue == 1) {
                NSArray *ary = obj[@"DataList"];
                if (ary.count == 0) {
                    [weakSelf.orderTable.mj_header endRefreshing];
                    weakSelf.orderTable.mj_footer.hidden = YES;
                }else{
                    [ZWHOrderModel mj_objectClassInArray];
                    [weakSelf.dataArray addObjectsFromArray: [ZWHOrderModel mj_objectArrayWithKeyValuesArray:ary]];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ZWHOrderModel *model = _dataArray[section];
    return model.OrderDetail.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_PRO(80);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HEIGHT_PRO(40);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return HEIGHT_PRO(60);
}

//显示订单号
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    ZWHOrderModel *model = _dataArray[section];
    
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

//显示合计 操作
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    ZWHOrderModel *model = _dataArray[section];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(70))];
    view.backgroundColor = [UIColor whiteColor];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = LINECOLOR;
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(view);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *lab = [[UILabel alloc]init];
    lab.font = HTFont(24);
    lab.text = @"共1件商品 合计:¥100(包含运费¥30)";
    lab.text = [NSString stringWithFormat:@"共%@件商品 合计:¥%@(包含运费¥5)",model.totalnum,model.totalamount];
    lab.textAlignment = NSTextAlignmentRight;
    [view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-WIDTH_PRO(8));
        make.top.equalTo(view).offset(HEIGHT_PRO(3));
        make.left.equalTo(view).offset(WIDTH_PRO(8));
    }];
    
    UIView *midline = [[UIView alloc]init];
    midline.backgroundColor = LINECOLOR;
    [view addSubview:midline];
    [midline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view);
        make.height.mas_equalTo(1);
        make.top.equalTo(lab.mas_bottom).offset(HEIGHT_PRO(3));
    }];
    
    //左 中 右 三个按钮
    UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setdefaultBtnWith:rightbtn];
    [view addSubview:rightbtn];
    [rightbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(midline).offset(HEIGHT_PRO(5));
        make.height.mas_offset(HEIGHT_PRO(30));
        make.width.mas_offset(WIDTH_PRO(70));
        make.right.equalTo(view).offset(-WIDTH_PRO(8));
    }];
    
    UIButton *centerbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setdefaultBtnWith:centerbtn];
    [view addSubview:centerbtn];
    [centerbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(rightbtn);
        make.height.mas_offset(HEIGHT_PRO(30));
        make.width.mas_offset(WIDTH_PRO(70));
        make.right.equalTo(rightbtn.mas_left).offset(-WIDTH_PRO(8));
    }];
    
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setdefaultBtnWith:leftbtn];
    [view addSubview:leftbtn];
    [leftbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(rightbtn);
        make.height.mas_offset(HEIGHT_PRO(30));
        make.width.mas_offset(WIDTH_PRO(70));
        make.right.equalTo(centerbtn.mas_left).offset(-WIDTH_PRO(8));
    }];
    
    rightbtn.tag = section;
    centerbtn.tag = section;
    leftbtn.tag = section;
    [rightbtn addTarget:self action:@selector(rightBtnMethodWith:) forControlEvents:UIControlEventTouchUpInside];
    [centerbtn addTarget:self action:@selector(centerBtnMethodWith:) forControlEvents:UIControlEventTouchUpInside];
    [leftbtn addTarget:self action:@selector(leftBtnMethodWith:) forControlEvents:UIControlEventTouchUpInside];
    [leftbtn setTitle:@"申请售后" forState:0];
    [centerbtn setTitle:@"评价晒单" forState:0];
    [rightbtn setTitle:@"再次购买" forState:0];
    [self setblueBtnWith:rightbtn];
    
    switch ([model.status integerValue]) {
        case 1:
            {
                [rightbtn setTitle:@"付款" forState:0];
                rightbtn.layer.borderColor = MAINCOLOR.CGColor;
                rightbtn.layer.borderWidth = 1;
                rightbtn.backgroundColor = [UIColor whiteColor];
                [rightbtn setTitleColor:MAINCOLOR forState:0];
                leftbtn.hidden = YES;
                centerbtn.hidden = YES;
            }
            break;
        case 2:
        {
            leftbtn.hidden = YES;
            centerbtn.hidden = YES;
        }
            break;
        case 3:
        {
            leftbtn.hidden = YES;
            centerbtn.hidden = YES;
        }
            break;
        case 4:
        {
            
        }
            break;
        case 9:
        {
            leftbtn.hidden = YES;
        }
            break;
        default:
            break;
    }
    
    
    return view;
}

//暗色设置
-(void)setdefaultBtnWith:(UIButton *)btn{
    [btn setTitleColor:ZWHCOLOR(@"#676D7A") forState:0];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [ZWHCOLOR(@"#676D7A") CGColor];
    btn.titleLabel.font = HTFont(28);
}

//蓝色设置
-(void)setblueBtnWith:(UIButton *)btn{
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [ZWHCOLOR(@"#4BA4FF") CGColor];
    btn.titleLabel.font = HTFont(28);
    btn.backgroundColor = ZWHCOLOR(@"#4BA4FF");
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWHOrderListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHOrderListTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = 0;
    if (_dataArray.count > 0) {
        ZWHOrderModel *model = _dataArray[indexPath.section];
        ZWHOrderListModel *listmodel = model.OrderDetail[indexPath.row];
        cell.model = listmodel;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWHOrderDetailViewController *vc = [[ZWHOrderDetailViewController alloc]init];
    //vc.state = _state;
    vc.model = _dataArray[indexPath.section];
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - 左 中 右 点击事件
-(void)rightBtnMethodWith:(UIButton *)btn{
    ZWHOrderModel *model = _dataArray[btn.tag];
    NSInteger modelState = [model.status integerValue];
    switch (modelState) {
        case 1:
            [self payOrderWith:@[model]];
            break;
        default:
            break;
    }
}

-(void)centerBtnMethodWith:(UIButton *)btn{
    
}

-(void)leftBtnMethodWith:(UIButton *)btn{
    ZWHOrderModel *model = _dataArray[btn.tag];
    NSInteger modelState = [model.status integerValue];
    switch (modelState) {
        case 4:
        {
            ZWHOrderDetailViewController *vc = [[ZWHOrderDetailViewController alloc]init];
            vc.model = model;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}


#pragma mark - 支付 取消 评价 售后 再次购买
-(void)payOrderWith:(NSArray *)modelArr{
    ZWHOrderPayViewController *vc = [[ZWHOrderPayViewController alloc]init];
    vc.state = 0;
    vc.orderModelList = modelArr;
    [self.navigationController pushViewController:vc animated:YES];
}




@end
