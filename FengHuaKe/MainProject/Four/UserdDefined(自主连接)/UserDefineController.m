//
//  UserDefineController.m
//  FengHuaKe
//
//  Created by chenheng on 2019/6/28.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "UserDefineController.h"
#import "UserDefineCell.h"
#import "UserDefineWebController.h"
#define NSLog(FORMAT, ...) fprintf(stderr, "%s:%zd\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String])
@interface UserDefineController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UserDefineModel * model;
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation UserDefineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    MJWeakSelf;
    NSDictionary *dic = @{@"para1":UniqUserID,@"para2":@"U",@"para3":@"",@"para4":@""};
    [DataProcess requestDataWithURL:FolderLink_List RequestStr:GETRequestStr(nil, dic, @1, @100, nil) Result:^(id obj, id erro) {
        NSLog(@"结果===>%@",obj);
        NSLog(@"wwwwerro===>%@",erro);
        if (obj) {
            weakSelf.model = [UserDefineModel mj_objectWithKeyValues:obj];
            [weakSelf.tableView reloadData];
        }else
        {
            
        }
        
        
    }];
    [self initSubViews];
    
    
//    UIView * topView = [[UIView alloc]init];
    // Do any additional setup after loading the view.
}
-(void)initSubViews{
   
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 45*MULPITLE)];
    headView.backgroundColor = [UIColor whiteColor];
    UILabel*label1 = [[UILabel alloc]init];
    UILabel*label2 = [[UILabel alloc]init];
    label1.font = ZWHFont(14*MULPITLE);
    label2.font = ZWHFont(14*MULPITLE);
    label2.textAlignment = NSTextAlignmentRight;
    label1.text = @"名称";
    label2.text = @"地址";
    [headView addSubview:label1];
    [headView addSubview:label2];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headView).offset(15*MULPITLE);
        make.centerY.mas_equalTo(headView);
        make.height.mas_equalTo(headView);
        make.width.mas_equalTo(50*MULPITLE);
        
    }];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50*MULPITLE);
        make.centerY.mas_equalTo(headView);
        make.height.mas_equalTo(headView);
        make.right.mas_equalTo(headView.mas_right).offset(-15*MULPITLE);
    }];
    [self.view addSubview:headView];
  
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame)+10, ScreenWidth, self.view.height - 50*MULPITLE-10) style:UITableViewStylePlain];
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 48 * MULPITLE;
    [self.tableView registerClass:[UserDefineCell class] forCellReuseIdentifier:@"UserDefineCell"];
    
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
    UserDefineCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UserDefineCell"];
    DefineContentModel * model = self.model.DataList[indexPath.row];
    [cell loadData:model];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DefineContentModel * model = self.model.DataList[indexPath.row];
    UserDefineWebController  *vc = [[UserDefineWebController  alloc]init];
    vc.url = model.display_value;
    vc.title = model.display_text;
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
