//
//  ZWHSystemHomeViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/9.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHSystemHomeViewController.h"
#import <SDWebImage/UIButton+WebCache.h>

#import "ZWHClassifyModel.h"
#import "ZWHTourisTableViewCell.h"
#import "ZWHTravelsTableViewCell.h"
#import "ZWHTravelsLeftTableViewCell.h"
#import "ZWHNewsTableViewCell.h"
#import "CatageModel.h"
#import "ZWHAdvertModel.h"
#import "InsuranceVC.h"

#import "ZWHTourTarNewsListViewController.h"
#import "CatageDetailWebVC.h"
#import "ZWHProductStoreViewController.h"
#import "ZWHInsuranceViewController.h"
#import "ZWHTiketStoreViewController.h"
#import "ZWHHotelViewController.h"
#import "ZWHTourismNewsViewController.h"
#import "ZWHVacationViewController.h"
#import "ZWHScanViewController.h"
#import "ScroWeboViewController.h"

#import "ChatViewController.h"
#import "ZWHVisaCViewController.h"
#import "ZWHTourismMadeViewController.h"
#import "ZWHMeFootViewController.h"
#import "GBAirTiketViewController.h"
#import "CookingViewController.h"

#import "RentCarViewController.h"
@interface ZWHSystemHomeViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *systemTable;
@property(nonatomic,strong)SDCycleScrollView *topScrView;

//6类
@property(nonatomic,strong)NSArray *topClassifyArr;
//8类
@property(nonatomic,strong)NSArray *midClassifyArr;

//组标题
@property(nonatomic,strong)NSArray *sectionTitleArr;
//组颜色
@property(nonatomic,strong)NSArray *sectionColorArr;


//旅游攻略
@property(nonatomic,strong)NSMutableArray *tourisArr;
//游记
@property(nonatomic,strong)NSMutableArray *travelsArr;
//新闻
@property(nonatomic,strong)NSMutableArray *newsArr;
//广告
@property(nonatomic,strong)NSMutableArray *advertArr;


@end

@implementation ZWHSystemHomeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    //[self setInViewWillAppear];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //[self setInViewWillDisappear];
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(UIImage *)navigationBarBackgroundImage{
    return [UIImage new];
}

-(UIImage *)navigationBarShadowImage{
    return [UIImage new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _sectionTitleArr = @[@"旅游攻略",@"游记",@"新闻列表"];
    _sectionColorArr = @[MAINCOLOR,ZWHCOLOR(@"#8BC34A"),ZWHCOLOR(@"#FF9800")];
    
    [self getClassify];
}




-(void)setUI{
    
    
    _systemTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-ZWHNavHeight-100) style:UITableViewStyleGrouped];
    [self.view addSubview:_systemTable];
    [_systemTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
        //make.left.right.bottom.equalTo(self.view);
        //make.top.equalTo(self.view).offset(-20);
    }];
    _systemTable.delegate = self;
    _systemTable.dataSource = self;
    _systemTable.separatorStyle = 0;
    _systemTable.backgroundColor = LINECOLOR;
    [_systemTable registerClass:[ZWHTourisTableViewCell class] forCellReuseIdentifier:@"ZWHTourisTableViewCell"];
    [_systemTable registerClass:[ZWHTravelsTableViewCell class] forCellReuseIdentifier:@"ZWHTravelsTableViewCell"];
    [_systemTable registerClass:[ZWHTravelsLeftTableViewCell class] forCellReuseIdentifier:@"ZWHTravelsLeftTableViewCell"];
    [_systemTable registerClass:[ZWHNewsTableViewCell class] forCellReuseIdentifier:@"ZWHNewsTableViewCell"];
    
    [self setHeader];
    self.keyTableView = _systemTable;
}

#pragma mark - 获得七大类
-(void)getClassify{
    [self showEmptyViewWithLoading];
    MJWeakSelf
    [HttpHandler getFirstClassifyList:@{} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        [weakSelf hideEmptyView];
        if (ReturnValue==1) {
            NSLog(@"%@",obj);
            NSArray *toparr = [HttpTool getArrayWithData:obj[@"sysmodel"][@"strresult"]];
            weakSelf.midClassifyArr = [ZWHClassifyModel mj_objectArrayWithKeyValuesArray:toparr];
            weakSelf.topClassifyArr = [ZWHClassifyModel mj_objectArrayWithKeyValuesArray:obj[@"DataList"]];
            [weakSelf setUI];
            [weakSelf getDataSource];
        }else{
            if ([obj[@"err"] integerValue] == 500) {
                [weakSelf outLogin];
            }else{
                [weakSelf showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(getClassify)];
            }
        }
    } failed:^(id obj) {
        [weakSelf hideEmptyView];
        [weakSelf showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(getClassify)];
        [weakSelf outLogin];
    }];
}

