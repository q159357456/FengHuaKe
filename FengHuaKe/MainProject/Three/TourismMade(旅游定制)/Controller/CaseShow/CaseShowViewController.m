//
//  CaseShowViewController.m
//  FengHuaKe
//
//  Created by 秦根 on 2019/7/11.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "CaseShowViewController.h"
#import "GBSegmentView.h"
#import "CaeShowTableViewCell.h"
#import "CashClassModel.h"
#import "CashListModel.h"
#import "CaseDetailController.h"
@interface CaseShowViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * classArr;
@property(nonatomic,strong)NSMutableArray * listArr;
@end

@implementation CaseShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    DefineWeakSelf;
    NSDictionary * param = @{@"para1":@"B00101"};
    [DataProcess requestDataWithURL:Case_Class RequestStr:GETRequestStr(nil, param, nil, nil, nil) Result:^(id obj, id erro) {
//                NSLog(@"obj===>%@",obj);
        weakSelf.classArr = [CashClassModel mj_objectArrayWithKeyValuesArray:obj[@"DataList"]];
        [weakSelf setUI];
    }];
    
  
 
    // Do any additional setup after loading the view.
}
-(void)setUI{
    if (!self.classArr.count) {
        return;
    }
    CashClassModel * model = self.classArr.firstObject;
    [self getListData:model];
    
    NSMutableArray * title = [NSMutableArray array];
    for (CashClassModel * model in self.classArr) {
        [title addObject:model.name];
    }
    DefineWeakSelf;
    GBSegmentView * seg = [GBSegmentView initialSegmentViewFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50) DataSource:title SegStyle:SegStyle_3 CallBack:^(NSInteger index) {
        CashClassModel * model = weakSelf.classArr[index-1];
        [weakSelf getListData:model];
        
    }];
    [self.view addSubview:seg];
    [self.view addSubview:self.tableView];
}
-(void)getListData:(CashClassModel*)model{
    
    NSDictionary * param1 =  @{@"para1":@"B001",@"para2":model.code?model.code:@"",@"para3":@"",@"para4":@""};
    DefineWeakSelf;
    [DataProcess requestDataWithURL:Case_List RequestStr:GETRequestStr(nil, param1, @1, @100, nil) Result:^(id obj, id erro) {
        NSLog(@"obj===>%@",obj);
        weakSelf.listArr = [CashListModel mj_objectArrayWithKeyValuesArray:obj[@"DataList"]];
        [weakSelf.tableView reloadData];
    }];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, self.view.height-50) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[CaeShowTableViewCell class] forCellReuseIdentifier:@"CaeShowTableViewCell"];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CaeShowTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CaeShowTableViewCell"];
    CashListModel * model = self.listArr[indexPath.row];
    [cell loadData:model];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CaeShowTableViewCell rowHeight];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CaseDetailController * vc = [[CaseDetailController alloc]init];
    CashListModel * model = self.listArr[indexPath.row];
    vc.code = model.code;
    [self.navigationController pushViewController:vc animated:YES];
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
