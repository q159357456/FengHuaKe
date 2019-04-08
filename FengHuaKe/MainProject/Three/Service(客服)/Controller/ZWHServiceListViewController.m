//
//  ZWHServiceListViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/12/24.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHServiceListViewController.h"
#import "ZWHServiceTableViewCell.h"
#import "ZWHServiceModel.h"
#import "ChatViewController.h"

@interface ZWHServiceListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *listTableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger index;

@end

@implementation ZWHServiceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择客服";
    [self setUI];
    [self setRefresh];
}

-(void)setUI{
    _dataArray = [NSMutableArray array];
    _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    _listTableView.showsVerticalScrollIndicator = NO;
    _listTableView.showsHorizontalScrollIndicator = NO;
    _listTableView.separatorStyle = 0;
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [_listTableView registerClass:[ZWHServiceTableViewCell class] forCellReuseIdentifier:@"ZWHServiceTableViewCell"];
    [self.view addSubview:_listTableView];
    [_listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(ZWHNavHeight);
        make.left.right.bottom.equalTo(self.view);
    }];
}

/**
 *获得客服列表数据
 */
-(void)getDataSource{
    NSNumber *startIndex = [NSNumber numberWithInteger:_index];
    MJWeakSelf;
    [HttpHandler getCaseCustomerService:@{@"para1":@"D001",@"shopid":_shopid} start:startIndex end:@10 querytype:@"0" Success:^(id obj) {
        NSLog(@"%@",obj);
        if (ReturnValue == 1) {
            NSArray *ary = obj[@"DataList"];
            if (ary.count == 0) {
                [weakSelf.listTableView.mj_header endRefreshing];
            }else{
                [weakSelf.dataArray addObjectsFromArray: [ZWHServiceModel mj_objectArrayWithKeyValuesArray:ary]];
                [weakSelf.listTableView.mj_header endRefreshing];
                if (ary.count<10) {
                    [weakSelf.listTableView.mj_footer endRefreshingWithNoMoreData];
                }
                //weakSelf.listTableView.mj_footer.hidden = NO;
            }
            [weakSelf.listTableView reloadData];
            if (weakSelf.dataArray.count==0) {
            }else{
            }
        }
    } failed:^(id obj) {
        weakSelf.listTableView.mj_footer.hidden = YES;
        [weakSelf.listTableView.mj_header endRefreshing];
        [weakSelf.listTableView.mj_footer endRefreshing];
    }];
}

-(void)setRefresh{
    MJWeakSelf
    _listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.dataArray = [NSMutableArray array];
        weakSelf.index = 1;
        [weakSelf getDataSource];
    }];
    
    _listTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.index ++ ;
        [weakSelf getDataSource];
    }];
    [_listTableView.mj_header beginRefreshing];
    
}


#pragma mark - uitabledelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_PRO(86);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWHServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHServiceTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = 0;
    if (_dataArray.count>0) {
        cell.model = _dataArray[indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWHServiceModel *model = _dataArray[indexPath.row];
    MJWeakSelf;
    [HttpHandler getCaseContact:@{@"para1":model.code,@"para2":model.shopid} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        NSLog(@"%@",obj);
        if (ReturnValue == 1) {
            ChatViewController *chatController = nil;
            chatController = [[ChatViewController alloc] initWithConversationChatter:model.ring_id conversationType:EMConversationTypeChat];
            chatController.title = @"客服";
            chatController.isService = YES;
            chatController.serviceModel = model;
            chatController.para1 = _para1;
            chatController.para2 = _para2;
            [weakSelf.navigationController pushViewController:chatController animated:YES];
        }else{
            [QMUITips showError:obj[@"msg"]];
        }
    } failed:^(id obj) {
        //[QMUITips showInfo:@"aaa"];
    }];
    
    
}






@end
