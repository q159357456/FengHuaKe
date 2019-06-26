//
//  AlreadyApplyController.m
//  FengHuaKe
//
//  Created by chenheng on 2019/6/24.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "AlreadyApplyController.h"
#import "AlreadyApplyHeadView.h"
#import "AlradyApplyCell.h"

@interface AlreadyApplyController () <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)AlreadyApplyHeadView * headView;
@end

@implementation AlreadyApplyController

- (void)viewDidLoad {
    [super viewDidLoad];
      NSDictionary *dic = @{@"para1":UniqUserID,@"para2":@"",@"para3":@"",@"para4":@"",@"para5":@""};
    [DataProcess requestDataWithURL:Blogs_List RequestStr:GETRequestStr(nil, dic, @1, @100, nil) Result:^(id obj, id erro) {
        NSLog(@"结果===>%@",obj);
        NSLog(@"erro===>%@",erro);
    }];
    // Do any additional setup after loading the view.
}
-(AlreadyApplyHeadView *)headView
{
    if (!_headView) {
        _headView  = [[AlreadyApplyHeadView alloc]init];
    }
    return _headView;
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 180;
        _tableView.tableHeaderView = self.headView;
        [_tableView registerNib:[UINib nibWithNibName:@"AlradyApplyCell" bundle:nil] forCellReuseIdentifier:@"AlradyApplyCell"];
    
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return  self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlradyApplyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AlradyApplyCell"];
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
