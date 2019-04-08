//
//  MyNotosVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "MyNotosVC.h"
#import "TableViewCell.h"
#import "CatageManagerVM.h"
#import "CatageModel.h"
#import "LMWordViewController.h"
#import "CatageDetailWebVC.h"
#import "UIViewController+HUD.h"
@interface MyNotosVC ()
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger index;
@end

@implementation MyNotosVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray=[NSMutableArray array];
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"mynotes"];
    self.tableView.tableFooterView=[[UIView alloc]init];
    //[self getMynotes];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,17,17)];
    backButton.accessibilityIdentifier = @"ddFriends";
    [backButton setImage:[UIImage imageNamed:@"addFriends"]  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(addNotes) forControlEvents:UIControlEventTouchUpInside];
    UIView *leftCustomView = [[UIView alloc] initWithFrame: backButton.frame];
    [leftCustomView addSubview: backButton];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:leftCustomView];
        self.navigationItem.rightBarButtonItem=right;
    [self setRefresh];
}
#pragma mark - action
-(void)addNotes
{
    LMWordViewController *vc=[[LMWordViewController alloc]init];
    vc.title=@"编辑游记";
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - net
-(void)getMynotes
{
    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":UniqUserID}];
    NSString *indexStr = [NSString stringWithFormat:@"%ld",_index];
    DefineWeakSelf;
    [CatageManagerVM NewMyNotesSysmodel:sysmodel Startindex:indexStr Endindex:@"10" Success:^(id responseData) {
        if ([responseData[@"sysmodel"][@"blresult"] integerValue]==1) {
            NSArray *ary = responseData[@"DataList"];
            if (ary.count == 0) {
                [weakSelf.tableView.mj_header endRefreshing];
                weakSelf.tableView.mj_footer.hidden = YES;
            }else{
                [weakSelf.dataArray addObjectsFromArray: [CatageModel getDatawithdic:(NSDictionary*)responseData]];
                [weakSelf.tableView.mj_header endRefreshing];
                [weakSelf.tableView.mj_footer endRefreshing];
                weakSelf.tableView.mj_footer.hidden = NO;
            }
            [weakSelf.tableView reloadData];
        }else{
            
        }
    } Fail:^(id erro) {
        
    }];
}


-(void)setRefresh{
    MJWeakSelf
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.dataArray = [NSMutableArray array];
        weakSelf.index = 1;
        [weakSelf getMynotes];
    }];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        weakSelf.index ++ ;
        [weakSelf getMynotes];
    }];
    [self.tableView.mj_header beginRefreshing];
}

-(void)deletNotesWithCode:(CatageModel*)model
{
    // sysmodel.para1：游记代码
    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":model.code}];
    DefineWeakSelf;
    [CatageManagerVM NewDelNotesSysmodel:sysmodel Success:^(id responseData) {
        NSDictionary *dic=(NSDictionary*)responseData;
        NSLog(@"dic--%@",dic);
        
        if ([dic[@"sysmodel"][@"blresult"] intValue]) {
            [weakSelf showHint:@"删除成功!"];
            [weakSelf.dataArray removeObject:model];
            [weakSelf.tableView reloadData];
            
        }else
        {
            [weakSelf showHint:dic[@"msg"]];
            
        }
    } Fail:^(id erro) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mynotes" forIndexPath:indexPath];
    CatageModel *model=self.dataArray[indexPath.row];
    cell.lable1.text=model.title;
    cell.lable2.text=[model.fromdate componentsSeparatedByString:@"T"][0];
    cell.lable3.text=[NSString stringWithFormat:@"%@",model.looknum];
    // Configure the cell...
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     CatageModel *model=self.dataArray[indexPath.row];
  
    CatageDetailWebVC *vc=[[CatageDetailWebVC alloc]init];
    vc.code=model.code;
    [self.navigationController pushViewController:vc animated:YES];
}
//侧滑允许编辑cell
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//执行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    CatageModel *model=self.dataArray[indexPath.row];
    [self deletNotesWithCode:model];
    
}
//侧滑出现的文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

@end
