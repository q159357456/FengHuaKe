//
//  RentCarViewController.m
//  FengHuaKe
//
//  Created by chenheng on 2019/4/15.
//  Copyright © 2019年 gongbo. All rights reserved.
//

#import "RentCarViewController.h"
#import "RentCarCell.h"
#import "ChatViewController.h"
@interface RentCarViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataSuorce;
@end

@implementation RentCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择客服";
    NSDictionary *sys = @{@"para1":@"D001",@"para2":@"",@"para3":@"MShop"};
    DefineWeakSelf;
    [DataProcess requestDataWithURL:Case_CustomerService RequestStr:GETRequestStr(nil, sys, @1, @10, nil) Result:^(id obj, id erro) {
        if (!erro) {
//            NSLog(@"obj==>%@",obj);
            weakSelf.dataSuorce = [RentCarModel transformToModelList:ReturnDataList];
            [weakSelf.tableView reloadData];
        }
    }];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}
-(UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 71;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerNib:[UINib nibWithNibName:@"RentCarCell" bundle:nil] forCellReuseIdentifier:@"RentCarCell"];
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSuorce.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RentCarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RentCarCell"];
    RentCarModel *model = self.dataSuorce[indexPath.row];
    [cell setModel:model];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RentCarModel *model = self.dataSuorce[indexPath.row];
    ChatViewController* chatController = [[ChatViewController alloc] initWithConversationChatter:[NSString stringWithFormat:@"%ld",model.ring_id] conversationType:EMConversationTypeChat];
    chatController.title = model.name;
    
    [self.navigationController pushViewController:chatController animated:YES];
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
