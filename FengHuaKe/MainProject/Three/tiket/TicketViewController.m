//
//  TicketViewController.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/20.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "TicketViewController.h"
#import "ProductVM.h"
#import "TicketVM.h"
#import "LocationManager.h"
#import "TicketClassifyCell.h"
#import "TicketHotCell.h"
#import "TicketViewCell.h"
#import "ADInfoModel.h"
#import "TravelListModel.h"
#import "SDCycleScrollView.h"
#import "NSString+Addition.h"
#import "TickeDetailVC.h"
@interface TicketViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
@property(nonatomic,strong) SDCycleScrollView *cycleScrollView;
//
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,copy)NSString *cityname;
@property(nonatomic,copy)NSString *cityCode;
@property(nonatomic,copy)NSString *broCode;
//
@property(nonatomic,strong)NSMutableArray *classifyData;
@property(nonatomic,strong)NSMutableArray *hotfyData;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *adInfoData;

@end

@implementation TicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"门票";
      //定位
//     DefineWeakSelf;
//     [[LocationManager shareInstabce]startLocation:^(NSString *province, NSString *city) {
//
//        if (city.length>0) {
//            weakSelf.cityname=city;
//
//        }else
//        {
//            if (province.length>0) {
//                weakSelf.cityname=province;
//
//            }
//        }
//         NSLog(@"weakSelf.cityname:%@",weakSelf.cityname);
//    }];
    [self.view addSubview:self.tableview];
    self.tableview.tableHeaderView=self.cycleScrollView;
    [self GetADInfo];
    [self ClassifyList];
    [self TravelList];
    [self TicketList];
   
    
    // Do any additional setup after loading the view.
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    
}

#pragma mark - 懒加载
-(SDCycleScrollView *)cycleScrollView
{
    if (!_cycleScrollView) {
        // 网络加载 --- 创建带标题的图片轮播器
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenHeight, ScreenWidth*0.5) delegate:self placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
        
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _cycleScrollView.autoScrollTimeInterval=5;
        _cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
  
        
    }
    return _cycleScrollView;
}
-(NSString *)cityname
{
    if (!_cityname) {
        //默认城市
        _cityname=@"东莞市";
    }
    return _cityname;
}
-(NSString *)cityCode
{
    if (!_cityCode) {
        _cityCode=@"441900";
    }
    return _cityCode;
}
-(NSString *)broCode
{
    if (!_broCode) {
        _broCode=@"";
    }
    return _broCode;
}

-(UITableView *)tableview
{
    if (!_tableview) {

        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _tableview.tableFooterView=[UIView new];
        [_tableview registerClass:[TicketClassifyCell class] forCellReuseIdentifier:@"TicketClassifyCell"];
        [_tableview registerClass:[TicketHotCell class] forCellReuseIdentifier:@"TicketHotCell"];
        [_tableview registerNib:[UINib nibWithNibName:@"TicketViewCell" bundle:nil] forCellReuseIdentifier:@"TicketViewCell"];
        _tableview.delegate=self;
        _tableview.dataSource=self;
     
        
    }
    return _tableview;
}
#pragma mark -  Data
//轮播图
-(void)GetADInfo{
    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":@"",@"para2":@"travel"}];
    DefineWeakSelf;
    [TicketVM GetADInfoSysmodel:sysmodel Success:^(id responseData) {
//        NSLog(@"GetADInfo:%@",responseData);
        weakSelf.adInfoData=[ADInfoModel getDatawithdic:responseData];
        NSMutableArray *imageArray=[NSMutableArray array];
        for (ADInfoModel *model in weakSelf.adInfoData) {
            NSString *string=[model.PicAddress1 URLEncodedString];
            NSString *str=[DataProcess PicAdress:string];
            [imageArray addObject:str];

        }
        _cycleScrollView.imageURLStringsGroup = imageArray;
        
    } Fail:^(id erro) {
        
    }];
    
}
//分类
-(void)ClassifyList{
    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":self.classifyNo,@"para2":@""}];
    DefineWeakSelf;
    [ProductVM ClassifyListSysmodel:sysmodel Success:^(id responseData) {
        weakSelf.classifyData =[TicketClassifyModel getDatawithdic:responseData];
         NSLog(@"%ld",weakSelf.classifyData.count);
        NSIndexSet *set=[[NSIndexSet alloc]initWithIndex:0];
        [weakSelf.tableview reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    } Fail:^(id erro) {
        
    }];
}
//热门
-(void)TravelList{
     NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":self.classifyNo}];
    NSString *start=@"1";
    NSString *end=@"20";
    DefineWeakSelf;
    [TicketVM TravelListSysmodel:sysmodel Startindex:start Endindex:end Success:^(id responseData) {
        weakSelf.hotfyData=[TravelListModel getDatawithdic:responseData];
         NSLog(@"%ld",weakSelf.hotfyData.count);
         [weakSelf.tableview reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:NO];
    } Fail:^(id erro) {
        
    }];
}

//全部
-(void)TicketList{
//    【1（价格默认）2（销量）3（评分）】
    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":@"",@"para2":self.cityCode,@"para3":self.broCode,@"para4":@"1"}];
    NSString *start=@"1";
    NSString *end=@"20";
    DefineWeakSelf;
    [TicketVM TicketListSysmodel:sysmodel Startindex:start Endindex:end Success:^(id responseData) {

        weakSelf.dataArray=[TicketListModel getDatawithdic:responseData];
        NSLog(@"%ld",weakSelf.dataArray.count);
        [weakSelf.tableview reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:NO];
    } Fail:^(id erro) {
        
    }];
    
}
//通过城市名称获取城市code

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return 1;
        }
            break;
        case 2:
        {
            return self.dataArray.count;
        }
            break;
      
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            TicketClassifyCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TicketClassifyCell"];
            cell.titles=self.classifyData;
            return cell;
        }
            break;
        case 1:
        {
            TicketHotCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TicketHotCell"];
            cell.dataArray=self.hotfyData;
            DefineWeakSelf;
            cell.TickeHotBlock = ^(NSInteger index) {
                TravelListModel *model=weakSelf.hotfyData[index];
                TickeDetailVC *vc=[[TickeDetailVC alloc]init];
                vc.code=model.productno;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            };
            return cell;
        }
            break;
        case 2:
        {
            TicketViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TicketViewCell"];
            TicketListModel *model=self.dataArray[indexPath.row];
            cell.model=model;
            return cell;
        }
            break;
            
    }
    

    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            return ceil((CGFloat)self.classifyData.count/4)*70+10;
        }
            break;
        case 1:
        {
            return 180;
        }
            break;
        case 2:
        {
            return 98;
        }
            break;
            
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}


@end
