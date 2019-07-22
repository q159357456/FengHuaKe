//
//  CookingProListController.m
//  FengHuaKe
//
//  Created by chenheng on 2019/7/16.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "CookingProListController.h"
#import "CookingProListCell.h"
#import "CookingDetailController.h"
@interface CookingProListController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArr;
@end

@implementation CookingProListController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品列表";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NSDictionary * sysmodel = @{@"intresult":@"1",@"para1":self.shopid,@"para2":@"",@"para3":@"",@"para4":@"",@"para5":@"MS001",@"para6":MEMBERTYPE};
    DefineWeakSelf;
    [DataProcess requestDataWithURL:Cate_ProList RequestStr:GETRequestStr(nil, sysmodel, @1, @100, nil) Result:^(id obj, id erro) {
//        NSLog(@"SingleProbj===>%@",obj);
        NSArray * array = (NSArray*) [HttpTool getDictWithData:obj[@"sysmodel"][@"strresult"]];
        weakSelf.dataArr = [ProductModel mj_objectArrayWithKeyValuesArray:array];
        [weakSelf.tableView reloadData];
   
    }];
    [self.view addSubview:self.tableView];
//
    // Do any additional setup after loading the view.
}


-(UITableView *)tableView
{
    if (!_tableView) {
    
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[CookingProListCell class] forCellReuseIdentifier:@"CookingProListCell"];
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
    CookingProListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CookingProListCell"];
    ProductModel * model = self.dataArr[indexPath.row];
    [cell loadData:model];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductModel * model = self.dataArr[indexPath.row];
    CookingDetailController * vc = [[CookingDetailController  alloc]init];
    vc.proId = model.productno;
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
