//
//  ZWHOrderPayViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/9.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHOrderPayViewController.h"
#import "ZWHPayWayTableViewCell.h"
#import "ZWHOrderViewController.h"
#import "ShopCarViewController.h"
#import "ZWHProductDetailViewController.h"
#import "InsuranceVC.h"
#import "ZWHTiketStoreViewController.h"
#import "ZWHHotelDetailViewController.h"
#import "ZWHVacationListViewController.h"

@interface ZWHOrderPayViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *payTable;

@property(nonatomic,assign)NSInteger selectIndex;

@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSArray *imgArr;

@end

@implementation ZWHOrderPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectIndex = 0;
    self.title = @"支付订单";
    _titleArr = @[@"支付宝",@"微信"];
    _imgArr = @[@"zhifubao",@"weixin"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    [self setHeaderAndFooter];
    NOTIFY_ADD(aliPayReturnWith:, NOTIFICATION_ALIPAY);
}

-(void)dealloc{
    NOTIFY_REMOVEALL;
}

-(void)setUI{
    _payTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:_payTable];
    [_payTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-HEIGHT_PRO(50));
    }];
    _payTable.delegate = self;
    _payTable.dataSource = self;
    _payTable.separatorStyle = 0;
    _payTable.backgroundColor = [UIColor whiteColor];
    _payTable.bounces = NO;
    [_payTable registerClass:[ZWHPayWayTableViewCell class] forCellReuseIdentifier:@"ZWHPayWayTableViewCell"];
}

-(void)setHeaderAndFooter{
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(200))];
    
    for (NSInteger i=0; i<2; i++) {
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = LINECOLOR;
        [backview addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(backview);
            make.height.mas_equalTo(HEIGHT_PRO(10));
            if (i==0) {
                make.top.equalTo(backview);
            }else{
                make.bottom.equalTo(backview);
            }
        }];
    }
    
    UILabel *lab = [[UILabel alloc]init];
    lab.text = @"¥80.00";
    lab.font = HTFont(80);
    lab.textAlignment = NSTextAlignmentCenter;
    if (self.state == 7) {
        DatalistBaseModel * datalist = self.baseModel.DataList[0];
        lab.text = [NSString stringWithFormat:@"¥%.2f",datalist.cash.floatValue];
        
    }else
    {
        if (_orderModelList.count>0) {
            float sum=0;
            for (NSInteger i=0; i<_orderModelList.count; i++) {
                ZWHOrderModel *model = _orderModelList[i];
                sum+=[model.totalamount floatValue];
            }
            lab.text = [NSString stringWithFormat:@"¥%.2f",sum];
        }
    }
   
    
    
    [backview addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(backview);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = ZWHCOLOR(@"#4BA4FF");
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    [btn setTitle:@"确认支付" forState:0];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(HEIGHT_PRO(40));
    }];
    [btn addTarget:self action:@selector(sureToPayWith:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _payTable.tableHeaderView = backview;
}

#pragma mark - 确认支付
-(void)sureToPayWith:(UIButton *)btn{
    NSString *paywayStr;
    switch (_selectIndex) {
        case 0:
            paywayStr = @"A";
            break;
        case 1:
            paywayStr = @"W";
            break;
        default:
            break;
    }
    
    if (self.state == 7) {
        DatalistBaseModel * datalist = self.baseModel.DataList[0];
        NSDictionary * sysmodel = @{@"para1":UniqUserID,@"para2":MEMBERTYPE,@"para3":datalist.MG001,@"para4":self.baseModel.sysmodel.para1,@"para5":datalist.MBR000,@"para6":@"W"};
        MJWeakSelf;
        [DataProcess requestDataWithURL:Pay_MemberLevel RequestStr:GETRequestStr(nil, sysmodel, nil, nil, nil) Result:^(id obj, id erro) {
            NSLog(@"确认支付上传结果===>%@",obj);
            NSLog(@"wwwwerro===>%@",erro);
            if ([obj[@"sysmodel"][@"intresult"] integerValue] == 1) {
                [weakSelf aliPay:obj[@"sysmodel"][@"strresult"] urlScheme:@"Fenghuake"];
            }else
            {
                [self showHint:obj[@"msg"]];
            }
            
        }];
    }else
    {
        if (_orderModelList.count>0) {
            
            NSMutableArray *dataListArr = [NSMutableArray array];
            for (NSInteger i=0; i<_orderModelList.count; i++) {
                ZWHOrderModel *model = _orderModelList[i];
                NSMutableDictionary *datalist = [NSMutableDictionary dictionary];
                //            [datalist setValue:UniqUserID forKey:@"memberid"];
                //            [datalist setValue:userType forKey:@"membertype"];
                //            [datalist setValue:paywayStr forKey:@"paytype"];
                [datalist setValue:model.billno forKey:@"billno"];
                [datalist setValue:model.shopid forKey:@"shopid"];
                [datalist setValue:model.totalamount forKey:@"amout"];
                [dataListArr addObject:datalist];
            }
            MJWeakSelf;
            [HttpHandler getPayRequest:@{@"para1":userType,@"para2":UniqUserID,@"para3":paywayStr} DataList:dataListArr start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
                if (ReturnValue == 1) {
                    NSLog(@"%@",obj);
                    if ([obj[@"sysmodel"][@"intresult"] integerValue] == 1) {
                        [weakSelf aliPay:obj[@"sysmodel"][@"strresult"] urlScheme:@"Fenghuake"];
                    }else{
                        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"金额变动！" message:[NSString stringWithFormat:@"一共为:¥%@",obj[@"sysmodel"][@"para1"]] preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            [weakSelf aliPay:obj[@"sysmodel"][@"strresult"] urlScheme:@"Fenghuake"];
                        }];
                        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        }];
                        [vc addAction:sure];
                        [vc addAction:cancel];
                        [weakSelf presentViewController:vc animated:YES completion:nil];
                    }
                }
            } failed:^(id obj) {
                NSLog(@"%@",obj);
            }];
        }
    }
    
    
    
}

