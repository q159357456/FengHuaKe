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
@interface CaseShowViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation CaseShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray * titleArray = @[@"111",@"2222",@"3333333",@"33",@"55",@"77777777777"];
    GBSegmentView * seg = [GBSegmentView initialSegmentViewFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50) DataSource:titleArray SegStyle:SegStyle_3 CallBack:^(NSInteger index) {
        
    }];
    [self.view addSubview:seg];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, self.view.height-50) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[CaeShowTableViewCell class] forCellReuseIdentifier:@"CaeShowTableViewCell"];
        
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CaeShowTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CaeShowTableViewCell"];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CaeShowTableViewCell rowHeight];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
