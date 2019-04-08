//
//  ZWHCollectionViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/2.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHCollectionViewController.h"
#import "ZWHCollectTableViewCell.h"
#import "ZWHCollectModel.h"
#import "ProductDetailVC.h"

@interface ZWHCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *collectTable;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger index;

@end

@implementation ZWHCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    [self setRefresh];
}

#pragma mark - 网络请求
-(void)getDataSource{
    NSNumber *startIndex = [NSNumber numberWithInteger:_index];
    MJWeakSelf
    [HttpHandler getFavoriteProductList:@{@"para1":UniqUserID,@"para2":userType} start:startIndex end:@10 querytype:@"0" Success:^(id obj) {
        NSLog(@"%@",obj);
        if (ReturnValue == 1) {
            NSArray *ary = obj[@"DataList"];
            if (ary.count == 0) {
                [weakSelf.collectTable.mj_header endRefreshing];
                [weakSelf.collectTable.mj_footer endRefreshingWithNoMoreData];
            }else{
                [weakSelf.dataArray addObjectsFromArray: [ZWHCollectModel mj_objectArrayWithKeyValuesArray:ary]];
                [weakSelf.collectTable.mj_header endRefreshing];
                [weakSelf.collectTable.mj_footer endRefreshing];
            }
            [weakSelf.collectTable reloadData];
        }
    } failed:^(id obj) {
        [weakSelf.collectTable.mj_header endRefreshing];
        [weakSelf.collectTable.mj_footer endRefreshing];
    }];
}

-(void)setRefresh{
    MJWeakSelf
    _collectTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.dataArray = [NSMutableArray array];
        weakSelf.index = 1;
        [weakSelf getDataSource];
    }];
    _collectTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.index ++ ;
        [weakSelf getDataSource];
    }];
    [_collectTable.mj_header beginRefreshing];
}

#pragma mark - 清空
-(void)cleanCollectWith:(UIButton *)btn{
    MJWeakSelf
    UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定清空全部收藏？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [HttpHandler getFavoriteProductDelete:@{@"para1":UniqUserID,@"para2":userType} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
            if (ReturnValue == 1) {
                [self showHint:@"清空成功"];
                [weakSelf.collectTable.mj_header beginRefreshing];
            }
        } failed:^(id obj) {
            
        }];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:1 handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alerVC addAction:sure];
    [alerVC addAction:cancel];
    [self presentViewController:alerVC animated:YES completion:^{
        
    }];
}


#pragma mark - 加载UI
-(void)setUI{
    _dataArray = [NSMutableArray array];
    _index = 1;
    _collectTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-ZWHNavHeight-100) style:UITableViewStylePlain];
    [self.view addSubview:_collectTable];
    [_collectTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    _collectTable.delegate = self;
    _collectTable.dataSource = self;
    _collectTable.separatorStyle = 0;
    [_collectTable registerClass:[ZWHCollectTableViewCell class] forCellReuseIdentifier:@"ZWHCollectTableViewCell"];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"清空" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    [btn addTarget:self action:@selector(cleanCollectWith:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
}


#pragma mark - uitabledelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_PRO(90);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWHCollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHCollectTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = 0;
    if (self.dataArray.count>0) {
        cell.model = self.dataArray[indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWHCollectModel *model = _dataArray[indexPath.row];
    ProductDetailVC *vc=[[ProductDetailVC alloc]init];
    vc.productNo=model.productno;
    [self.navigationController pushViewController:vc animated:YES];
}


-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        MJWeakSelf
        ZWHCollectModel *model = _dataArray[indexPath.row];
        [HttpHandler getFavoriteProductDelete:@{@"para1":UniqUserID,@"para2":userType,@"para3":model.productno} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
            if (ReturnValue == 1) {
                [self showHint:@"取消成功"];
                [_dataArray removeObject:model];
                [weakSelf.collectTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
        } failed:^(id obj) {
            
        }];
    }
}


@end
