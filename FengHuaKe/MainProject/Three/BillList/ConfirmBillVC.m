//
//  ConfirmBillVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ConfirmBillVC.h"
#import "ShopCarBottomView.h"
#import "UIViewController+HUD.h"
#import "ShopCarModel.h"
#import "AdressManagerInputCell.h"
#import "AdressManagerChosenCell.h"
#import "ConfirmBillAdressCell.h"
#import "STShopCarTableViewCell.h"
#import "AdressManagerData.h"
#import "AdressListModel.h"
#import "UIViewController+HUD.h"
#import "ProductVM.h"
#import "AdressListVC.h"
#import "ZWHOrderPayViewController.h"
#import "ZWHOrderModel.h"


@interface ConfirmBillVC ()<UITableViewDataSource,UITableViewDelegate,AdressListVCDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)ShopCarBottomView *bottomView;
@property(nonatomic,strong)AdressListModel *adressListModel;
@property(nonatomic,strong)NSString *tips;
@end

@implementation ConfirmBillVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"确认订单";
    self.tips = @"";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    [self AddressGet];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-60) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView=[UIView new];
        [_tableView registerClass:[AdressManagerInputCell class] forCellReuseIdentifier:@"AdressManagerInputCell"];
        [_tableView registerClass:[AdressManagerChosenCell class] forCellReuseIdentifier:@"AdressManagerChosenCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"ConfirmBillAdressCell" bundle:nil] forCellReuseIdentifier:@"ConfirmBillAdressCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"STShopCarTableViewCell" bundle:nil] forCellReuseIdentifier:@"STShopCarTableViewCell"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
        return _tableView;
}


#pragma mark - ShopCarBottomView
-(ShopCarBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView=[[ShopCarBottomView alloc]initWithFrame:CGRectMake(0, ScreenHeight-64-60, ScreenWidth, 60)];
        _bottomView.nextButton.backgroundColor=MainColor;
        _bottomView.lable1.text=self.totalPrice;
        [_bottomView.nextButton setTitle:@"去结算" forState:0];
        [_bottomView.nextButton addTarget:self action:@selector(goPay) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView hideAllBtn];
    }
    return _bottomView;
}
-(void)goPay
{
    [self BillCreate];
}

#pragma mark - table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.billData.count+3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row==0)
    {
         //地址
        ConfirmBillAdressCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ConfirmBillAdressCell"];
        cell.selectionStyle = 0;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (_adressListModel) {
            cell.lable1.text=[NSString stringWithFormat:@"%@",self.adressListModel.Contact];
            cell.lable2.text=self.adressListModel.Mobile;
            cell.lable3.text=[NSString stringWithFormat:@"%@%@%@%@",self.adressListModel.Province,self.adressListModel.City,self.adressListModel.District,self.adressListModel.Address];
            
        }else{
            cell.lable1.text = @"请选择地址";
            cell.lable2.text = @"";
            cell.lable3.text = @"";
        }
        return cell;
    }else if (indexPath.row==self.billData.count+3-2)
    {
         //配送方式
       AdressManagerChosenCell *cell=[tableView dequeueReusableCellWithIdentifier:@"AdressManagerChosenCell"];
        cell.lable.text=@"配送方式";
        cell.adressLbale.text=@"免邮";
        cell.selectionStyle = 0;
        return cell;
        
    }else if (indexPath.row==self.billData.count+3-1)
    {
         //买家留言
       AdressManagerInputCell *cell=[tableView dequeueReusableCellWithIdentifier:@"AdressManagerInputCell"];
        cell.lable.text=@"买家留言";
        cell.inputTextField.placeholder=@"填写给卖家的留言";
        cell.selectionStyle = 0;
        MJWeakSelf
        [cell didEndInput:^(NSString *input) {
            weakSelf.tips = input;
        }];
        return cell;
        
    }else
    {
        STShopCarTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"STShopCarTableViewCell"];
        cell.selLable.hidden=YES;
        [cell setHideen];
        if (_state==1) {
            ProductSpecModel *model=self.billData[indexPath.row-1];
            cell.specmodel=model;
        }else{
            ShopCarModel *model=self.billData[indexPath.row-1];
            cell.model=model;
        }
        cell.selectionStyle = 0;
        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        //地址
        return 80;
        
    }else if (indexPath.row==self.billData.count+3-2)
    {
        //配送方式
       
        return 44;
        
    }else if (indexPath.row==self.billData.count+3-1)
    {
        //买家留言

        return 44;
        
    }else
    {
       
        return 100;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        //地址管理
        AdressListVC *vc=[[AdressListVC alloc]init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)didSelectreturnModel:(AdressListModel *)model{
    _adressListModel = model;
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


#pragma mark - 默认的收获地址
-(void)AddressGet
{
    MJWeakSelf;
    [HttpHandler getAddressGet:@{@"para1":UniqUserID} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        if (ReturnValue==1) {
            if ([obj[@"DataList"] count]>0) {
                weakSelf.adressListModel = [AdressListModel mj_objectWithKeyValues:obj[@"DataList"][0]];
                [weakSelf.tableView reloadData];
            }
        }
    } failed:^(id obj) {
        
    }];
}


#pragma mark - 生成订单
-(void)BillCreate
{
    if (!_adressListModel) {
        [self showHint:@"请选择地址"];
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.adressListModel.Code forKey:@"address"];
    [dict setValue:self.tips forKey:@"remark"];
    [dict setValue:UniqUserID forKey:@"memberid"];
    [dict setValue:userType forKey:@"member_type"];
    [dict setValue:@"0" forKey:@"pay"];
    [dict setValue:[NSNumber numberWithBool:self.blresult] forKey:@"cart"];
    [dict setValue:@"store" forKey:@"command"];
    
    NSMutableArray *datalistArray=[NSMutableArray array];
    
    switch (_state) {
        case 1:
        {
            for (ProductSpecModel *model in self.billData) {
                NSDictionary *dic=@{@"product":model.prono,@"prospec":model.code,@"nums":model.nums};
                [datalistArray addObject:dic];
            }
        }
            break;
        case 2:
        {
            for (ShopCarModel *model in self.billData) {
                NSDictionary *dic=@{@"product":model.prono,@"prospec":model.prospecno,@"nums":model.nums};
                [datalistArray addObject:dic];
            }
        }
            break;
        default:
            break;
    }
    
    
    [dict setObject:datalistArray forKey:@"product"];
    
    MJWeakSelf
    [HttpHandler getBillCreate:@{} DataList:@[dict] start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        if (ReturnValue==1) {
            NSDictionary *dict = obj[@"DataList"][0];
            [ZWHOrderModel mj_objectClassInArray];
            ZWHOrderModel *model = [ZWHOrderModel mj_objectWithKeyValues:dict];
            ZWHOrderPayViewController *vc = [[ZWHOrderPayViewController alloc]init];
            vc.state = _state;
            vc.orderModelList = @[model];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else{
            [self showHint:@"下单失败"];
        }
    } failed:^(id obj) {
        
    }];
}



@end
