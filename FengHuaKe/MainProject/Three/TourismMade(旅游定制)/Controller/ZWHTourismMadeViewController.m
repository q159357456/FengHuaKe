//
//  ZWHTourismMadeViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/12/24.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHTourismMadeViewController.h"
#import "TouristTableViewCell.h"
#import "CaseShowViewController.h"
#import "BlogListViewController.h"
#import "RimViewController.h"
#import "BlogDetailViewController.h"
@interface ZWHTourismMadeViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)SDCycleScrollView *topScrView;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * imageArr;
@property(nonatomic,strong)NSMutableArray * blogArr;
@end

@implementation ZWHTourismMadeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.blogArr = [NSMutableArray array];
    self.title = @"旅游定制";
    [self.view addSubview:self.tableView];
    //
    DefineWeakSelf;
    [DataProcess requestDataWithURL:Blogs_Hot RequestStr:GETRequestStr(nil, nil, @1, @100, nil) Result:^(id obj, id erro) {
        
        [weakSelf.blogArr  addObjectsFromArray:[BlogsModel mj_objectArrayWithKeyValuesArray:obj[@"DataList"]]];
        [weakSelf.tableView reloadData];
        
    }];
    
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [self headView];
        [_tableView registerClass:[TouristTableViewCell class] forCellReuseIdentifier:@"TouristTableViewCell"];
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
    NSArray * imageArray = @[@"customization_1",@"customization_2",@"customization_3"];
    NSArray * titleArray = @[@"周边门店",@"导游博客",@"案例展示"];
    for (NSInteger i=0; i<titleArray.count; i++) {
        
        CGFloat w = SCREEN_WIDTH/titleArray.count;
        CGFloat h = WIDTH_PRO(100);
        CGFloat x = i*w;
        QMUIButton * btn = [[QMUIButton alloc]qmui_initWithImage:[UIImage imageNamed:imageArray[i]] title:titleArray[i]];
        btn.imagePosition =  QMUIButtonImagePositionTop;
        btn.spacingBetweenImageAndTitle = WIDTH_PRO(10);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(x, 0, w, h);
        [listView addSubview:btn];
        btn.tag = i+100;
        btn.titleLabel.font = ZWHFont(14*MULPITLE);
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
 
    }
    UIView * sepraterView1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(listView.frame), SCREEN_WIDTH, WIDTH_PRO(10))];
    [headView addSubview:sepraterView1];
    
    UIView * hotView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(sepraterView1.frame), SCREEN_WIDTH, WIDTH_PRO(30))];
    hotView.qmui_borderWidth = 1;
    hotView.qmui_borderColor = [UIColor groupTableViewBackgroundColor];
    hotView.qmui_borderPosition =  QMUIViewBorderPositionBottom;
    [headView addSubview:hotView];
    
   
    UIImageView * hotimg = [[UIImageView alloc]initWithFrame:CGRectMake(10, WIDTH_PRO(2), WIDTH_PRO(26), WIDTH_PRO(26))];
    hotimg.image = [UIImage imageNamed:@"customization_4"];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(hotimg.frame)+3, 0, 100, hotView.height)];
    [hotView addSubview:label];
    [hotView addSubview:hotimg];
    label.text = @"热门博客";
    label.font = ZWHFont(14*MULPITLE);
    
    sepraterView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    sepraterView1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetMaxY(hotView.frame));
    
    return headView;
    
}


-(void)btnClick:(UIButton*)sender{
    
    switch (sender.tag-100) {
        case 0:
        {
            RimViewController * vc = [[RimViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            BlogListViewController * vc = [[BlogListViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            CaseShowViewController * vc = [[CaseShowViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.blogArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TouristTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TouristTableViewCell"];
    BlogsModel * model = self.blogArr[indexPath.row];
    [cell loadData:model];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [TouristTableViewCell rowHeight];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BlogsModel * model = self.blogArr[indexPath.row];
    BlogDetailViewController * vc = [[BlogDetailViewController  alloc]init];
    vc.code = model.code;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
