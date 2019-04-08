//
//  ZWHHotelSearchListViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/25.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHHotelSearchListViewController.h"
#import "HotelListModel.h"
#import "ZWHHotelDetailViewController.h"

#import "ZWHHotelListTableViewCell.h"
#import "ZWHNorSearchViewController.h"

@interface ZWHHotelSearchListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger index;

@property(nonatomic,strong)UITableView *listTable;

@end

@implementation ZWHHotelSearchListViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索结果";
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
    [_listTable registerClass:[ZWHHotelListTableViewCell class] forCellReuseIdentifier:@"ZWHHotelListTableViewCell"];
    self.keyTableView = _listTable;
}

-(void)getDataSource{
    NSNumber *startIndex = [NSNumber numberWithInteger:_index];
    
    MJWeakSelf
    [HttpHandler getHotelList:@{@"para1":_resultStr,@"intresult":@"1",@"blresult":@"false"} start:startIndex end:@10 querytype:@"0" Success:^(id obj) {
        NSArray *ary = [HttpTool getArrayWithData:obj[@"sysmodel"][@"strresult"]];
        if (ary.count == 0) {
            [weakSelf.listTable.mj_header endRefreshing];
            [weakSelf.listTable.mj_footer endRefreshingWithNoMoreData];
        }else{
            [weakSelf.dataArray addObjectsFromArray: [HotelListModel mj_objectArrayWithKeyValuesArray:ary]];
            [weakSelf.listTable.mj_header endRefreshing];
            [weakSelf.listTable.mj_footer endRefreshing];
        }
        [weakSelf.listTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        if (weakSelf.dataArray.count==0) {
            weakSelf.listTable.mj_header.hidden = YES;
            weakSelf.listTable.mj_footer.hidden = YES;
            [weakSelf showEmptyViewWithImage:[UIImage imageNamed:@"nodata"] text:@"" detailText:@"" buttonTitle:@"" buttonAction:nil];
            //weakSelf.emptyView.backgroundColor = [UIColor whiteColor];
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *array=@[@"位置区域",@"价格/星级",@"智能排序",@"筛选"];
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    
    for (NSInteger i=0; i<array.count; i++) {
        QMUIButton *btn = [[QMUIButton alloc]qmui_initWithImage:[UIImage imageNamed:@"WechatIMG31"] title:array[i]];
        btn.imagePosition = QMUIButtonImagePositionRight;
        btn.titleLabel.font = HTFont(24);
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [backView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(backView);
            make.left.equalTo(backView).offset(i*SCREEN_WIDTH/4);
            make.width.mas_equalTo(SCREEN_WIDTH/4);
        }];
        //btn.frame = CGRectMake(SCREEN_WIDTH/3*i, 0, SCREEN_WIDTH/3, HEIGHT_PRO(40));
    }
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = LINECOLOR;
    [backView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(backView);
        make.height.mas_equalTo(1);
    }];
    
    return _dataArray.count==0?nil:backView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return _dataArray.count==0?0:HEIGHT_PRO(40);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWHHotelListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHHotelListTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle  =0;
    cell.model = _dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_PRO(94);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWHHotelDetailViewController *vc = [[ZWHHotelDetailViewController alloc]init];
    vc.mymodel = _dataArray[indexPath.row];
    vc.timeArr = _timeArr;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
