//
//  HotelListVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "HotelListVC.h"
#import "HotelViewModel.h"
#import "UIViewController+HUD.h"
#import "HotelListCell.h"
#import "HotelRoomListVC.h"
#import "HotelView.h"
@interface HotelListVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@end

@implementation HotelListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"目的地";
    self.view.backgroundColor=[UIColor whiteColor];
    [self setHeader];
    [self.view addSubview:self.tableview];
    [self HotelList];
    
    // Do any additional setup after loading the view.
}
#pragma mark - Header
-(void)setHeader{
    
    NSArray *array=@[@"位置区域",@"价格/星级",@"智能排序",@"塞选"];
    NSInteger k=array.count;
    for (NSInteger i=0; i<k; i++) {
        CGFloat w=ScreenWidth/k-1;
        CGFloat h=49;
        CGFloat x=0+i*ScreenWidth/k;
        CGFloat y=0;
        HotelView *hview=[[HotelView alloc]initWithFrame:CGRectMake(x, y, w, h) Title:array[i]];
        
        if (i>0) {
            UIView *seprate=[[UIView alloc]initWithFrame:CGRectMake(i*w, 15,1, h-30)];
            seprate.backgroundColor=[UIColor lightGrayColor];
            [self.view addSubview:seprate];
        }
        [self.view addSubview:hview];
        
        
    }
    
    UIView *linview=[[UIView alloc]initWithFrame:CGRectMake(0, 49, ScreenWidth, 1)];
    linview.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:linview];
   
    
}
#pragma mark - set/get
-(UITableView *)tableview
{
    if (!_tableview) {
    
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0,50, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        [_tableview registerNib:[UINib nibWithNibName:@"HotelListCell" bundle:nil] forCellReuseIdentifier:@"HotelListCell"];
        _tableview.tableFooterView=[UIView new];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.mj_header=self.header;
        _tableview.mj_footer=self.footer;
        
    }
    return _tableview;
}
#pragma mark - fresh
-(void)headerFresh
{
    [self HotelList];
}
-(void)footFresh
{
    [self HotelList];
}
#pragma mark - post request
-(void)HotelList{
    
    NSString *start=[NSString stringWithFormat:@"%ld",self.startIndex];
    NSString *end=[NSString stringWithFormat:@"%ld",self.endIndex];
    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"intresult":@"1",@"blresult":@"false"}];
    [self showHudInView:self.view hint:@"加载中"];
    [HotelViewModel HotelListSysmodel:sysmodel Startindex:start Endindex:end Success:^(id responseData) {
        [self hideHud];
   
        NSDictionary *dic=responseData;
        if ([dic[@"sysmodel"][@"blresult"] intValue]) {
            NSString *jsonStr=dic[@"sysmodel"][@"strresult"];

            if (![jsonStr isEqual:[NSNull null]]) {
                DefineWeakSelf;
                NSData *data=[jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                NSObject *obj=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                NSArray *array=(NSArray*)obj;
                NSArray *result=[HotelListModel getDatawitharray:array];
               [ weakSelf.dataArray addObjectsFromArray:result];
                [weakSelf EndFreshWithArray:result];
                [weakSelf.tableview reloadData];
            }
            
        }else
        {
            
            [self showHint:@"获取失败"];
        }
    } Fail:^(id erro) {
        
    }];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotelListCell *cell=[tableView dequeueReusableCellWithIdentifier:@"HotelListCell"];
    cell.model=self.dataArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HotelRoomListVC *vc=[[HotelRoomListVC alloc]init];
    HotelListModel*model=self.dataArray[indexPath.row];
    vc.hotelID=model.SHOPID;
    vc.model=model;
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
