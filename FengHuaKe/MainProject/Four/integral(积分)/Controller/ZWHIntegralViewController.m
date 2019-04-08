//
//  ZWHIntegralViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/1.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHIntegralViewController.h"
#import "ZWHCashNTableViewCell.h"

@interface ZWHIntegralViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *integralTable;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger index;

//积分
@property(nonatomic,strong)QMUILabel *integralL;

@end

@implementation ZWHIntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"积分";
    [self setUI];
    [self setRefresh];
}

#pragma mark - 网络请求
-(void)getDataSource{
    NSNumber *startIndex = [NSNumber numberWithInteger:_index];
    MJWeakSelf
    [HttpHandler getBillIntegral:@{@"para1":UniqUserID,@"para2":userType,@"para3":@"",@"para4":@""} start:startIndex end:@10 querytype:@"0" Success:^(id obj) {
        NSLog(@"%@",obj);
        NSString *str = obj[@"sysmodel"][@"strresult"];
        NSDictionary *strrDict = [HttpTool getArrayWithData:str][0];
        [weakSelf refreshHeaderWith:[HttpTool takeOffNullWithDict:strrDict]];
        NSArray *ary = obj[@"DataList"];
        if (ary.count == 0) {
            [weakSelf.integralTable.mj_header endRefreshing];
            [weakSelf.integralTable.mj_footer endRefreshingWithNoMoreData];
        }else{
            [weakSelf.dataArray addObjectsFromArray: [ZWHBillModel mj_objectArrayWithKeyValuesArray:ary]];
            [weakSelf.integralTable.mj_header endRefreshing];
            [weakSelf.integralTable.mj_footer endRefreshing];
        }
        [weakSelf.integralTable reloadData];
    } failed:^(id obj) {
        [weakSelf.integralTable.mj_header endRefreshing];
        [weakSelf.integralTable.mj_footer endRefreshing];
    }];
}

-(void)setRefresh{
    MJWeakSelf
    _integralTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.dataArray = [NSMutableArray array];
        weakSelf.index = 1;
        [weakSelf getDataSource];
    }];
    _integralTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.index ++ ;
        [weakSelf getDataSource];
    }];
    [_integralTable.mj_header beginRefreshing];
}

//刷新头部视图信息
-(void)refreshHeaderWith:(NSDictionary *)dict{
    _integralL.text = [NSString stringWithFormat:@"%@分",dict[@"integral"]];
}

#pragma mark - 加载UI
-(void)setUI{
    _dataArray = [NSMutableArray array];
    _index = 1;
    _integralTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-ZWHNavHeight-100) style:UITableViewStylePlain];
    [self.view addSubview:_integralTable];
    [_integralTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    _integralTable.delegate = self;
    _integralTable.dataSource = self;
    _integralTable.separatorStyle = 0;
    [_integralTable registerClass:[ZWHCashNTableViewCell class] forCellReuseIdentifier:@"ZWHCashNTableViewCell"];
    [self setHeaderView];
}

-(void)setHeaderView{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(120))];
    backView.backgroundColor = ZWHCOLOR(@"#4BA4FF");
    _integralTable.tableHeaderView = backView;
    
    
    
    //我的积分
    UILabel *lab = [[UILabel alloc]init];
    lab.textColor = ZWHCOLOR(@"#FFFFFF");
    lab.text = @"我的积分";
    lab.font = HTFont(28);
    [backView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(HEIGHT_PRO(15));
        make.left.equalTo(backView).offset(WIDTH_PRO(15));
    }];
    
    //积分显示
    _integralL = [[QMUILabel alloc]init];
    _integralL.textColor = ZWHCOLOR(@"#FFFFFF");
    _integralL.text = @"-";
    _integralL.font = HTFont(80);
    [backView addSubview:_integralL];
    [_integralL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(HEIGHT_PRO(30));
        make.top.equalTo(lab.mas_bottom).offset(HEIGHT_PRO(15));
    }];
    
    //积分明细
    UIButton *detailB = [UIButton buttonWithType:UIButtonTypeCustom];
    [detailB setTitleColor:ZWHCOLOR(@"#FFFFFF") forState:UIControlStateNormal];
    [detailB setTitle:@"积分明细>" forState:0];
    detailB.titleLabel.font = HTFont(28);
    [backView addSubview:detailB];
    [detailB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-WIDTH_PRO(15));
        make.centerY.equalTo(lab);
    }];
    
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"WechatIMG12"]];
    img.contentMode = UIViewContentModeScaleToFill;
    [backView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-WIDTH_PRO(30));
        make.centerY.equalTo(_integralL);
        make.width.height.mas_equalTo(WIDTH_PRO(60));
    }];
    
    
}

#pragma mark - uitabledelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_PRO(60);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWHCashNTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHCashNTableViewCell" forIndexPath:indexPath];
    cell.state = @"1";//表示积分记录状态
    if (self.dataArray.count>0) {
        cell.model = self.dataArray[indexPath.row];
    }
    return cell;
}


@end
