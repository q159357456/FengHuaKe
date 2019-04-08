//
//  ContractDetailVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/28.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ContractDetailVC.h"
#import "HeaderView.h"
#import "ContractDetailCell.h"
#import "ContractManagerVC.h"
#import "UserModel.h"
@interface ContractDetailVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)UserModel *userModel;
@end

@implementation ContractDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"好友信息";
    self.titleArray=@[@"标签",@"分组",@"备注",@"地区",@"里程",@"签名"];
    self.tableview.tableFooterView=[[UITableView alloc]init];
    [self getDetailInfo];
}
#pragma mark private
-(UIView*)headView
{
    HeaderView *head=[[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:nil options:nil][0];
    head.GroupTitle.text=self.userModel.nickname;
    NSLog(@"nickname:%@",self.userModel.nickname);
    head.frame=CGRectMake(0, 0, ScreenWidth, ScreenWidth/3);
    return head;
}

//好友详细信息
-(void)getDetailInfo
{
    DefineWeakSelf;
    [ContractManagerVC SystemCommonGroupWithuserid:self.userid Success:^(id responseData) {
        NSDictionary *dic=(NSDictionary*)responseData;
        NSLog(@"个人详细信息:%@",dic);
        if ([UserModel getDatawithdic:dic]) {
            weakSelf.userModel=[UserModel getDatawithdic:dic][0];
            weakSelf.tableview.tableHeaderView=[self headView];
            [weakSelf.tableview reloadData];
        }
        
    } Fail:^(id erro) {
        
    }];
}
#pragma mark- tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    return self.titleArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellid=@"ContractDetailCell";
    ContractDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"ContractDetailCell" owner:nil options:nil][0];
    }
    cell.lable1.text=self.titleArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
 
        return 20;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        return 45;
    
}

@end
