//
//  AdressListVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/14.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "AdressListVC.h"
#import "AdressManagerVC.h"
#import "AdressManagerData.h"
#import "UIViewController+HUD.h"
#import "AddressTableViewCell.h"
#import "AdressManagerVC.h"
#import "NSObject+dicANDmodel.h"
@interface AdressListVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;


@end

@implementation AdressListVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.dataArray removeAllObjects];
    [self AddressList];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"收货地址";
    [self.view addSubview:self.tableView];
    [self createBottomBtn];
  
}


#pragma mark - get
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-50) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.mj_header=self.header;
        _tableView.mj_footer=self.footer;
        _tableView.tableFooterView=[UIView new];
    }
    return _tableView;
}
#pragma mark - 获取地址
-(void)AddressList
{
    NSString *start=[NSString stringWithFormat:@"%ld",self.startIndex];
    NSString *end=[NSString stringWithFormat:@"%ld",self.endIndex];
    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":UniqUserID}];
    DefineWeakSelf;
    [AdressManagerData AddressListSysmodel:sysmodel Startindex:start Endindex:end Success:^(id responseData) {
        NSArray *result=[AdressListModel getDatawithdic:(NSDictionary*)responseData];
        [weakSelf.dataArray addObjectsFromArray:result];
        [weakSelf EndFreshWithArray:result];
        [weakSelf.tableView reloadData];
    } Fail:^(id erro) {
        
    }];
}
#pragma mark - 设为默认
-(void)AddressDefaultWithCode:(AdressListModel*)model
{
    [self showHudInView:self.view hint:@""];
    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":model.Code,@"para2":UniqUserID}];
    DefineWeakSelf;
    [AdressManagerData AddressDefaultSysmodel:sysmodel Success:^(id responseData) {
        [self hideHud];
        NSDictionary *dic=(NSDictionary*)responseData;
        if ([dic[@"sysmodel"][@"blresult"] intValue])
        {
            [weakSelf showHint:@"设置成功!"];
            [weakSelf.dataArray removeAllObjects];
            [weakSelf AddressList];
            
        }else
        {
            [weakSelf showHint:dic[@"sysmodel"][@"strresult"]];
        }
    } Fail:^(id erro) {
        
    }];
}
#pragma mark - 删除
-(void)AddressDeleteWith:(AdressListModel*)model
{
    [self showHudInView:self.view hint:@""];
    DefineWeakSelf;
    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":model.Contact,@"para2":UniqUserID,@"para3":model.Mobile,@"para4":model.Province,@"para5":model.City,@"para6":model.District,@"para7":model.Address,@"para8":model.Tips,@"para9":model.Code,@"blresult":model.DefaultAddr}];
    NSDictionary *dict = @{@"para1":model.Contact,@"para2":UniqUserID,@"para3":model.Mobile,@"para4":model.Province,@"para5":model.City,@"para6":model.District,@"para7":model.Address,@"para8":model.Tips,@"para9":model.Code,@"blresult":model.DefaultAddr};
    [AdressManagerData AddressDeleteSysmodel:sysmodel Success:^(id responseData) {
        [self hideHud];
        NSDictionary *dic=(NSDictionary*)responseData;
        if ([dic[@"sysmodel"][@"blresult"] intValue])
        {
            [weakSelf showHint:@"删除成功!"];
            [weakSelf.dataArray removeAllObjects];
            [weakSelf AddressList];
            
        }else
        {
            [weakSelf showHint:dic[@"sysmodel"][@"strresult"]];
        }
    } Fail:^(id erro) {
        
    }];
 
}
#pragma mark - table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"AddressTableViewCell";
    AddressTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"AddressTableViewCell" owner:nil options:nil][0];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    AdressListModel *model=self.dataArray[indexPath.row];
    cell.nameLabel.text=model.Contact;
    cell.mobileLabel.text=model.Mobile;
    cell.addressLabel.text=[NSString stringWithFormat:@"%@%@%@%@",model.Province,model.City,model.District,model.Address];
    if ([model.DefaultAddr boolValue]) {
         [cell.selectBtn setImage:[UIImage imageNamed:@"slected_2"] forState:0];
     
    }else
    {
        [cell.selectBtn setImage:[UIImage imageNamed:@"slected_1"] forState:0];
    }
    DefineWeakSelf;
    //
    cell.setDefaultBlock=^{
        [weakSelf AddressDefaultWithCode:model];
    };
    
    //
    cell.editBlock = ^{
        
        AdressManagerVC *vc=[[AdressManagerVC alloc]init];
        vc.model=model;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    //
    cell.deleteBlock = ^{
         [weakSelf AddressDeleteWith:model];
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 15;
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectreturnModel:)])
    {
        // 调用代理方法
        [self.delegate didSelectreturnModel:self.dataArray[indexPath.row]];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
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
    [self AddressList];
}
-(void)footFresh
{
    [self AddressList];
}
-(void)createBottomBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, ScreenHeight-64-50, ScreenWidth, 50);
    [btn setTitle:@"添加新地址" forState:UIControlStateNormal];
    btn.backgroundColor = MainColor;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)btnClick
{
    AdressManagerVC *vc=[[AdressManagerVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
