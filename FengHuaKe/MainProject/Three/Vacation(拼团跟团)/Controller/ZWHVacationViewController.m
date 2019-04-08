//
//  ZWHVacationViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/27.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHVacationViewController.h"
#import "ZWHAdvertModel.h"
#import "ClassifyModel.h"
#import <SDwebimage/UIButton+WebCache.h>
#import "ZWHClassifyViewController.h"
#import "ZWHVacationClassifyViewController.h"

@interface ZWHVacationViewController ()<SDCycleScrollViewDelegate>

@property(nonatomic,strong)UITableView *vacationTable;
@property(nonatomic,strong)SDCycleScrollView *topScrView;

//广告
@property(nonatomic,strong)NSMutableArray *advertArr;

@property(nonatomic,strong)NSMutableArray *topClassifyArr;

@end

@implementation ZWHVacationViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"旅游度假";
    [self getClassify];
}

-(void)setUI{
    
    _vacationTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-HEIGHT_PRO(50)) style:UITableViewStylePlain];
    [self.view addSubview:_vacationTable];
    [_vacationTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(ZWHNavHeight);
    }];
//    _vacationTable.delegate = self;
//    _vacationTable.dataSource = self;
    _vacationTable.separatorStyle = 0;
    _vacationTable.backgroundColor = LINECOLOR;
    _vacationTable.showsVerticalScrollIndicator = NO;
    //[_vacationTable registerClass:[ZWHTicketTableViewCell class] forCellReuseIdentifier:@"ZWHTicketTableViewCell"];
    self.keyTableView = _vacationTable;
    [self setHeader];
    
}
#pragma mark - 网络请求

#pragma mark - 获取十大类
-(void)getClassify{
    [self showEmptyViewWithLoading];
    MJWeakSelf;
    [HttpHandler getClassifyList:@{@"para1":_code,@"intresult":@"10",@"blresult":@"true"} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        [weakSelf hideEmptyView];
        if (ReturnValue==1) {
            weakSelf.topClassifyArr = [ClassifyModel mj_objectArrayWithKeyValuesArray:obj[@"DataList"]];
            ClassifyModel *model = [[ClassifyModel alloc]init];
            model.name = @"全部";
            [weakSelf.topClassifyArr addObject:model];
            [weakSelf setUI];
            [weakSelf getAdvertDataSource];
        }else{
            [weakSelf showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(getClassify)];
        }
    } failed:^(id obj) {
        [weakSelf hideEmptyView];
        [weakSelf showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(getClassify)];
    }];
}


-(void)getAdvertDataSource{
    MJWeakSelf
    //轮播图广告
    [HttpHandler getSystemGetADInfo:@{@"para2":@"travel"} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        if (ReturnValue == 1) {
            weakSelf.advertArr = [ZWHAdvertModel mj_objectArrayWithKeyValuesArray:obj[@"DataList"]];
            NSMutableArray *adArr = [NSMutableArray array];
            for (ZWHAdvertModel *model in weakSelf.advertArr) {
                [adArr addObject:[NSString stringWithFormat:@"%@%@",SERVER_IMG,model.PicAddress1]];
            }
            weakSelf.topScrView.imageURLStringsGroup = adArr;
        }
    } failed:^(id obj) {
        
    }];
}

#pragma mark - 设置头部视图
-(void)setHeader{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:self.topScrView];
    
    for (NSInteger i=0; i<2; i++) {
        ClassifyModel *model = _topClassifyArr[i];
        QMUIButton *btn = [[QMUIButton alloc]init];
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,model.icon]] forState:0 placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
        NSLog(@"%@",[NSString stringWithFormat:@"%@%@",SERVER_IMG,model.icon]);
        btn.layer.cornerRadius = WIDTH_PRO(6);
        btn.layer.masksToBounds = YES;
        btn.tag = i;
        CGFloat wid = (SCREEN_WIDTH-WIDTH_PRO(24))/2;
        [headerView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView).offset((i+1)*WIDTH_PRO(8)+i*wid);
            make.height.mas_equalTo(HEIGHT_PRO(90));
            make.top.equalTo(_topScrView.mas_bottom).offset(HEIGHT_PRO(8));
            make.width.mas_equalTo(wid);
        }];
        [btn addTarget:self action:@selector(classifyWith:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    QMUIGridView *topGridView = [[QMUIGridView alloc]initWithColumn:4 rowHeight:HEIGHT_PRO(30)];
    topGridView.separatorWidth = WIDTH_PRO(8);
    topGridView.separatorColor = [UIColor clearColor];
    
    for (NSInteger i=2; i<_topClassifyArr.count; i++) {
        ClassifyModel *model = _topClassifyArr[i];
        QMUIButton *btn = [[QMUIButton alloc]init];
        if (i==2 || i==3 || i==6 || i==7) {
            [btn setTitleColor:[UIColor blackColor] forState:0];
            btn.backgroundColor = [UIColor qmui_colorWithHexString:@"#E3EDEC"];
        }else{
           [btn setTitleColor:[UIColor whiteColor] forState:0];
            btn.backgroundColor = [UIColor qmui_colorWithHexString:@"#67B1F6"];
        }
        [btn setTitle:model.name forState:0];
        btn.layer.cornerRadius = WIDTH_PRO(5);
        btn.layer.masksToBounds = YES;
        btn.titleLabel.font = HTFont(28);
        btn.tag = i;
        [topGridView addSubview:btn];

        [btn addTarget:self action:@selector(classifyWith:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [headerView addSubview:topGridView];
    [topGridView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(WIDTH_PRO(8));
        make.right.equalTo(headerView).offset(-WIDTH_PRO(8));
        make.top.equalTo(_topScrView.mas_bottom).offset(HEIGHT_PRO(108));
        make.height.mas_equalTo(HEIGHT_PRO(68));
    }];
    
    
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.topScrView.frame.size.height+HEIGHT_PRO(100)+HEIGHT_PRO(80));
    self.vacationTable.tableHeaderView = headerView;
}


#pragma mark - 十大类
-(void)classifyWith:(UIButton *)btn{
    ZWHVacationClassifyViewController *vc = [[ZWHVacationClassifyViewController alloc]init];
    ClassifyModel *model = _topClassifyArr[btn.tag];
    vc.code = _code;
    vc.secode = model.code;
    vc.InsuranceCode = _InsuranceCode;
    vc.title = model.name;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - getter

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



@end
