//
//  ZWHTourismNewsViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/25.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHTourismNewsViewController.h"

#import "CatageModel.h"
#import "CatageDetailWebVC.h"
#import "ZWHNewsTableViewCell.h"


@interface ZWHTourismNewsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger index;

@property(nonatomic,strong)UITableView *listTable;

@end

@implementation ZWHTourismNewsViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"旅游新闻";
    [self setUI];
    [self setRefresh];
}

-(void)setUI{
    self.dataArray = [NSMutableArray array];
    self.index = 1;
    
    _listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-HEIGHT_PRO(50)) style:UITableViewStylePlain];
    [self.view addSubview:_listTable];
    [_listTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(ZWHNavHeight);
    }];
    _listTable.delegate = self;
    _listTable.dataSource = self;
    _listTable.separatorStyle = 0;
    _listTable.backgroundColor = [UIColor whiteColor];
    _listTable.showsVerticalScrollIndicator = NO;
    [_listTable registerClass:[ZWHNewsTableViewCell class] forCellReuseIdentifier:@"ZWHNewsTableViewCell"];
    self.keyTableView = _listTable;
}

-(void)getDataSource{
    NSNumber *startIndex = [NSNumber numberWithInteger:_index];
    
    MJWeakSelf
    
    //新闻
    [HttpHandler getNewNews:@{} start:startIndex end:@(10) querytype:@"0" Success:^(id obj) {
        [weakSelf.listTable.mj_header endRefreshing];
        [weakSelf.listTable.mj_footer endRefreshing];
        if (ReturnValue==1) {
            NSArray *ary = obj[@"DataList"];
            if (ary.count == 0) {
                [weakSelf.listTable.mj_footer endRefreshingWithNoMoreData];
            }else{
                [weakSelf.dataArray addObjectsFromArray: [CatageModel mj_objectArrayWithKeyValuesArray:ary]];
            }
            [weakSelf.listTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            if (weakSelf.dataArray.count==0) {
                weakSelf.listTable.mj_header.hidden = YES;
                weakSelf.listTable.mj_footer.hidden = YES;
                [weakSelf showEmptyViewWithImage:[UIImage imageNamed:@"nodata"] text:@"" detailText:@"" buttonTitle:@"" buttonAction:nil];
            }
        }
    } failed:^(id obj) {
        [weakSelf.listTable.mj_header endRefreshing];
        [weakSelf.listTable.mj_footer endRefreshing];
    }];
    
}

-(void)setRefresh{
    MJWeakSelf
    _listTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.dataArray = [NSMutableArray array];
        weakSelf.index = 1;
        [weakSelf getDataSource];
    }];
    _listTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.index ++ ;
        [weakSelf getDataSource];
    }];
    [self getDataSource];
}



#pragma mark - uitableviewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWHNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHNewsTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = 0;
    cell.model = _dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_PRO(90);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CatageModel *model=_dataArray[indexPath.row];
    CatageDetailWebVC *vc=[[CatageDetailWebVC alloc]init];
    vc.code=model.code;
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
