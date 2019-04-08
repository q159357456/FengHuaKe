//
//  ZWHTicketDetailViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/21.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHTicketDetailViewController.h"
#import "UIButton+IndexPath.h"
#import "ZWHAdvertModel.h"
#import "TicketSingleModel.h"

#import "TicketNoticeVC.h"
#import "TicektBillVC.h"
#import "ZWHTicketBillViewController.h"
#import "ZWHMapViewController.h"
#import "ZWHTicketWebViewController.h"

#import "ZWHTicketFirstTableViewCell.h"
#import "ZWHTicketThirdTableViewCell.h"
#import "ZWHTicketSecondTableViewCell.h"
#import "ZWHSecondDetailTableViewCell.h"

@interface ZWHTicketDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *ticketTable;
@property(nonatomic,strong)SDCycleScrollView *topScrView;

@property(nonatomic,strong)UIView *headerView;

@property(nonatomic,strong)QMUIButton *collectB;

@property(nonatomic,strong)TicketSingleModel *model;


@property(nonatomic,strong)NSArray *sectionTitle;


@property(nonatomic,strong)NSArray *firstTitle;
@property(nonatomic,strong)NSArray *rightTitle;

@property(nonatomic,strong)NSArray *thirdTitle;
@property(nonatomic,strong)NSArray *thirdDetailTitle;

@end

@implementation ZWHTicketDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getDataSource];
}

-(UIImage *)navigationBarBackgroundImage{
    return [UIImage new];
}

-(void)setUI{
    _sectionTitle = @[@"门票预订",@"景点信息"];
    
    _firstTitle = @[[NSString stringWithFormat:@"%@%@%@",_model.brand,_model.fitsex,_model.material],_model.remark];
    _rightTitle = @[@"地图>",@"简介>"];
    
    _thirdTitle = @[@"开放时间:",@"用时建议:"];
    _thirdDetailTitle = @[@"5月2日-5月31日（全天） 周一至周日 10:00-21:00；17:00-21:00(夜场)。水上电音派对每晚20:00于造浪池舞台举行",@"1天"];
    
    
    _ticketTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-HEIGHT_PRO(50)) style:UITableViewStylePlain];
    [self.view addSubview:_ticketTable];
    [_ticketTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(self.view);
    }];
    _ticketTable.delegate = self;
    _ticketTable.dataSource = self;
    _ticketTable.separatorStyle = 0;
    _ticketTable.backgroundColor = LINECOLOR;
    _ticketTable.showsVerticalScrollIndicator = NO;
    [_ticketTable registerClass:[ZWHTicketFirstTableViewCell class] forCellReuseIdentifier:@"ZWHTicketFirstTableViewCell"];
    [_ticketTable registerClass:[ZWHTicketThirdTableViewCell class] forCellReuseIdentifier:@"ZWHTicketThirdTableViewCell"];
    [_ticketTable registerClass:[ZWHTicketSecondTableViewCell class] forCellReuseIdentifier:@"ZWHTicketSecondTableViewCell"];
    [_ticketTable registerClass:[ZWHSecondDetailTableViewCell class] forCellReuseIdentifier:@"ZWHSecondDetailTableViewCell"];
    self.keyTableView = _ticketTable;
    [self setHeader];
    [self setNavigatController];
    _topScrView.imageURLStringsGroup = @[[NSString stringWithFormat:@"%@%@",SERVER_IMG,_model.url]];
    _ticketTable.estimatedRowHeight = 200;
    _ticketTable.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark - 网络请求
-(void)getDataSource{
    [self showEmptyViewWithLoading];
    MJWeakSelf;
    [HttpHandler getTicketSingle:@{@"para1":self.code} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        [weakSelf hideEmptyView];
        if (ReturnValue==1) {
            NSArray *array = [HttpTool getArrayWithData:obj[@"sysmodel"][@"strresult"]];
            [TicketSingleModel mj_objectClassInArray];
            [TicketSonTypeModel mj_objectClassInArray];
            weakSelf.model = [TicketSingleModel mj_objectWithKeyValues:array[0]];
            [weakSelf setUI];
        }else{
            [weakSelf showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(getDataSource)];
        }
    } failed:^(id obj) {
        [weakSelf hideEmptyView];
        [weakSelf showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(getDataSource)];
    }];
}