#pragma mark - 获得 旅游功能 游记 新闻 广告
-(void)getDataSource{
    MJWeakSelf;
    //旅游攻略
    [HttpHandler getNewGuides:@{} start:@(1) end:@(2) querytype:@"0" Success:^(id obj) {
        if (ReturnValue==1) {
            NSLog(@"obj==>%@",obj);
            weakSelf.tourisArr = [CatageModel mj_objectArrayWithKeyValuesArray:obj[@"DataList"]];
            [weakSelf.systemTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        }
    } failed:^(id obj) {
        
    }];
    //游记
    [HttpHandler getNewNotes:@{} start:@(1) end:@(2) querytype:@"0" Success:^(id obj) {
        if (ReturnValue==1) {
            NSLog(@"游记===>%@",obj);
            weakSelf.travelsArr = [CatageModel mj_objectArrayWithKeyValuesArray:obj[@"DataList"]];
            [weakSelf.systemTable reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
        }
    } failed:^(id obj) {
        
    }];
    //新闻
    [HttpHandler getNewNews:@{} start:@(1) end:@(2) querytype:@"0" Success:^(id obj) {
        if (ReturnValue==1) {
            NSLog(@"%@",obj);
            weakSelf.newsArr = [CatageModel mj_objectArrayWithKeyValuesArray:obj[@"DataList"]];
            [weakSelf.systemTable reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
        }
    } failed:^(id obj) {
        
    }];
    //轮播图广告
    [HttpHandler getSystemGetADInfo:@{@"para2":@"xt"} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
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
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = LINECOLOR;
    [backView addSubview:self.topScrView];
    
    //8大类
    QMUIGridView *topGridView = [[QMUIGridView alloc]initWithColumn:4 rowHeight:HEIGHT_PRO(90)];
    topGridView.height = HEIGHT_PRO(180);
    [self setShowdownWith:topGridView];
    [backView addSubview:topGridView];
    [topGridView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(WIDTH_PRO(8));
        make.right.equalTo(backView).offset(-WIDTH_PRO(8));
        make.top.equalTo(self.topScrView.mas_bottom).offset(-HEIGHT_PRO(15));
        make.height.mas_equalTo(HEIGHT_PRO(180));
    }];
    for (NSInteger i=0;i<_topClassifyArr.count;i++) {
        
        ZWHClassifyModel *model = _topClassifyArr[i];
        UIView *whitview = [[UIView alloc]init];
        UIImageView *img = [[UIImageView alloc]init];
        [whitview addSubview:img];
        UILabel *lab = [[UILabel alloc]init];
        lab.textAlignment = NSTextAlignmentCenter;
        [whitview addSubview:lab];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(WIDTH_PRO(45));
            make.height.mas_equalTo(HEIGHT_PRO(45));
            make.top.equalTo(whitview).offset(HEIGHT_PRO(15));
            make.centerX.equalTo(whitview);
        }];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(img.mas_bottom);
            make.left.right.equalTo(whitview);
        }];
        lab.font = HTFont(28);
        lab.text = model.name;
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,model.icon]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
        [topGridView addSubview:whitview];
        
        //覆盖按钮
        QMUIButton *btn = [[QMUIButton alloc]init];
        btn.backgroundColor = [UIColor clearColor];
        [whitview addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(whitview);
        }];
        btn.tag = i;
        [btn addTarget:self action:@selector(topGirdViewWith:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    //6大类
    QMUIGridView *midGridView = [[QMUIGridView alloc]initWithColumn:3 rowHeight:HEIGHT_PRO(80)];
    midGridView.height = HEIGHT_PRO(170);
    midGridView.separatorWidth = WIDTH_PRO(3);
    midGridView.separatorColor = [UIColor clearColor];
    midGridView.backgroundColor = [UIColor clearColor];
    //[self setShowdownWith:midGridView];
    midGridView.layer.cornerRadius = WIDTH_PRO(8);
    midGridView.layer.masksToBounds = YES;
    [backView addSubview:midGridView];
    [midGridView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(WIDTH_PRO(8));
        make.right.equalTo(backView).offset(-WIDTH_PRO(8));
        make.top.equalTo(topGridView.mas_bottom).offset(HEIGHT_PRO(15));
        make.height.mas_equalTo(HEIGHT_PRO(170));
    }];
    for (NSInteger i=0;i<_midClassifyArr.count;i++) {
        ZWHClassifyModel *model = _midClassifyArr[i];
        QMUIButton *btn = [[QMUIButton alloc]init];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        btn.titleLabel.font = HTFont(28);
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,model.icon]] forState:0 placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
        btn.layer.cornerRadius = WIDTH_PRO(8);
        btn.layer.masksToBounds = YES;
        btn.backgroundColor = [UIColor clearColor];
        [midGridView addSubview:btn];
        
        btn.tag = i;
        [btn addTarget:self action:@selector(midGirdViewWith:) forControlEvents:UIControlEventTouchUpInside];
    }

    
    backView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.topScrView.frame.size.height+HEIGHT_PRO(165)+HEIGHT_PRO(200));
    _systemTable.tableHeaderView = backView;
    
    
}


