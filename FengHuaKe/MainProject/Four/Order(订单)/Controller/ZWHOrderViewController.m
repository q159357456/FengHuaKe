//
//  ZWHOrderViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/8.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHOrderViewController.h"
#import "ZWHOrderListViewController.h"

@interface ZWHOrderViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSMutableArray *btnArr;
@property(nonatomic,strong)NSMutableArray *vcArr;

@property(nonatomic,strong)UICollectionView *collectionView;

//当前显示按钮
@property(nonatomic,strong)QMUIButton *showBtn;

@end

@implementation ZWHOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单管理";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    //[self fristShowVC];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self fristShowVC];
}

//初始滚动界面
-(void)fristShowVC{
    //[_collectionView setContentOffset:CGPointMake(SCREEN_WIDTH*_index, 0) animated:YES];
    _collectionView.contentOffset = CGPointMake(SCREEN_WIDTH*_index, 0);
    QMUIButton *btn = _btnArr[_index];
    btn.layer.borderColor = ZWHCOLOR(@"#4BA4FF").CGColor;
    _showBtn = btn;
}

-(void)setUI{
    if ([_poType isEqualToString:@"all"]) {
        _titleArr = @[@"全部",@"待付款",@"待发货",@"待收货",@"待评价"];
    }else if ([_poType isEqualToString:@"hotel"]){
        _titleArr = @[@"全部",@"待付款",@"待确认",@"待入住",@"待评价"];
    }else if ([_poType isEqualToString:@"travel"]){
        _titleArr = @[@"全部",@"待付款",@"待出行",@"行程中",@"待评价"];
    }else if ([_poType isEqualToString:@"store"]){
        _titleArr = @[@"全部",@"待付款",@"待发货",@"待收货",@"待评价"];
    }
    
    
    /*
     hotel：酒店；
     insure：保险；
     travel：旅游；
     tickets：门票；
     store：商城；
     all：所有的订单(酒店|旅游|商城|餐饮)
     */
    
    _btnArr = [NSMutableArray array];
    _vcArr = [NSMutableArray array];
    
    CGFloat wid = SCREEN_WIDTH/_titleArr.count;
    CGFloat hig = HEIGHT_PRO(40);
    
    for (NSInteger i=0; i<_titleArr.count; i++) {
        UIView *backview = [[UIView alloc]init];
        backview.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:backview];
        [backview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(wid*i);
            make.top.equalTo(self.view);
            make.width.mas_equalTo(wid);
            make.height.mas_equalTo(hig);
        }];
        
        UIView *butomLineZWH = [[UIView alloc]init];
        butomLineZWH.backgroundColor = LINECOLOR;
        [backview addSubview:butomLineZWH];
        [butomLineZWH mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(backview);
            make.height.mas_equalTo(1);
        }];
        
        QMUIButton *btn = [[QMUIButton alloc]init];
        [btn setTitle:_titleArr[i] forState:0];
        btn.titleLabel.font = HTFont(28);
        [btn setTitleColor:ZWHCOLOR(@"#101010") forState:0];
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth = 1;
        btn.tag = i;
        btn.layer.borderColor = [UIColor clearColor].CGColor;
        [btn addTarget:self action:@selector(scroBtnWith:) forControlEvents:UIControlEventTouchUpInside];
        [backview addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(backview);
            make.width.mas_equalTo(wid*0.8);
            make.top.equalTo(backview).offset(HEIGHT_PRO(8));
            make.bottom.equalTo(backview).offset(-HEIGHT_PRO(8));
        }];
        [_btnArr addObject:btn];
    }
    
    
    // 初始化一个布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset =UIEdgeInsetsMake(0,0,0, 0);
    
    // 设置最小行距
    flowLayout.minimumLineSpacing = HEIGHT_PRO(0);
    // 设置最小间距
    flowLayout.minimumInteritemSpacing = WIDTH_PRO(0);
    // 设置格子大小
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-ZWHNavHeight-HEIGHT_PRO(40));
    // 设置组边界
    flowLayout.sectionInset = UIEdgeInsetsMake(HEIGHT_PRO(0), WIDTH_PRO(0), 0, WIDTH_PRO(0));
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 初始化集合视图
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    
    // 设置背景色
    _collectionView.backgroundColor = [UIColor whiteColor];
    // 设置代理和数据源
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(HEIGHT_PRO(40));
    }];
}

#pragma mark - 滑动按钮
-(void)scroBtnWith:(QMUIButton *)btn{
    if (_showBtn) {
        _showBtn.layer.borderColor = [UIColor clearColor].CGColor;
    }
    btn.layer.borderColor = ZWHCOLOR(@"#4BA4FF").CGColor;
    _showBtn = btn;
    [_collectionView setContentOffset:CGPointMake(SCREEN_WIDTH*btn.tag, 0) animated:YES];
}


#pragma mark - uicollectView

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat nav = ZWHNavHeight;
    return CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-nav-HEIGHT_PRO(40));
}



// 每组返回多少个格子
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    //防止列表控制器重新初始化
    if (_vcArr.count > 0) {
        for (NSInteger i=0;i<_vcArr.count;i++) {
            ZWHOrderListViewController *vc = _vcArr[i];
            if (vc.state == indexPath.row) {
                CGFloat nav = ZWHNavHeight;
                vc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav-HEIGHT_PRO(40));
                [cell.contentView addSubview:vc.view];
                [self addChildViewController:vc];
                //找到后直接返回cell
                return cell;
            }
        }
        ZWHOrderListViewController *vc = [[ZWHOrderListViewController alloc]init];
        vc.state = indexPath.row;
        vc.poType = _poType;
        CGFloat nav = ZWHNavHeight;
        vc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav-HEIGHT_PRO(40));
        [cell.contentView addSubview:vc.view];
        [self addChildViewController:vc];
        [_vcArr addObject:vc];
    }else{
        ZWHOrderListViewController *vc = [[ZWHOrderListViewController alloc]init];
        vc.state = indexPath.row;
        vc.poType = _poType;
        CGFloat nav = ZWHNavHeight;
        vc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav-HEIGHT_PRO(40));
        [cell.contentView addSubview:vc.view];
        [self addChildViewController:vc];
        [_vcArr addObject:vc];
    }
    return cell;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //判断滚动结束后当前偏移是否为最后一张
    CGFloat offsetX = scrollView.contentOffset.x;
    NSLog(@"%f",offsetX);
    if (_showBtn) {
        _showBtn.layer.borderColor = [UIColor clearColor].CGColor;
    }
    QMUIButton *btn = _btnArr[(NSInteger)offsetX/(NSInteger)SCREEN_WIDTH];
    btn.layer.borderColor = ZWHCOLOR(@"#4BA4FF").CGColor;
    _showBtn = btn;
}

//动画执行方法
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    //直接调用手动状态下的代理方法
    [self scrollViewDidEndDecelerating:scrollView];
}



@end