#pragma mark - 支付宝支付
- (void)aliPay:(NSString *)url urlScheme:(NSString *)urlScheme
{
    [[AlipaySDK defaultService] payOrder:url fromScheme:urlScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
    }];
}

//支付回调
-(void)aliPayReturnWith:(NSNotification *)noti{
    NSInteger code = [noti.object integerValue];
    NSLog(@"%ld",code);
    if (code==9000) {
        switch (_state) {
            case 0:
            {
                for (UIViewController *vc in self.navigationController.childViewControllers) {
                    if ([vc isKindOfClass:[ZWHOrderViewController class]]) {
                        [self.navigationController popToViewController:vc animated:YES];
                        NOTIFY_POST(NOTIFICATION_ORDERLIST);
                    }
                }
            }
                break;
            case 1://订单
            {
                for (UIViewController *vc in self.navigationController.childViewControllers) {
                    if ([vc isKindOfClass:[ZWHProductDetailViewController class]]) {
                        [self.navigationController popToViewController:vc animated:YES];
                        //NOTIFY_POST(NOTIFICATION_SHOPCAR);
                    }
                }
            }
                break;
            case 2://购物车进入
            {
                for (UIViewController *vc in self.navigationController.childViewControllers) {
                    if ([vc isKindOfClass:[ShopCarViewController class]]) {
                        [self.navigationController popToViewController:vc animated:YES];
                        NOTIFY_POST(NOTIFICATION_SHOPCAR);
                    }
                }
            }
                break;
            case 3://保险进入
            {
                for (UIViewController *vc in self.navigationController.childViewControllers) {
                    if ([vc isKindOfClass:[InsuranceVC class]]) {
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
            }
                break;
            case 4://门票进入
            {
                for (UIViewController *vc in self.navigationController.childViewControllers) {
                    if ([vc isKindOfClass:[ZWHTiketStoreViewController class]]) {
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
            }
                break;
            case 5://酒店进入
            {
                for (UIViewController *vc in self.navigationController.childViewControllers) {
                    if ([vc isKindOfClass:[ZWHHotelDetailViewController class]]) {
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
            }
                break;
            case 6://旅游进入
            {
                for (UIViewController *vc in self.navigationController.childViewControllers) {
                    if ([vc isKindOfClass:[ZWHVacationListViewController class]]) {
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
            }
                break;
            default:
                break;
        }
    }else{
        switch (_state) {
            case 1://订单
            {
                for (UIViewController *vc in self.navigationController.childViewControllers) {
                    if ([vc isKindOfClass:[ZWHProductDetailViewController class]]) {
                        [self.navigationController popToViewController:vc animated:YES];
                        //NOTIFY_POST(NOTIFICATION_SHOPCAR);
                    }
                }
            }
                break;
            case 2://购物车进入
            {
                for (UIViewController *vc in self.navigationController.childViewControllers) {
                    if ([vc isKindOfClass:[ShopCarViewController class]]) {
                        [self.navigationController popToViewController:vc animated:YES];
                        NOTIFY_POST(NOTIFICATION_SHOPCAR);
                    }
                }
            }
                break;
            case 3://保险进入
            {
            }
                break;
            case 4://门票进入
            {
            }
                break;
            case 5://酒店进入
            {
            }
                break;
            case 6://旅游进入
            {
            }
                break;
            default:
                break;
        }
    }
    
}

#pragma mark - uitabledelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_PRO(50);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWHPayWayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHPayWayTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = 0;
    cell.img.image = [UIImage imageNamed:_imgArr[indexPath.row]];
    cell.titleL.text = _titleArr[indexPath.row];
    cell.select.image = [UIImage imageNamed:indexPath.row==_selectIndex?@"picture_seleted":@"slected_1"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectIndex = indexPath.row;
    [_payTable reloadData];
}



@end