#pragma mark - 设置阴影
-(void)setShowdownWith:(UIView *)view{
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = WIDTH_PRO(8);
    
    view.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
    view.layer.shadowOffset = CGSizeMake(0,3);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    view.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    //view.layer.shadowRadius = 10;//阴影半径，默认3
    //view.layer.masksToBounds = YES;
}

#pragma mark - tableviewdelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _tourisArr.count;
    }else if (section == 1){
        return _travelsArr.count;
    }else{
        return _newsArr.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return HEIGHT_PRO(160);
    }else if (indexPath.section==1){
        return HEIGHT_PRO(130);
    }
    return HEIGHT_PRO(90);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HEIGHT_PRO(40);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(40))];
    view.backgroundColor = [UIColor whiteColor];
    
    UIView *butomLineZWH = [[UIView alloc]init];\
    butomLineZWH.backgroundColor = LINECOLOR; \
    [view addSubview:butomLineZWH]; \
    [butomLineZWH mas_makeConstraints:^(MASConstraintMaker *make) {\
        make.left.right.bottom.equalTo(view); \
        make.height.mas_equalTo(1);\
    }];\
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = _sectionColorArr[section];
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(WIDTH_PRO(8));
        make.width.mas_equalTo(WIDTH_PRO(4));
        make.height.mas_equalTo(HEIGHT_PRO(25));
        make.centerY.equalTo(view);
    }];
    
    UILabel *text = [[UILabel alloc]init];
    text.text = _sectionTitleArr[section];
    text.font = HTFont(32);
    [view addSubview:text];
    [text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line.mas_right).offset(WIDTH_PRO(5));
        make.centerY.equalTo(view);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:ZWHCOLOR(@"#676D7A") forState:0];
    [btn setTitle:@"更多" forState:0];
    btn.titleLabel.font = HTFont(28);
    btn.tag = section;
    [btn addTarget:self action:@selector(showMoreWith:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.equalTo(view).offset(-WIDTH_PRO(8));
    }];
    
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        ZWHTourisTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHTourisTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        cell.model = _tourisArr[indexPath.row];
        return cell;
    }else if(indexPath.section == 1){
        if (indexPath.row==0) {
            ZWHTravelsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHTravelsTableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = 0;
            cell.model = _travelsArr[indexPath.row];
            return cell;
        }else{
            ZWHTravelsLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHTravelsLeftTableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = 0;
            cell.model = _travelsArr[indexPath.row];
            return cell;
        }
    }else{
        ZWHNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHNewsTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        cell.model = _newsArr[indexPath.row];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CatageModel *model;
    if (indexPath.section==0) {
        model=_tourisArr[indexPath.row];
    }else if(indexPath.section == 1){
        model=_travelsArr[indexPath.row];
    }else{
        model=_newsArr[indexPath.row];
    }
    CatageDetailWebVC *vc=[[CatageDetailWebVC alloc]init];
    vc.code=model.code;
    vc.title = @"详情";
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 8大类跳转

-(void)topGirdViewWith:(UIButton *)btn{
    NSLog(@"%ld",btn.tag);
    switch (btn.tag) {
        case 0:
        {
            //机票
//            QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:NULL];
//            QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"进入" style:QMUIAlertActionStyleDestructive handler:^(__kindof QMUIAlertController *aAlertController, QMUIAlertAction *action) {
//                GBAirTiketViewController *vc = [[GBAirTiketViewController alloc]init];
//                vc.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:vc animated:YES];
//
//            }];
//            QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"提示" message:@"智慧旅游APP推广活动期间,会员直接进入航空系统享受内部成本价,进入机票系统\n 账号:Opxiaoyin\n 密码:Op22010355" preferredStyle:QMUIAlertControllerStyleAlert];
//            [alertController addAction:action1];
//            [alertController addAction:action2];
//            [alertController showWithAnimated:YES];
            GBAirTiketViewController *vc = [[GBAirTiketViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
         
        }
            break;
        case 1:
        {
            //酒店
            ZWHHotelViewController *vc = [[ZWHHotelViewController alloc]init];
            ZWHClassifyModel *model = _topClassifyArr[btn.tag];
            vc.code=model.code;
            [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];

        }
            break;
        case 2:
        {
            //美食美味
            CookingViewController *vc = [[CookingViewController alloc]init];
            [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];

        }
            break;
        case 3:
        {
            //门票
            ZWHTiketStoreViewController *vc = [[ZWHTiketStoreViewController alloc]init];
            ZWHClassifyModel *model = _topClassifyArr[btn.tag];
            vc.code=model.code;
            [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            ZWHVisaCViewController *vc = [[ZWHVisaCViewController alloc]init];
            ZWHClassifyModel *model = _topClassifyArr[btn.tag];
            vc.code=model.code;
            [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 5:
        {
            //租车
            RentCarViewController *vc = [[RentCarViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
//            [self canshow];
        }
            break;
        case 6:
        {
            //旅游新闻
            ZWHTourismNewsViewController *vc = [[ZWHTourismNewsViewController alloc]init];
            [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 7:
        {
            //企业足迹
            ZWHMeFootViewController *vc = [[ZWHMeFootViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 6大类跳转
-(void)midGirdViewWith:(UIButton *)btn{
    NSLog(@"%ld",btn.tag);
    switch (btn.tag) {
        case 0:
        {
            NSLog(@"拼团跟团");
            ZWHVacationViewController *vc = [[ZWHVacationViewController alloc]init];
            ZWHClassifyModel *model = _midClassifyArr[btn.tag];
            ZWHClassifyModel *insurmodel = _midClassifyArr[btn.tag+1];
            vc.code = model.code;
            vc.InsuranceCode = insurmodel.code;
            [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            //保险
            InsuranceVC *vc=[[InsuranceVC alloc]init];
            [vc setHidesBottomBarWhenPushed:YES];
            ZWHClassifyModel *model = _midClassifyArr[btn.tag];
            vc.code=model.code;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            NSLog(@"旅游特产");
            ZWHProductStoreViewController *vc = [[ZWHProductStoreViewController alloc]init];
            ZWHClassifyModel *model = _midClassifyArr[btn.tag];
            vc.code = model.code;
            vc.adcode = @"tc";
            [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            ZWHTourismMadeViewController *vc = [[ZWHTourismMadeViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            [self canshow];
        }
            break;
        case 5:
        {
            NSLog(@"旅游用品");
            ZWHProductStoreViewController *vc = [[ZWHProductStoreViewController alloc]init];
            ZWHClassifyModel *model = _midClassifyArr[btn.tag];
            vc.code = model.code;
            vc.adcode = @"tyyp";
            [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}


#pragma mark - 旅游攻略 游记 新闻  更多
-(void)showMoreWith:(UIButton *)btn{
    ZWHTourTarNewsListViewController *vc = [[ZWHTourTarNewsListViewController alloc]init];
    vc.state = btn.tag;
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 暂未开发
-(void)canshow{
    UIViewController *chatController = nil;
#ifdef REDPACKET_AVALABLE
    chatController = [[RedPacketChatViewController alloc] initWithConversationChatter:@"ly" conversationType:EMConversationTypeChat];
#else
    chatController = [[ChatViewController alloc] initWithConversationChatter:@"ly" conversationType:EMConversationTypeChat];
#endif
    chatController.title = @"客服";
    [self.navigationController pushViewController:chatController animated:YES];
}


#pragma mark - getter

-(SDCycleScrollView *)topScrView{
    if (!_topScrView) {
        
        NSArray *array = @[[UIImage imageNamed:@"ceshi_3_1"]];
        _topScrView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(200)) delegate:self placeholderImage:[UIImage imageNamed:@"ceshi_3_1"]];
        _topScrView.localizationImageNamesGroup = array;
        _topScrView.backgroundColor = [UIColor whiteColor];
        _topScrView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _topScrView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _topScrView.pageControlBottomOffset = 5;
        _topScrView.pageControlDotSize = CGSizeMake(WIDTH_PRO(7.5), HEIGHT_PRO(7));
        _topScrView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _topScrView.currentPageDotColor = MAINCOLOR;
        _topScrView.pageDotColor = [UIColor whiteColor];
        _topScrView.showPageControl = NO;
        _topScrView.autoScroll = YES;
    }
    return _topScrView;
}


-(void)outLogin
{
    EMError *error = [[EMClient sharedClient] logout:YES];
    if (!error) {
        NSLog(@"退出成功");
        [QMUITips showInfo:@"登录已过期，请重新登录"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [userDefault removeObjectForKey:@"token"];
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:nil userInfo:nil];
        });
        
    }
}


@end
