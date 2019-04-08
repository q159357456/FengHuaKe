//
//  ZWHBrokerageViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/1.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHBrokerageViewController.h"
#import "ZWHCashNTableViewCell.h"

@interface ZWHBrokerageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *integralTable;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger index;

//佣金
@property(nonatomic,strong)QMUILabel *brokerageL;

@end

@implementation ZWHBrokerageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"佣金";
    [self setUI];
    [self setRefresh];
}

#pragma mark - 网络请求
-(void)getDataSource{
    NSNumber *startIndex = [NSNumber numberWithInteger:_index];
    MJWeakSelf
    [HttpHandler getBillBrokerage:@{@"para1":UniqUserID,@"para2":userType,@"para3":@"",@"para4":@""} start:startIndex end:@10 querytype:@"0" Success:^(id obj) {
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
    _brokerageL.text = [NSString stringWithFormat:@"¥%@",dict[@"brokerage"]];
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
    
    
    
    //佣金收入
    UILabel *lab = [[UILabel alloc]init];
    lab.textColor = ZWHCOLOR(@"#FFFFFF");
    lab.text = @"佣金收入";
    lab.font = HTFont(28);
    [backView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(HEIGHT_PRO(15));
        make.left.equalTo(backView).offset(WIDTH_PRO(15));
    }];
    
    //佣金显示
    _brokerageL = [[QMUILabel alloc]init];
    _brokerageL.textColor = ZWHCOLOR(@"#FFFFFF");
    _brokerageL.text = @"-";
    _brokerageL.font = HTFont(80);
    [backView addSubview:_brokerageL];
    [_brokerageL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(HEIGHT_PRO(30));
        make.top.equalTo(lab.mas_bottom).offset(HEIGHT_PRO(15));
    }];
    
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"WechatIMG16"]];
    img.contentMode = UIViewContentModeScaleToFill;
    [backView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-WIDTH_PRO(30));
        make.centerY.equalTo(_brokerageL);
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
    cell.state = @"2";//表示佣金记录状态
    if (self.dataArray.count>0) {
        cell.model = self.dataArray[indexPath.row];
    }
    return cell;
}




@end
