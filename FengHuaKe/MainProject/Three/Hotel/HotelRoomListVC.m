//
//  HotelRoomListVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "HotelRoomListVC.h"
#import "HotelViewModel.h"
#import "HotelRoomListCell.h"
#import "UIViewController+HUD.h"
#import "RoomDetailVC.h"
#import "RoomBillVC.h"
@interface HotelRoomListVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@end

@implementation HotelRoomListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"房间";
    [self setHeader];
    [self.view addSubview:self.tableview];
    [self HotelRoomList];
//    [self HotelRoom];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
}
-(void)setHeader{

    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*0.5)];
    [self.view addSubview:imageView];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[DataProcess PicAdress:self.model.LogoUrl]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.5, ScreenWidth, 70)];
    [self.view addSubview:view];
    
    UILabel *lable1=[[UILabel alloc]initWithFrame:CGRectMake(12, 8, ScreenWidth-20, 20)];
    [view addSubview:lable1];
    lable1.font=[UIFont systemFontOfSize:15];
    lable1.text=self.model.ShopName;
    UILabel *lable2=[[UILabel alloc]initWithFrame:CGRectMake(12, 36, 60, 20)];
    [view addSubview:lable2];
    
    lable2.text=[NSString stringWithFormat:@"%@分",self.model.grade];
    lable2.font=[UIFont boldSystemFontOfSize:13];
    lable2.textColor=MainColor;
    UILabel *lable3=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lable2.frame), 36, ScreenWidth-80-69-12, 20)];
    [view addSubview:lable3];
    lable3.text=[NSString stringWithFormat:@"评论数:%@+",self.model.commentnums];
    lable3.font=[UIFont systemFontOfSize:13];
    lable3.textColor=[UIColor darkGrayColor];
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-80, 36, 60, 30)];
    [button setTitle:@"详情>>" forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:14];
    [button setTitleColor:MainColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(detail) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UIView *linview=[[UIView alloc]initWithFrame:CGRectMake(0, view.height-1, ScreenWidth, 1)];
    linview.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [view addSubview:linview];
    
    
}
-(void)detail{
    
    
}

#pragma mark - fresh
-(void)headerFresh
{
    [self HotelRoomList];
}
-(void)footFresh
{
    [self HotelRoomList];
}
#pragma mark - set/get
-(UITableView *)tableview
{
    if (!_tableview) {
        
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0,ScreenWidth*0.5+70, ScreenWidth, ScreenHeight-ScreenWidth*0.5-70) style:UITableViewStylePlain];
        [_tableview registerNib:[UINib nibWithNibName:@"HotelRoomListCell" bundle:nil] forCellReuseIdentifier:@"HotelRoomListCell"];
        _tableview.tableFooterView=[UIView new];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.mj_header=self.header;
        _tableview.mj_footer=self.footer;
        
    }
    return _tableview;
}

#pragma mark - postRequest
-(void)HotelRoomList
{
    NSString *start=[NSString stringWithFormat:@"%ld",self.startIndex];
    NSString *end=[NSString stringWithFormat:@"%ld",self.endIndex];
     NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":self.hotelID}];
     [self showHudInView:self.view hint:@"加载中"];
    [HotelViewModel HotelRoomListSysmodel:sysmodel Startindex:start Endindex:end Success:^(id responseData) {
        [self hideHud];
        NSLog(@"responseData:%@",responseData);
        NSDictionary *dic=responseData;
        if ([dic[@"sysmodel"][@"blresult"] intValue]) {
            NSString *jsonStr=dic[@"sysmodel"][@"strresult"];
            
            if (![jsonStr isEqual:[NSNull null]]) {
                DefineWeakSelf;
                NSData *data=[jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                NSObject *obj=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                NSArray *array=(NSArray*)obj;
                NSArray *result=[HotelRoomListModel getDatawitharray:array];
                [weakSelf.dataArray addObjectsFromArray:result];
                [weakSelf EndFreshWithArray:result];
                [weakSelf.tableview reloadData];
            }
            
        }else
        {
            
            [self showHint:@"获取群组失败"];
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
    HotelRoomListCell *cell=[tableView dequeueReusableCellWithIdentifier:@"HotelRoomListCell"];
    cell.model=self.dataArray[indexPath.row];
    DefineWeakSelf;
    cell.resrveBlock = ^{
        RoomBillVC *vc=[[RoomBillVC alloc]init];
        vc.model=self.dataArray[indexPath.row];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HotelRoomListModel*model=self.dataArray[indexPath.row];
    RoomDetailVC *vc=[[RoomDetailVC alloc]init];
    vc.hotelID=self.hotelID;
    vc.roomID=model.productno;
    [self.navigationController pushViewController:vc animated:YES];
  
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
