//
//  ZWHVacationClassifyViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/27.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHVacationClassifyViewController.h"

#import "ClassifyModel.h"
#import "ZWHClassifyListLeftTableViewCell.h"
#import "ZWHClassiftRightCollectionViewCell.h"
#import "ZWHVacationListViewController.h"

@interface ZWHVacationClassifyViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UITableView *classifyTable;
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)NSMutableArray *rightArr;


@property(nonatomic,strong)QMUIFloatLayoutView *layView;

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation ZWHVacationClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setRightView];
    [self getDataSource];
}

-(void)getDataSource{
    MJWeakSelf;
    [self showEmptyViewWithLoading];
    [HttpHandler getClassifyList:@{@"para1":_code,@"para2":_secode,@"intresult":@"0"} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        [weakSelf hideEmptyView];
        if (ReturnValue==1) {
            weakSelf.dataArray = [ClassifyModel mj_objectArrayWithKeyValuesArray:obj[@"DataList"]];
            [weakSelf.classifyTable reloadData];
            if (weakSelf.dataArray.count>0) {
                [weakSelf.classifyTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:0];
                [weakSelf.classifyTable.delegate tableView:weakSelf.classifyTable didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            }else{
                weakSelf.classifyTable.hidden = YES;
                weakSelf.collectionView.hidden = YES;
                [weakSelf showEmptyViewWithImage:[UIImage imageNamed:@"nodata"] text:@"" detailText:@"" buttonTitle:@"" buttonAction:nil];
            }
        }
    } failed:^(id obj) {
        [weakSelf hideEmptyView];
    }];
}

-(void)setUI{
    
    _dataArray = [NSMutableArray array];
    
    
    _classifyTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:_classifyTable];
    [_classifyTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.view);
        make.width.mas_equalTo(WIDTH_PRO(90));
        make.top.equalTo(self.view).offset(ZWHNavHeight);
    }];
    _classifyTable.delegate = self;
    _classifyTable.dataSource = self;
    _classifyTable.separatorStyle = 0;
    _classifyTable.backgroundColor = ZWHCOLOR(@"F0F0F0");
    _classifyTable.showsVerticalScrollIndicator = NO;
    [_classifyTable registerClass:[ZWHClassifyListLeftTableViewCell class] forCellReuseIdentifier:@"ZWHClassifyListLeftTableViewCell"];
    self.keyTableView = _classifyTable;
}

-(void)setRightView{
    
    _rightArr = [NSMutableArray array];
    
    // 初始化一个布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset =UIEdgeInsetsMake(0,0,0, 0);
    
    // 设置最小行距
    flowLayout.minimumLineSpacing = HEIGHT_PRO(8);
    // 设置最小间距
    flowLayout.minimumInteritemSpacing = WIDTH_PRO(8);
    // 设置格子大小
    flowLayout.itemSize = CGSizeMake(WIDTH_PRO(130), HEIGHT_PRO(150));
    // 设置组边界
    flowLayout.sectionInset = UIEdgeInsetsMake(WIDTH_PRO(8), WIDTH_PRO(8), WIDTH_PRO(8), WIDTH_PRO(8));
    // 初始化集合视图
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    
    // 设置背景色
    _collectionView.backgroundColor = [UIColor whiteColor];
    // 设置代理和数据源
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[ZWHClassiftRightCollectionViewCell class] forCellWithReuseIdentifier:@"ZWHClassiftRightCollectionViewCell"];
    
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.view);
        make.left.equalTo(_classifyTable.mas_right);
        make.top.equalTo(_classifyTable.mas_top);
    }];
    
    self.keyCollectionView = _collectionView;
}

#pragma mark - uicollectView

// 返回多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 每组返回多少个格子
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _rightArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZWHClassiftRightCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZWHClassiftRightCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = LINECOLOR;
    cell.model = _rightArr[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ClassifyModel *model = _rightArr[indexPath.item];
    ZWHVacationListViewController *vc = [[ZWHVacationListViewController alloc]init];
    vc.code = _code;
    vc.secode = model.code;
    vc.InsuranceCode = _InsuranceCode;
    vc.title = model.name;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - uitableviewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_PRO(40);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWHClassifyListLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHClassifyListLeftTableViewCell" forIndexPath:indexPath];
    ClassifyModel *model = _dataArray[indexPath.row];
    cell.selectionStyle = 0;
    cell.textLabel.text = model.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ClassifyModel *model = _dataArray[indexPath.row];
    MJWeakSelf;
    [self showEmptyViewWithLoading];
    [HttpHandler getClassifyList:@{@"para1":_code,@"para2":model.code} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        [weakSelf hideEmptyView];
        if (ReturnValue==1) {
            weakSelf.rightArr = [ClassifyModel mj_objectArrayWithKeyValuesArray:obj[@"DataList"]];
            [weakSelf.collectionView reloadData];
            if (weakSelf.rightArr.count==0) {
                [weakSelf.layView removeFromSuperview];
                [weakSelf showEmptyViewWithImage:[UIImage imageNamed:@"nodata"] text:@"" detailText:@"" buttonTitle:@"" buttonAction:nil];
                weakSelf.emptyView.imageViewInsets = UIEdgeInsetsMake(0, WIDTH_PRO(90)/2, 26, 0);
                weakSelf.emptyView.userInteractionEnabled = NO;
            }else{
                [weakSelf hideEmptyView];
            }
        }else{
            
        }
    } failed:^(id obj) {
        [weakSelf hideEmptyView];
    }];
}


@end
