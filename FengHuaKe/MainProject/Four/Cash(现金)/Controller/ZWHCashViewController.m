//
//  ZWHCashViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/7/31.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHCashViewController.h"
#import "ZWHCashNTableViewCell.h"
#import "ZWHBillModel.h"

@interface ZWHCashViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *cashTable;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger index;

//现金
@property(nonatomic,strong)QMUILabel *moneyL;
//佣金
@property(nonatomic,strong)QMUILabel *brokerageL;
//本金
@property(nonatomic,strong)QMUILabel *msbenL;
//赠金
@property(nonatomic,strong)QMUILabel *mszengL;


@end

@implementation ZWHCashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"现金";
    [self setUI];
    [self setRefresh];
}

#pragma mark - 网络请求
-(void)getDataSource{
    NSNumber *startIndex = [NSNumber numberWithInteger:_index];
    MJWeakSelf
    [HttpHandler getBillCash:@{@"para1":UniqUserID,@"para2":userType,@"para3":@"",@"para4":@""} start:startIndex end:@10 querytype:@"0" Success:^(id obj) {
        NSLog(@"%@",obj);
        NSString *str = obj[@"sysmodel"][@"strresult"];
        NSDictionary *strrDict = [HttpTool getArrayWithData:str][0];
        [weakSelf refreshHeaderWith:[HttpTool takeOffNullWithDict:strrDict]];
        NSArray *ary = obj[@"DataList"];
        if (ary.count == 0) {
            [weakSelf.cashTable.mj_header endRefreshing];
            [weakSelf.cashTable.mj_footer endRefreshingWithNoMoreData];
        }else{
            [weakSelf.dataArray addObjectsFromArray: [ZWHBillModel mj_objectArrayWithKeyValuesArray:ary]];
            [weakSelf.cashTable.mj_header endRefreshing];
            [weakSelf.cashTable.mj_footer endRefreshing];
        }
        [weakSelf.cashTable reloadData];
    } failed:^(id obj) {
        [weakSelf.cashTable.mj_header endRefreshing];
        [weakSelf.cashTable.mj_footer endRefreshing];
    }];
}

-(void)setRefresh{
    MJWeakSelf
    _cashTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.dataArray = [NSMutableArray array];
        weakSelf.index = 1;
        [weakSelf getDataSource];
    }];
    _cashTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.index ++ ;
        [weakSelf getDataSource];
    }];
    [_cashTable.mj_header beginRefreshing];
}

//刷新头部视图信息
-(void)refreshHeaderWith:(NSDictionary *)dict{
    //@[_brokerageL,_msbenL,_mszengL]
    _brokerageL.text = [NSString stringWithFormat:@"佣金收入:\n¥%@",dict[@"brokerage"]];
    _msbenL.text = [NSString stringWithFormat:@"充值本金:\n¥%@",dict[@"MS028"]];
    _mszengL.text = [NSString stringWithFormat:@"充值赠金:\n¥%@",dict[@"MS029"]];
    _moneyL.text = [NSString stringWithFormat:@"¥%@",dict[@"cash"]];
}


#pragma mark - 加载UI
-(void)setUI{
    _dataArray = [NSMutableArray array];
    _index = 1;
    _cashTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-ZWHNavHeight-100) style:UITableViewStylePlain];
    [self.view addSubview:_cashTable];
    [_cashTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    _cashTable.delegate = self;
    _cashTable.dataSource = self;
    _cashTable.separatorStyle = 0;
    [_cashTable registerClass:[ZWHCashNTableViewCell class] forCellReuseIdentifier:@"ZWHCashNTableViewCell"];
    [self setHeaderView];
}

