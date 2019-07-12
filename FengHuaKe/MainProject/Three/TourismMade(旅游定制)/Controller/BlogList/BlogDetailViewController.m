//
//  BlogDetailViewController.m
//  FengHuaKe
//
//  Created by 秦根 on 2019/7/11.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "BlogDetailViewController.h"
#import "BlogsModel.h"
#import "CommentListModel.h"
@interface BlogDetailViewController () <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)BlogsModel * blogModel;
@property(nonatomic,strong)NSMutableArray * commentListArr;
@end

@implementation BlogDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.commentListArr = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    NSDictionary * param = @{@"para1":self.code,@"para2":UniqUserID};
    DefineWeakSelf;
    [DataProcess requestDataWithURL:Blogs_Single RequestStr:GETRequestStr(nil, param, nil, nil, nil) Result:^(id obj, id erro) {

         NSLog(@"obj===>%@",obj);
         weakSelf.blogModel = [BlogsModel mj_objectWithKeyValues:obj[@"DataList"][0]];
//         NSLog(@"obj===>%@",weakSelf.blogModel);
         [weakSelf setUI];
         [weakSelf getCommentData];

    }];
    

    // Do any additional setup after loading the view.
}
-(void)getCommentData{
    DefineWeakSelf;
    NSDictionary * param1 = @{@"para1":self.code,@"blresult":@"true"};
    [DataProcess requestDataWithURL:Blogs_CommentList RequestStr:GETRequestStr(nil, param1, @1, @100, nil) Result:^(id obj, id erro) {
        
        NSLog(@"obj===>%@",obj);
        weakSelf.commentListArr = [CommentListModel mj_objectArrayWithKeyValuesArray:obj[@"DataList"]];
//        NSLog(@"obj===>%@",weakSelf.commentListArr);
//        [weakSelf.tableView reloadData];
    }];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        [_tableView registerClass:[TouristTableViewCell class] forCellReuseIdentifier:@"TouristTableViewCell"];
        
    }
    return _tableView;
}

-(void)setUI{
    
    
    
}

-(void)comment:(NSString*)detail Code:(NSString*)code{
    DefineWeakSelf;
    NSArray * dataList = @[@{@"parenttype":@"C",@"parentid":code,@"memberid":UniqUserID,@"details":detail}];
    
    [DataProcess requestDataWithURL:Dynamic_CommentAdd RequestStr:GETRequestStr(dataList, nil, nil, nil, nil) Result:^(id obj, id erro) {
        
        NSLog(@"obj===>%@",obj);
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentListArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 10;
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
