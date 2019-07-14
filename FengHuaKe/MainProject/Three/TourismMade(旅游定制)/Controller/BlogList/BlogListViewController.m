//
//  BlogListViewController.m
//  FengHuaKe
//
//  Created by 秦根 on 2019/7/11.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "BlogListViewController.h"
#import "TouristTableViewCell.h"
#import "BlogDetailViewController.h"
@interface BlogListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * blogArr;
@end

@implementation BlogListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.blogArr = [NSMutableArray array];
    self.title = @"博客";
    [self.view addSubview:self.tableView];
    //
    DefineWeakSelf;
    [DataProcess requestDataWithURL:Blogs_Hot RequestStr:GETRequestStr(nil, nil, @1, @100, nil) Result:^(id obj, id erro) {
        
        [weakSelf.blogArr  addObjectsFromArray:[BlogsModel mj_objectArrayWithKeyValuesArray:obj[@"DataList"]]];
        [weakSelf.tableView reloadData];
        
    }];
    // Do any additional setup after loading the view.
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[TouristTableViewCell class] forCellReuseIdentifier:@"TouristTableViewCell"];
         _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.blogArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TouristTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TouristTableViewCell"];
    BlogsModel * model = self.blogArr[indexPath.row];
    [cell loadData:model];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [TouristTableViewCell rowHeight];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BlogsModel * model = self.blogArr[indexPath.row];
    BlogDetailViewController * vc = [[BlogDetailViewController  alloc]init];
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