-(void)setHeaderView{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(150))];
    _cashTable.tableHeaderView = backView;
    
    
    
    //我的余额(元)
    UILabel *lab = [[UILabel alloc]init];
    lab.textColor = ZWHCOLOR(@"#676D7A");
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"我的余额(元)";
    lab.font = HTFont(28);
    [backView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(HEIGHT_PRO(8));
        make.centerX.equalTo(backView);
    }];
    
    //金额
    _moneyL = [[QMUILabel alloc]init];
    _moneyL.textColor = ZWHCOLOR(@"#4BA4FF");
    _moneyL.textAlignment = NSTextAlignmentCenter;
    _moneyL.text = @"¥128.0";
    _moneyL.font = HTFont(68);
    [backView addSubview:_moneyL];
    [_moneyL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab.mas_bottom);
        make.centerX.equalTo(backView);
    }];
    
    //横条背景
    UILabel *midline = [[UILabel alloc]init];
    midline.backgroundColor = ZWHCOLOR(@"#E5E5E5");
    [backView addSubview:midline];
    [midline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_moneyL.mas_bottom).offset(HEIGHT_PRO(5));
        make.left.right.equalTo(backView);
        make.height.mas_equalTo(HEIGHT_PRO(35));
    }];
    
    //横条三个按钮
    _brokerageL = [[QMUILabel alloc]init];
    _msbenL = [[QMUILabel alloc]init];
    _mszengL = [[QMUILabel alloc]init];
    NSArray *labArr = @[_brokerageL,_msbenL,_mszengL];
    for (int i=0; i<labArr.count; i++) {
        QMUILabel *qmlab = labArr[i];
        qmlab.text = @"";
        qmlab.textAlignment = NSTextAlignmentCenter;
        qmlab.font = HTFont(24);
        [midline addSubview:qmlab];
        CGFloat wid = SCREEN_WIDTH/3;
        [qmlab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(wid*i);
            make.width.mas_equalTo(wid);
            make.centerY.equalTo(midline);
        }];
        qmlab.numberOfLines = 2;
    }
    
    //充值 提现
    NSArray *nameArr = @[@"充值",@"提现"];
    NSArray *imgArr = @[@"WechatIMG6",@"WechatIMG5"];
    for (int i=0; i<nameArr.count; i++) {
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imgArr[i]]];
        [backView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(i==0?WIDTH_PRO(58):WIDTH_PRO(257));
            make.width.height.mas_equalTo(WIDTH_PRO(30));
            make.top.equalTo(midline.mas_bottom).offset(HEIGHT_PRO(3));
        }];
        
        UILabel *namelab = [[UILabel alloc]init];
        namelab.text = nameArr[i];
        namelab.font = HTFont(32);
        [backView addSubview:namelab];
        [namelab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(img.mas_right);
            make.centerY.equalTo(img);
        }];
        
        
        QMUIButton *btn = [[QMUIButton alloc]init];
        btn.backgroundColor = [UIColor clearColor];
        [backView addSubview:btn];
        CGFloat wid = SCREEN_WIDTH/2;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(wid);
            make.top.equalTo(midline.mas_bottom);
            //make.bottom.equalTo(topline.mas_top);
            make.height.mas_equalTo(HEIGHT_PRO(40));
            make.left.equalTo(backView).offset(wid*i);
        }];
    }
    
    
    
    //底部灰线
    UILabel *topline = [[UILabel alloc]init];
    topline.backgroundColor = ZWHCOLOR(@"#F9F9F9");
    [backView addSubview:topline];
    [topline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backView);
        make.left.right.equalTo(backView);
        make.height.mas_equalTo(HEIGHT_PRO(10));
    }];
    
    //间隔
    UILabel *dashline = [[UILabel alloc]init];
    dashline.backgroundColor = ZWHCOLOR(@"#E5E5E5");
    [backView addSubview:dashline];
    [dashline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(HEIGHT_PRO(30));
        make.centerX.equalTo(backView);
        make.width.mas_equalTo(1);
        make.top.equalTo(midline.mas_bottom).offset(HEIGHT_PRO(3));
    }];
    
    //绑定支付宝账号
    UIButton *bindingB = [UIButton buttonWithType:UIButtonTypeCustom];
    [bindingB setTitleColor:ZWHCOLOR(@"#676D7A") forState:UIControlStateNormal];
    [bindingB setTitle:@"点击绑定支付宝账号>" forState:UIControlStateNormal];
    bindingB.contentHorizontalAlignment = 2;
    bindingB.titleLabel.font = HTFont(24);
    [backView addSubview:bindingB];
    [bindingB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-WIDTH_PRO(8));
        make.bottom.equalTo(midline.mas_top);
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
    cell.state = @"0";//表示消费记录状态
    if (self.dataArray.count>0) {
        cell.model = self.dataArray[indexPath.row];
    }
    return cell;
}


@end
