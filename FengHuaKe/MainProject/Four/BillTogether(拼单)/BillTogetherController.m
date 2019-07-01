//
//  BillTogetherController.m
//  FengHuaKe
//
//  Created by chenheng on 2019/7/1.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "BillTogetherController.h"
#import "GBSegmentView.h"
#import "BillTogetherTCell.h"
@interface BillTogetherController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)BillTogetherModel * model;
@end

@implementation BillTogetherController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    MJWeakSelf;
    GBSegmentView * seg = [GBSegmentView initialSegmentViewFrame:CGRectMake(0, 0, ScreenWidth, 45*MULPITLE) DataSource:@[@"代付款",@"进行中",@"已完成"] SegStyle:SegStyle_2 CallBack:^(NSInteger index) {
        [weakSelf getData:index];
    }];
    [self.view addSubview:seg];
    [self.view addSubview:self.tableView];
    [self getData:1];
 
    // Do any additional setup after loading the view.
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 45*MULPITLE, ScreenWidth, self.view.height-45*MULPITLE) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:@"BillTogetherTCell" bundle:nil] forCellReuseIdentifier:@"BillTogetherTCell"];
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 105;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
-(void)getData:(NSInteger)state{
    
    NSDictionary *dic = @{@"para1":UniqUserID,@"para2":MEMBERTYPE,@"para3":@(state)};
    NSLog(@"sysmodel ===>%@",dic);
    [DataProcess requestDataWithURL:GroupBuy_Me RequestStr:GETRequestStr(nil, dic, @1, @100, nil) Result:^(id obj, id erro) {
        NSLog(@"结果===>%@",obj);
        NSLog(@"wwwwerro===>%@",erro);
        if (!erro) {
            self.model = [BillTogetherModel mj_objectWithKeyValues:obj];
            [self.tableView reloadData];
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.model) {
        return self.model.DataList.count;
    }else
    {
        return 0;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BillTogetherTCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BillTogetherTCell"];
    [cell loadData:self.model.DataList[indexPath.row]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
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
