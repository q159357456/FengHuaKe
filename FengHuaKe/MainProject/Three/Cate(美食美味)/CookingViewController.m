//
//  CookingViewController.m
//  FengHuaKe
//
//  Created by chenheng on 2019/7/15.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "CookingViewController.h"
#import "CookingTableViewCell.h"
#import "FilterView.h"
#import "ClassifyModel.h"
#import "ShopModel.h"
#import "ImageLabel.h"
#import "CookingProListController.h"
#import "CookingSearchController.h"
@interface CookingViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,strong)NSMutableArray * classifyArr;
@property(nonatomic,strong)SDCycleScrollView *topScrView;
@end

@implementation CookingViewController

-(UIImage *)navigationBarBackgroundImage{
    return [UIImage new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"美食美味";
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }else
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    DefineWeakSelf;
    NSDictionary * sysmodel1 = @{@"para1":self.code?self.code:@"",@"blresult":@"true"};
    [DataProcess requestDataWithURL:Classify_List RequestStr:GETRequestStr(nil, sysmodel1, nil, nil, nil) Result:^(id obj, id erro) {
        NSLog(@"obj==>%@",obj);
        if (obj) {
            weakSelf.classifyArr = [ClassifyModel mj_objectArrayWithKeyValuesArray:obj[@"DataList"]];
            [weakSelf.view addSubview:weakSelf.tableView];
            [weakSelf getListData];
        }
    }];

//    // Do any additional setup after loading the view.
}
-(void)getListData{
    NSDictionary * sysmodel2 = @{@"intresult":@"1",@"blresult":@"true",@"para1":@"",@"para2":@"",@"para3":defaultCityCode,@"para4":@"",@"para5":@"",@"para6":@"",@"para7":@"",@"para8":UniqUserID,@"para9":MEMBERTYPE};
    NSLog(@"%@",sysmodel2);
    DefineWeakSelf;
    [DataProcess requestDataWithURL:Cate_Store RequestStr:GETRequestStr(nil, sysmodel2, @1, @100, nil) Result:^(id obj, id erro) {
        NSLog(@"sysmodel2obj==>%@",obj);
        NSLog(@"erro==>%@",erro);
        if (obj) {
            NSArray * array = (NSArray*) [HttpTool getDictWithData:obj[@"sysmodel"][@"strresult"]];
            weakSelf.dataArr = [ShopModel mj_objectArrayWithKeyValuesArray:array];
            [weakSelf.tableView reloadData];
        }
    }];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = [self headView];
        [_tableView registerClass:[CookingTableViewCell class] forCellReuseIdentifier:@"CookingTableViewCell"];
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}

//轮播图
-(SDCycleScrollView *)topScrView{
    if (!_topScrView) {
        NSArray *array = @[[UIImage imageNamed:@"ceshi_3_1"]];
        _topScrView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(161)) delegate:self placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
        _topScrView.localizationImageNamesGroup = array;
        _topScrView.backgroundColor = [UIColor whiteColor];
        _topScrView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _topScrView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _topScrView.pageControlBottomOffset = 5;
        _topScrView.pageControlDotSize = CGSizeMake(WIDTH_PRO(7.5), HEIGHT_PRO(7));
        _topScrView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _topScrView.currentPageDotColor = MAINCOLOR;
        _topScrView.pageDotColor = [UIColor whiteColor];
        _topScrView.autoScroll = YES;
    }
    return _topScrView;
}

-(UIView*)headView{
    
    UIView * headView = [[UIView alloc]init];
    [headView addSubview:self.topScrView];
    UIView * sepraterView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topScrView.frame), SCREEN_WIDTH, WIDTH_PRO(10))];
    [headView addSubview:sepraterView];
    
    UIView * listView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(sepraterView.frame), SCREEN_WIDTH, WIDTH_PRO(100))];
    [headView addSubview:listView];
    for (NSInteger i=0; i<self.classifyArr.count; i++) {
        ClassifyModel * model = self.classifyArr[i];
        CGFloat w = SCREEN_WIDTH/self.classifyArr.count;
        CGFloat h = WIDTH_PRO(100);
        CGFloat x = i*w;
        ImageLabel *imalable=[ImageLabel initWithFrame:CGRectZero Image:model.icon Title:model.name IsNet:YES];
        imalable.frame=CGRectMake(x, 0, w, h);
        [listView addSubview:imalable];
        imalable.labelOffsetY=6;
        imalable.tag=i+1;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(traClick:)];
        imalable.userInteractionEnabled=YES;
        [imalable addGestureRecognizer:tap];
        
    }
    listView.qmui_borderWidth = 1;
    listView.qmui_borderColor = [UIColor groupTableViewBackgroundColor];
    listView.qmui_borderPosition =  QMUIViewBorderPositionBottom;
    
    //筛选
    NSArray *array=@[@"位置区域",@"智能排序",@"筛选"];
    FilterView * filter = [[FilterView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(listView.frame), SCREEN_WIDTH, 44*MULPITLE) Titles:array];
    [headView addSubview:filter];
    filter.qmui_borderWidth = 1;
    filter.qmui_borderColor = [UIColor groupTableViewBackgroundColor];
    filter.qmui_borderPosition =  QMUIViewBorderPositionBottom;
    headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetMaxY(filter.frame));
    [self setSearch];
    return headView;
    
}
-(void)setSearch{
    QMUIButton *searBtn = [[QMUIButton alloc]qmui_initWithImage:[UIImage imageNamed:@"search"] title:@"信息搜索"];
    [searBtn setTitleColor:[UIColor whiteColor] forState:0];
    searBtn.backgroundColor = [UIColor clearColor];
    searBtn.contentHorizontalAlignment = 1;
    searBtn.spacingBetweenImageAndTitle = WIDTH_PRO(8);
    [searBtn addTarget:self action:@selector(searchBtnWith:) forControlEvents:UIControlEventTouchUpInside];
//    searBtn.frame = CGRectMake((SCREEN_WIDTH-250*MULPITLE)/2, 30, 250*MULPITLE, 40*MULPITLE);
    [searBtn sizeToFit];
    self.navigationItem.titleView = searBtn;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CookingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CookingTableViewCell"];
    ShopModel * model = self.dataArr[indexPath.row];
    [cell loadData:model];
    return cell;
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopModel * model = self.dataArr[indexPath.row];
    CookingProListController * vc = [[CookingProListController  alloc]init];
    vc.shopid = model.SHOPID;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)traClick:(UITapGestureRecognizer*)sender{
    CookingSearchController * vc = [[CookingSearchController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)searchBtnWith:(UIButton*)sender{
    CookingSearchController * vc = [[CookingSearchController alloc]init];
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
