//
//  ScroWeboViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/9/21.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ScroWeboViewController.h"
#import "ScroChildViewController.h"
#import "ZWHBaseTableView.h"




@interface ScroWeboViewController ()<SGPageTitleViewDelegate, SGPageContentScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) SGPageTitleView *pageTitleView;

@property(nonatomic,strong)NSArray *classArr;

@property(nonatomic,strong)NSMutableArray *VCArr;

@property(nonatomic,strong)ZWHBaseTableView *ticketTable;

//记录头部视图偏移量
@property(nonatomic,assign)CGFloat recordOffset;




@end

@implementation ScroWeboViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _zwhCanScroaEnble = YES;
    
    //控制uitable能否滑动
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fatherTabCanScro:) name:fatherTab object:nil];
    
    
    //控制分页容器能否滑动
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ContentCanScro:) name:contentTab object:nil];
    
    //为两个表格冲突的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parentVcCanOffset:) name:OUTSIDE object:nil];
    
    
    _classArr = @[@"A",@"B",@"C"];
    _VCArr = [NSMutableArray array];
    for (NSInteger i=0;i<_classArr.count;i++) {
        ScroChildViewController *vc = [[ScroChildViewController alloc]init];
        vc.parentVc = self;
        vc.index = i;
        [_VCArr addObject:vc];
    }
    
    
    
    [self setupPageView];
    [self setUI];
    
}

-(void)setUI{
    
    _ticketTable = [[ZWHBaseTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-HEIGHT_PRO(50)) style:UITableViewStylePlain];
    [self.view addSubview:_ticketTable];
    [_ticketTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(ZWHNavHeight);
    }];
    _ticketTable.delegate = self;
    _ticketTable.dataSource = self;
    _ticketTable.separatorStyle = 0;
    _ticketTable.backgroundColor = LINECOLOR;
    _ticketTable.showsVerticalScrollIndicator = NO;
    [_ticketTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.keyTableView = _ticketTable;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEADERHEIG)];
    view.backgroundColor = [UIColor redColor];
    _ticketTable.tableHeaderView = view;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_HEIGHT-(ZWHNavHeight)-44;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    [cell addSubview:self.pageContentScrollView];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.pageTitleView;
}


- (void)setupPageView {
    
    
    
    
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorAdditionalWidth = 10; // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    configure.titleGradientEffect = YES;
    configure.titleSelectedColor = MAINCOLOR;
    configure.indicatorColor = MAINCOLOR;
    configure.bottomSeparatorColor = LINECOLOR;
    
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44) delegate:self titleNames:_classArr configure:configure];
    
    
    self.pageContentScrollView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT-(ZWHNavHeight)-44) parentVC:self childVCs:_VCArr];
    _pageContentScrollView.delegatePageContentScrollView = self;
}

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    //_currentIndex = selectedIndex;
    [self.pageContentScrollView setPageContentScrollViewCurrentIndex:selectedIndex];
}

- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    //_currentIndex = targetIndex;
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView index:(NSInteger)index {
    
}

#pragma mark - 滑动冲突
//控制是否滑动(用于解决表格视图和分页容器的上下 左右手势冲突)
-(void)fatherTabCanScro:(NSNotification *)noti{
    if ([noti.object isEqualToString:@"NO"]) {
        _ticketTable.scrollEnabled = NO;
    }else{
        _ticketTable.scrollEnabled = YES;
    }
}


//控制父视图是否能偏移(用于解决内外表格谁滑动谁不动)
-(void)parentVcCanOffset:(NSNotification *)noti{
    if ([noti.object isEqualToString:@"NO"]) {
        _zwhCanScroaEnble = NO;
    }else{
        _zwhCanScroaEnble = YES;
//        for (ScroChildViewController *vc in _VCArr) {
//            vc.ticketTable.contentOffset = CGPointMake(0, 0);
//        }
    }
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _ticketTable) {
        [[NSNotificationCenter defaultCenter] postNotificationName:contentTab object:@"NO"];
        if (_zwhCanScroaEnble) {
            _recordOffset = scrollView.contentOffset.y;
            if (scrollView.contentOffset.y < HEADERHEIG) {
                [[NSNotificationCenter defaultCenter] postNotificationName:INSIDE object:@"NO"];
            }else{
                [[NSNotificationCenter defaultCenter] postNotificationName:INSIDE object:@"YES"];
                _zwhCanScroaEnble = NO;
            }
        }else{
            scrollView.contentOffset = CGPointMake(0, HEADERHEIG);
        }
        
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _ticketTable) {
        [[NSNotificationCenter defaultCenter] postNotificationName:contentTab object:@"YES"];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView == _ticketTable) {
        [[NSNotificationCenter defaultCenter] postNotificationName:contentTab object:@"YES"];
    }
}


//控制分页控制器是否滑动
-(void)ContentCanScro:(NSNotification *)noti{
    if ([noti.object isEqualToString:@"NO"]) {
        _pageContentScrollView.isScrollEnabled = NO;
    }else{
        _pageContentScrollView.isScrollEnabled = YES;
    }
}

-(void)pageContentScrollViewWillBeginDragging{
    [[NSNotificationCenter defaultCenter] postNotificationName:childTab object:@"NO"];
    [[NSNotificationCenter defaultCenter] postNotificationName:fatherTab object:@"NO"];
}

-(void)pageContentScrollViewDidEndDecelerating{
    [[NSNotificationCenter defaultCenter] postNotificationName:childTab object:@"YES"];
    [[NSNotificationCenter defaultCenter] postNotificationName:fatherTab object:@"YES"];
}


@end
