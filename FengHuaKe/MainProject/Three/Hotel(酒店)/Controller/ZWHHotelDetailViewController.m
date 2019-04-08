//
//  ZWHHotelDetailViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/23.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHHotelDetailViewController.h"

#import "ZWHHotelBillViewController.h"

#import "RoomDetailVC.h"

#import "HotelRoomListModel.h"
#import "ZWHHotelRoomTableViewCell.h"

@interface ZWHHotelDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *detailTable;

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger index;

@property(nonatomic,strong)QMUIFloatLayoutView *tipsView;

@end

@implementation ZWHHotelDetailViewController

-(UIImage *)navigationBarBackgroundImage{
    return [UIImage new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

-(void)setUI{
    
    self.dataArray = [NSMutableArray array];
    self.index = 1;
    
    _detailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-HEIGHT_PRO(50)) style:UITableViewStylePlain];
    [self.view addSubview:_detailTable];
    [_detailTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(self.view);
        //make.top.equalTo(self.view).offset(ZWHNavHeight);
    }];
    _detailTable.delegate = self;
    _detailTable.dataSource = self;
    _detailTable.separatorStyle = 0;
    _detailTable.backgroundColor = LINECOLOR;
    _detailTable.showsVerticalScrollIndicator = NO;
    [_detailTable registerClass:[ZWHHotelRoomTableViewCell class] forCellReuseIdentifier:@"ZWHHotelRoomTableViewCell"];
    self.keyTableView = _detailTable;
    [self setHeader];
    [self setRefresh];
}

-(void)setHeader{
    UIView *headView = [[UIView alloc]init];
    UIImageView *img = [[UIImageView alloc]init];
    [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,_mymodel.LogoUrl]] placeholderImage:[UIImage imageNamed:@"WechatIMG2"]];
    [headView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(headView);
        make.height.mas_equalTo(HEIGHT_PRO(200));
    }];
    
    QMUILabel *title = [[QMUILabel alloc]qmui_initWithFont:HTFont(32) textColor:[UIColor blackColor]];
    title.text = [NSString stringWithFormat:@"%@(%@%@)",_mymodel.ShopName,_mymodel.cityName,_mymodel.boroName];
    [headView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView).offset(WIDTH_PRO(8));
        make.top.equalTo(img.mas_bottom).offset(HEIGHT_PRO(3));
    }];
    
    QMUILabel *point = [[QMUILabel alloc]qmui_initWithFont:HTFont(32) textColor:MAINCOLOR];
    point.text = [NSString stringWithFormat:@"%@分",_mymodel.grade];
    [headView addSubview:point];
    [point mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView).offset(WIDTH_PRO(8));
        make.top.equalTo(title.mas_bottom).offset(HEIGHT_PRO(6));
    }];
    
    QMUILabel *comNum = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:ZWHCOLOR(@"#808080")];
    comNum.text = [NSString stringWithFormat:@"%@+评价",_mymodel.commentnums];
    [headView addSubview:comNum];
    [comNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(point.mas_right).offset(WIDTH_PRO(8));
        make.bottom.equalTo(point.mas_bottom);
    }];
    
    _tipsView = [[QMUIFloatLayoutView alloc]init];
    _tipsView.itemMargins = UIEdgeInsetsMake(0, 0, 10, 10);
    [headView addSubview:_tipsView];
    NSArray *arr = @[@"实惠型"];
    
    for (NSInteger i=0; i<arr.count; i++) {
        QMUILabel *lab = [[QMUILabel alloc]qmui_initWithFont:HTFont(20) textColor:MAINCOLOR];
        lab.text = arr[i];
        lab.contentEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
        lab.qmui_borderColor = MAINCOLOR;
        lab.qmui_borderWidth = 1;
        lab.qmui_borderPosition = QMUIViewBorderPositionTop | QMUIViewBorderPositionLeft | QMUIViewBorderPositionRight | QMUIViewBorderPositionBottom;
        lab.layer.cornerRadius = 3;
        lab.layer.masksToBounds = YES;
        [_tipsView addSubview:lab];
    }
    
    CGSize floatLayoutViewSize = [_tipsView sizeThatFits:CGSizeMake(SCREEN_WIDTH-WIDTH_PRO(150), CGFLOAT_MAX)];
    
    [_tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(comNum.mas_right).offset(WIDTH_PRO(8));
        make.bottom.equalTo(point.mas_bottom);
        make.right.equalTo(headView).offset(-WIDTH_PRO(60));
        make.height.mas_equalTo(floatLayoutViewSize.height);
    }];
    
    headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(260));
    _detailTable.tableHeaderView = headView;
    
}


#pragma mark - 获得房间信息
-(void)getRoomList{
    
    NSNumber *startIndex = [NSNumber numberWithInteger:_index];
    
    MJWeakSelf
    [HttpHandler getHotelRoomList:@{@"para1":_mymodel.SHOPID} start:startIndex end:@(10) querytype:@"0" Success:^(id obj) {
        [weakSelf hideEmptyView];
        [weakSelf.detailTable.mj_header endRefreshing];
        [weakSelf.detailTable.mj_footer endRefreshing];
        if (ReturnValue==1) {
            NSArray *ary = [HttpTool getArrayWithData:obj[@"sysmodel"][@"strresult"]];
            if (ary.count == 0) {
                [weakSelf.detailTable.mj_footer endRefreshingWithNoMoreData];
            }else{
                [weakSelf.dataArray addObjectsFromArray: [HotelRoomListModel mj_objectArrayWithKeyValuesArray:ary]];
            }
            [weakSelf.detailTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        }
    } failed:^(id obj) {
        [weakSelf.detailTable.mj_header endRefreshing];
        [weakSelf.detailTable.mj_footer endRefreshing];
    }];
}

-(void)setRefresh{
    MJWeakSelf
    _detailTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.dataArray = [NSMutableArray array];
        weakSelf.index = 1;
        [weakSelf getRoomList];
    }];
    _detailTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.index ++ ;
        [weakSelf getRoomList];
    }];
    [_detailTable.mj_header beginRefreshing];
}

#pragma mark - uitableviewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HEIGHT_PRO(10);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_PRO(80);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWHHotelRoomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHHotelRoomTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = 0;
    cell.model = _dataArray[indexPath.row];
    cell.pay.tag = indexPath.row;
    [cell.pay addTarget:self action:@selector(paytoBill:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HotelRoomListModel*model=self.dataArray[indexPath.row];
    RoomDetailVC *vc=[[RoomDetailVC alloc]init];
    vc.hotelID=_mymodel.SHOPID;
    vc.roomID=model.productno;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 预定
-(void)paytoBill:(QMUIButton *)btn{
    ZWHHotelBillViewController *vc = [[ZWHHotelBillViewController alloc]init];
    vc.model = _dataArray[btn.tag];
    vc.hotelID=_mymodel.SHOPID;
    vc.timeArr = _timeArr;
    vc.title = _mymodel.ShopName;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
