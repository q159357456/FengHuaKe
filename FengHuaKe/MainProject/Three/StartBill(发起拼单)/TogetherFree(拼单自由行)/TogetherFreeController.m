//
//  TogetherFreeController.m
//  FengHuaKe
//
//  Created by chenheng on 2019/7/17.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "TogetherFreeController.h"
#import "TogetherListCell.h"
@interface TogetherFreeController () <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,strong)NSMutableArray * classifyArr;
@end

@implementation TogetherFreeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    DefineWeakSelf;
    NSDictionary * sysmodel1 = @{@"para1":UniqUserID,@"para2":MEMBERTYPE,@"para3":@""};
    [DataProcess requestDataWithURL:GroupBuy_List RequestStr:GETRequestStr(nil, sysmodel1, @1, @100, nil) Result:^(id obj, id erro) {
        NSLog(@"obj==>%@",obj);
        if (obj) {
            weakSelf.dataArr = [GroupBillModel mj_objectArrayWithKeyValuesArray:obj[@"DataList"]];
            [weakSelf.view addSubview:weakSelf.tableView];
        }
    }];
    // Do any additional setup after loading the view.
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[TogetherListCell class] forCellReuseIdentifier:@"TogetherListCell"];
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TogetherListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TogetherListCell"];
    GroupBillModel * model = self.dataArr[indexPath.row];
    [cell loadData:model];
    return cell;
   
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ShopModel * model = self.dataArr[indexPath.row];
//    CookingProListController * vc = [[CookingProListController  alloc]init];
//    vc.shopid = model.SHOPID;
//    [self.navigationController pushViewController:vc animated:YES];
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