#pragma mark - 设置头部视图
-(void)setHeader{
    _headerView = [[UIView alloc]init];
    _headerView.backgroundColor = [UIColor whiteColor];
    [_headerView addSubview:self.topScrView];
    
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [_headerView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topScrView.mas_bottom).offset(-HEIGHT_PRO(10));
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.centerX.equalTo(_headerView);
        make.height.mas_equalTo(HEIGHT_PRO(50));
    }];
    [backView layoutIfNeeded];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:backView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = backView.bounds;
    maskLayer.path = maskPath.CGPath;
    backView.layer.mask = maskLayer;
    
    
    QMUILabel *title = [[QMUILabel alloc]qmui_initWithFont:HTFont(32) textColor:[UIColor blackColor]];
    title.text = _model.proname;
    [backView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(backView).offset(WIDTH_PRO(8));
    }];
    
    QMUILabel *point = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:MAINCOLOR];
    point.text = [NSString stringWithFormat:@"%@分",_model.grade];
    point.textAlignment = NSTextAlignmentRight;
    [backView addSubview:point];
    [point mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-WIDTH_PRO(8));
        make.centerY.equalTo(title);
    }];
    
    QMUIFloatLayoutView *tipsView = [[QMUIFloatLayoutView alloc]init];
    tipsView.padding = UIEdgeInsetsMake(2, 2, 2, 2);
    tipsView.itemMargins = UIEdgeInsetsMake(0, 0, 10, 10);
    [backView addSubview:tipsView];
    NSArray *arr = [_model.freight componentsSeparatedByString:@"，"];
    
    for (NSInteger i=0; i<arr.count; i++) {
        QMUILabel *lab = [[QMUILabel alloc]qmui_initWithFont:HTFont(20) textColor:MAINCOLOR];
        lab.text = arr[i];
        lab.contentEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
        lab.qmui_borderColor = MAINCOLOR;
        lab.qmui_borderWidth = 1;
        lab.qmui_borderPosition = QMUIViewBorderPositionTop | QMUIViewBorderPositionLeft | QMUIViewBorderPositionRight | QMUIViewBorderPositionBottom;
        lab.layer.cornerRadius = 3;
        lab.layer.masksToBounds = YES;
        [tipsView addSubview:lab];
    }
    
    CGSize floatLayoutViewSize = [tipsView sizeThatFits:CGSizeMake((SCREEN_WIDTH-WIDTH_PRO(16)), CGFLOAT_MAX)];
    
    [tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(title.mas_left);
        make.top.equalTo(title.mas_bottom).offset(HEIGHT_PRO(5));
        make.height.mas_equalTo(floatLayoutViewSize.height);
        make.width.mas_equalTo(SCREEN_WIDTH-WIDTH_PRO(16));
    }];
    
    
    
    _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.topScrView.frame.size.height+backView.frame.size.height);
    self.ticketTable.tableHeaderView = _headerView;
}

#pragma mark - 设置导航栏
-(void)setNavigatController{
    _collectB = [[QMUIButton alloc]qmui_initWithImage:[UIImage imageNamed:@"WechatIMG39"] title:@""];
    QMUIButton *share = [[QMUIButton alloc]qmui_initWithImage:[UIImage imageNamed:@"WechatIMG37"] title:@""];
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc]initWithCustomView:share],[[UIBarButtonItem alloc]initWithCustomView:_collectB]];
}

