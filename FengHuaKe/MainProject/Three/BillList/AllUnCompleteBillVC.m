//
//  AllUnCompleteBillVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "AllUnCompleteBillVC.h"
#import "UIViewController+HUD.h"
#import "ProductVM.h"
#import "BillModel.h"
#import "AllUnCompleteBillCell.h"
#import "BillFooterCell.h"
#import "BillHeaderCell.h"
#import "BillTopView.h"
#import "PayViewController.h"
@interface AllUnCompleteBillVC ()<UITableViewDelegate,UITableViewDataSource,BillTopDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dicArray;
@end

@implementation AllUnCompleteBillVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的订单";
    _dicArray=[NSMutableArray array];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self BillTopView];
    [self BillList];
    // Do any additional setup after loading the view.
}
#pragma mark - TopScroView
-(void)BillTopView
{
    BillTopView *top=[[BillTopView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 45) Array:@[@"全部",@"待付款",@"待发货",@"待收获",@"待评价"]];
    top.delegate=self;
    UIButton *button=(UIButton*)[top viewWithTag:1];
    [top choose:button];
    [self.view addSubview:top];
}
-(void)touchTagindex:(NSInteger)index
{
    
}


#pragma mark - tableView
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,50, ScreenWidth, ScreenHeight-64-55) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.mj_header=self.header;
        _tableView.mj_footer=self.footer;
        _tableView.tableFooterView=[UIView new];
    }
    return _tableView;
}
#pragma mark - 获取全部订单
-(void)BillList
{
    NSString *start=[NSString stringWithFormat:@"%ld",self.startIndex];
    NSString *end=[NSString stringWithFormat:@"%ld",self.endIndex];
    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":UniqUserID,@"para2":@"M",@"intresult":@"0"}];
    DefineWeakSelf;
    [ProductVM BillListSysmodel:sysmodel Startindex:start Endindex:end Success:^(id responseData) {
        if (weakSelf.dataArray.count==0) {
            [weakSelf.dicArray removeAllObjects];
        }
        NSArray *result=[BillModel getDatawithdic:(NSDictionary*)responseData];
        [weakSelf.dataArray addObjectsFromArray:result];
        [weakSelf EndFreshWithArray:result];
        
        NSArray *strArray=[BillModel getUsefulDicStr:(NSDictionary*)responseData];
        [weakSelf.dicArray addObjectsFromArray:strArray];
        [weakSelf.tableView reloadData];
        
    } Fail:^(id erro) {
        
    }];
}

#pragma mark - table
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BillModel *model=self.dataArray[section];
    return model.OrderDetail.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"AllUnCompleteBillCell";
    AllUnCompleteBillCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"AllUnCompleteBillCell" owner:nil options:nil][0];
    }
    BillModel *billmodel=self.dataArray[indexPath.section];
    OrderDetailModel *model=billmodel.OrderDetail[indexPath.row];
    cell.model=model;
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 85;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    BillFooterCell *cell=[[NSBundle mainBundle]loadNibNamed:@"BillFooterCell" owner:nil options:nil][0];
    BillModel *model=self.dataArray[section];
    CGFloat amount=model.totalamount.floatValue;
    model.totalamount=[NSString stringWithFormat:@"%.2f",amount];
    cell.lable.text=[NSString stringWithFormat:@"共计%@件商品   ￥%@ (包含运费￥5.00元) ",model.totalnum,model.totalamount];
    DefineWeakSelf;
    cell.gopayBlock = ^{
        PayViewController *vc=[[PayViewController alloc]init];
        vc.totalAmount=model.totalamount;
        vc.orderDetail=weakSelf.dicArray[section];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BillHeaderCell *cell=[[NSBundle mainBundle]loadNibNamed:@"BillHeaderCell" owner:nil options:nil][0];
    BillModel *model=self.dataArray[section];
    cell.lable.text=[NSString stringWithFormat:@"订单号:%@",model.billno];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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


#define mark - fresh
-(void)headerFresh
{
    [self BillList];
}
-(void)footFresh
{
    [self BillList];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
