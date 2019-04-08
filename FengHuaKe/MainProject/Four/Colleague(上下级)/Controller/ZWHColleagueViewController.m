//
//  ZWHColleagueViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/2.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHColleagueViewController.h"
#import "ZWHColleagueModel.h"
#import "ZWHColleagueTableViewCell.h"


@interface ZWHColleagueViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *relationTable;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger index;

@end

@implementation ZWHColleagueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    [self setRefresh];
}

#pragma mark - 网络请求
-(void)getDataSource{
    NSNumber *startIndex = [NSNumber numberWithInteger:_index];
    MJWeakSelf
    [HttpHandler getMemberRelation:@{@"para1":UniqUserID,@"para2":userType} start:startIndex end:@10 querytype:@"0" Success:^(id obj) {
        NSLog(@"%@",obj);
        NSString *strresult = obj[@"sysmodel"][@"strresult"];
        NSString *strpara = obj[@"sysmodel"][@"para1"];
        
        NSArray *resultArr = [HttpTool getArrayWithData:strresult];
        NSArray *paratArr = [HttpTool getArrayWithData:strpara];
        
        //我的上级数据
        NSMutableArray *resultMuArr = weakSelf.dataArray[0];
        [weakSelf.dataArray replaceObjectAtIndex:0 withObject:[ZWHColleagueModel mj_objectArrayWithKeyValuesArray:resultArr]];
        
        //我的下级数据
        NSMutableArray *paraMuArr = weakSelf.dataArray[1];
        if (paratArr.count == 0) {
            [weakSelf.relationTable.mj_header endRefreshing];
            [weakSelf.relationTable.mj_footer endRefreshingWithNoMoreData];
        }else{
            [paraMuArr addObjectsFromArray:[ZWHColleagueModel mj_objectArrayWithKeyValuesArray:paratArr]];
            [weakSelf.relationTable.mj_header endRefreshing];
            [weakSelf.relationTable.mj_footer endRefreshing];
        }
        [weakSelf.relationTable reloadData];
    } failed:^(id obj) {
        [weakSelf.relationTable.mj_header endRefreshing];
        [weakSelf.relationTable.mj_footer endRefreshing];
    }];
}

-(void)setRefresh{
    MJWeakSelf
    _relationTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.dataArray = [NSMutableArray array];
        [weakSelf.dataArray addObject:[NSMutableArray array]];
        [weakSelf.dataArray addObject:[NSMutableArray array]];
        weakSelf.index = 1;
        [weakSelf getDataSource];
    }];
    /*_relationTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.index ++ ;
        [weakSelf getDataSource];
    }];*/
    [_relationTable.mj_header beginRefreshing];
}


#pragma mark - 加载UI
-(void)setUI{
    _dataArray = [NSMutableArray array];
    [_dataArray addObject:[NSMutableArray array]];
    [_dataArray addObject:[NSMutableArray array]];
    _index = 1;
    _relationTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-ZWHNavHeight-100) style:UITableViewStylePlain];
    [self.view addSubview:_relationTable];
    [_relationTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    _relationTable.delegate = self;
    _relationTable.dataSource = self;
    _relationTable.separatorStyle = 0;
    [_relationTable registerClass:[ZWHColleagueTableViewCell class] forCellReuseIdentifier:@"ZWHColleagueTableViewCell"];
}


#pragma mark - uitabledelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray[section] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if ([_dataArray[section] count] > 0) {
        return section==0?@"我的上级":@"我的下级";
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_PRO(50);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EaseUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHColleagueTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([self.dataArray[indexPath.section] count]>0) {
        ZWHColleagueModel *model = _dataArray[indexPath.section][indexPath.row];
        [cell.avatarView.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,model.logo]] placeholderImage:[UIImage imageNamed:@"EaseUIResource.bundle/user"]];
        cell.titleLabel.text = model.name;
    }
    return cell;
}



@end