#pragma mark - uitableviewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0||section==_model.SpecTree.count+2-1) {
        return 2;
    }else{
        TicketSonTypeModel *typemodel = _model.SpecTree[section-1];
        if (typemodel.isShow) {
            return typemodel.Table.count + 1;
        }else{
            return 1;
        }
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2+_model.SpecTree.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0||section==_model.SpecTree.count+2-2) {
        return HEIGHT_PRO(8);
    }
    return HEIGHT_PRO(0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1 || section ==_model.SpecTree.count+2-1) {
        return HEIGHT_PRO(40);
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1 || section ==_model.SpecTree.count+2-1) {
        UIView *view = [[UIView alloc]init];
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(40));
        view.backgroundColor = [UIColor whiteColor];
        
        QMUILabel *lab = [[QMUILabel alloc]qmui_initWithFont:[UIFont boldSystemFontOfSize:WIDTH_PRO(13)] textColor:[UIColor blackColor]];
        lab.text = section==1?_sectionTitle[0]:_sectionTitle[1];
        [view addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(WIDTH_PRO(8));
            make.centerY.equalTo(view);
        }];
        return view;
    }
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        ZWHTicketFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHTicketFirstTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        cell.right.text = _rightTitle[indexPath.row];
        cell.title.text = _firstTitle[indexPath.row];
        return cell;
    }else if(indexPath.section==_model.SpecTree.count+2-1){
        ZWHTicketThirdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHTicketThirdTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        cell.detail.text = _thirdDetailTitle[indexPath.row];
        cell.title.text = _thirdTitle[indexPath.row];
        return cell;
    }else{
        if (indexPath.row==0) {
            ZWHTicketSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHTicketSecondTableViewCell" forIndexPath:indexPath];
            TicketSonTypeModel *typemodel = _model.SpecTree[indexPath.section-1];
            cell.selectionStyle = 0;
            cell.title.text = typemodel.Value;
            cell.img.transform = typemodel.isShow?CGAffineTransformMakeRotation(M_PI):CGAffineTransformIdentity;
            return cell;
        }else{
            ZWHSecondDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHSecondDetailTableViewCell" forIndexPath:indexPath];
            TicketSonTypeModel *typemodel = _model.SpecTree[indexPath.section-1];
            cell.selectionStyle = 0;
            cell.model = typemodel.Table[indexPath.row-1];
            cell.payExplan.syindexPath = indexPath;
            cell.payNow.syindexPath = indexPath;
            [cell.payExplan addTarget:self action:@selector(payExplan:) forControlEvents:UIControlEventTouchUpInside];
            [cell.payNow addTarget:self action:@selector(payNow:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section>0 && indexPath.section<_model.SpecTree.count+2-1) {
        if (indexPath.row==0) {
            TicketSonTypeModel *typemodel = _model.SpecTree[indexPath.section-1];
            BOOL isshow = typemodel.isShow;
            typemodel.isShow = !isshow;
            [_ticketTable reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        }
    }else if (indexPath.section==0){
        if (indexPath.row==0) {
            ZWHMapViewController *vc = [[ZWHMapViewController alloc]init];
            vc.model = _model;
            vc.title = _model.proname;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            ZWHTicketWebViewController *vc = [[ZWHTicketWebViewController alloc]init];
            vc.remark = _model.remark;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark - 购买须知 立即预定
-(void)payExplan:(QMUIButton *)btn{
    ZWHSecondDetailTableViewCell *cell = [_ticketTable cellForRowAtIndexPath:btn.syindexPath];
    TicketNoticeVC *vc=[[TicketNoticeVC alloc]init];
    vc.model=cell.model;
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    vc.modalTransitionStyle = 2;
    [self presentViewController:vc animated:YES completion:nil];
}


-(void)payNow:(QMUIButton *)btn{
    ZWHSecondDetailTableViewCell *cell = [_ticketTable cellForRowAtIndexPath:btn.syindexPath];
    ZWHTicketBillViewController *vc=[[ZWHTicketBillViewController alloc]init];
    vc.model=cell.model;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - getter
-(SDCycleScrollView *)topScrView{
    if (!_topScrView) {
        NSArray *array = @[[UIImage imageNamed:@"ceshi_3_1"]];
        _topScrView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(220)) delegate:self placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
        _topScrView.localizationImageNamesGroup = array;
        _topScrView.backgroundColor = [UIColor whiteColor];
        _topScrView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _topScrView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _topScrView.pageControlBottomOffset = 5;
        _topScrView.pageControlDotSize = CGSizeMake(WIDTH_PRO(7.5), HEIGHT_PRO(7));
        _topScrView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _topScrView.currentPageDotColor = MAINCOLOR;
        _topScrView.pageDotColor = [UIColor whiteColor];
        //_topScrView.autoScroll = YES;
    }
    return _topScrView;
}


@end
