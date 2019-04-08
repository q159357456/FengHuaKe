//
//  ZWHOrderDetailViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/8.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHOrderDetailViewController.h"
#import "ZWHOrderListTableViewCell.h"
#import "ZWHOrderAdressTableViewCell.h"
#import "ZWHOrderPayViewController.h"
#import "ZWHAfterSaleViewController.h"

@interface ZWHOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *detailTable;

@end

@implementation ZWHOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _state = [_model.status integerValue];
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    [self setHeader];
    [self setBottomBtn];
    _detailTable.bounces = NO;
}

-(void)setUI{
    
    _detailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-ZWHNavHeight-100) style:UITableViewStyleGrouped];
    [self.view addSubview:_detailTable];
    [_detailTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-HEIGHT_PRO(40));
    }];
    _detailTable.delegate = self;
    _detailTable.dataSource = self;
    _detailTable.separatorStyle = 0;
    _detailTable.backgroundColor = [UIColor whiteColor];
    [_detailTable registerClass:[ZWHOrderListTableViewCell class] forCellReuseIdentifier:@"ZWHOrderListTableViewCell"];
    [_detailTable registerClass:[ZWHOrderAdressTableViewCell class] forCellReuseIdentifier:@"ZWHOrderAdressTableViewCell"];
}

#pragma mark - 设置底部按钮操作
-(void)setBottomBtn{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(40))];
    view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_offset(HEIGHT_PRO(40));
    }];
    
    //左 中 右 三个按钮
    UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setblueBtnWith:rightbtn];
    [view addSubview:rightbtn];
    [rightbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(HEIGHT_PRO(5));
        make.height.mas_offset(HEIGHT_PRO(30));
        make.width.mas_offset(WIDTH_PRO(70));
        make.right.equalTo(view).offset(-WIDTH_PRO(8));
    }];
    
    UIButton *centerbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setblueBtnWith:centerbtn];
    [view addSubview:centerbtn];
    [centerbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(rightbtn);
        make.height.mas_offset(HEIGHT_PRO(30));
        make.width.mas_offset(WIDTH_PRO(70));
        make.right.equalTo(rightbtn.mas_left).offset(-WIDTH_PRO(8));
    }];
    
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setblueBtnWith:leftbtn];
    [view addSubview:leftbtn];
    [leftbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(rightbtn);
        make.height.mas_offset(HEIGHT_PRO(30));
        make.width.mas_offset(WIDTH_PRO(70));
        make.right.equalTo(centerbtn.mas_left).offset(-WIDTH_PRO(8));
    }];
    
    [leftbtn setTitle:@"申请售后" forState:0];
    [centerbtn setTitle:@"评价晒单" forState:0];
    [rightbtn setTitle:@"再次购买" forState:0];
    
    [rightbtn addTarget:self action:@selector(rightBtnMethodWith:) forControlEvents:UIControlEventTouchUpInside];
    [centerbtn addTarget:self action:@selector(centerBtnMethodWith:) forControlEvents:UIControlEventTouchUpInside];
    [leftbtn addTarget:self action:@selector(leftBtnMethodWith:) forControlEvents:UIControlEventTouchUpInside];
    
    switch ([_model.status integerValue]) {
        case 1:
        {
            [rightbtn setTitle:@"立即付款" forState:0];
            leftbtn.hidden = YES;
            [centerbtn setTitle:@"取消订单" forState:0];
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
            leftbtn.hidden = YES;
        }
            break;
        default:
            break;
    }
}

#pragma mark - tableviewHeader
-(void)setHeader{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(100))];
    backView.backgroundColor = ZWHCOLOR(@"4BA4FF");
    
    UILabel *lab = [[UILabel alloc]init];
    lab.font = HTFont(30);
    lab.textColor = ZWHCOLOR(@"#4BA4FF");
    lab.backgroundColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.layer.cornerRadius = WIDTH_PRO(8);
    lab.layer.masksToBounds = YES;
    [backView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(backView).offset(WIDTH_PRO(15));
        make.bottom.right.equalTo(backView).offset(-WIDTH_PRO(15));
    }];
    
    switch (_state) {
        case 1:
            lab.text = @"等待买家付款";
            break;
        case 2:
            lab.text = @"等待卖家发货";
            break;
        case 3:
            lab.text = @"等待买家收货";
            break;
        case 4:
            lab.text = @"等待买家评价";
            break;
        default:
            break;
    }
    
    _detailTable.tableHeaderView = backView;
}


#pragma mark - uitabledelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section==0?1:_model.OrderDetail.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section==0?HEIGHT_PRO(60):HEIGHT_PRO(80);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section==0?HEIGHT_PRO(0):HEIGHT_PRO(40);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return HEIGHT_PRO(0);
}

//显示订单号
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
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
    lab.text = [NSString stringWithFormat:@"订单号:%@",_model.billno];
    [view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(WIDTH_PRO(8));
        make.bottom.equalTo(view).offset(-HEIGHT_PRO(3));
        //make.right.equalTo(view).offset(-WIDTH_PRO(8));
    }];
    
    UILabel *time = [[UILabel alloc]init];
    time.font = HTFont(22);
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS";
    NSDate *timeDate = [format dateFromString:_model.create_date];
    format.dateFormat = @"yyyy-MM-dd";
    time.text = [NSString stringWithFormat:@"%@",[format stringFromDate:timeDate]];
    [view addSubview:time];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.left.equalTo(view).offset(WIDTH_PRO(8));
        make.bottom.equalTo(view).offset(-HEIGHT_PRO(3));
        make.right.equalTo(view).offset(-WIDTH_PRO(8));
    }];
    
    return section==0?nil:view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
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
    if (indexPath.section==0) {
        ZWHOrderAdressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHOrderAdressTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        cell.manL.text = [NSString stringWithFormat:@"收货人:%@",_model.contact];
        cell.adressL.text = [NSString stringWithFormat:@"收货地址:%@",_model.address];
        cell.phoneL.text = [NSString stringWithFormat:@"%@",_model.mobile];
        return cell;
    }else{
        ZWHOrderListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHOrderListTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        cell.model = _model.OrderDetail[indexPath.row];
        cell.aftersale.hidden = [_model.status integerValue]==4?NO:YES;
        if (!cell.aftersale.hidden) {
            cell.aftersale.tag = indexPath.row;
            [cell.aftersale addTarget:self action:@selector(aftersaleMethod:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }
}

#pragma mark - 左 中 右 点击事件
-(void)rightBtnMethodWith:(UIButton *)btn{
    switch (_state) {
        case 1:
            [self payOrderWith:_model];
            break;
        default:
            break;
    }
}

-(void)centerBtnMethodWith:(UIButton *)btn{
    
}

-(void)leftBtnMethodWith:(UIButton *)btn{
    
}

#pragma mark - 申请售后
-(void)aftersaleMethod:(UIButton *)btn{
    ZWHOrderListModel *model = _model.OrderDetail[btn.tag];
    ZWHAfterSaleViewController *vc = [[ZWHAfterSaleViewController alloc]init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 支付 取消 评价 售后 再次购买
-(void)payOrderWith:(ZWHOrderModel *)model{
    ZWHOrderPayViewController *vc = [[ZWHOrderPayViewController alloc]init];
    vc.state = 0;
    vc.orderModelList = @[_model];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
