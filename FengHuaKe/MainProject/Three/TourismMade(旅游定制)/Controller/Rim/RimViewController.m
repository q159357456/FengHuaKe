//
//  RimViewController.m
//  FengHuaKe
//
//  Created by chenheng on 2019/7/12.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "RimViewController.h"
#import "RentCarCell.h"
#import "ChatViewController.h"
@interface RimViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataSuorce;
@end

@implementation RimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择客服";
    self.view.backgroundColor = [UIColor whiteColor];
    DefineWeakSelf;
    NSDictionary * param = @{@"para1":@"014",@"para2":@"",@"para3":@"Mshop"};
    [DataProcess requestDataWithURL:Case_CustomerService RequestStr:GETRequestStr(nil, param, @1, @100, nil) Result:^(id obj, id erro) {
            NSLog(@"obj===>%@",obj);
        weakSelf.dataSuorce = [RentCarModel mj_objectArrayWithKeyValuesArray:obj[@"DataList"]];
        [weakSelf.tableView reloadData];
   
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
