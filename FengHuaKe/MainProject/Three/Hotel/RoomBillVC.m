//
//  RoomBillVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "RoomBillVC.h"
#import "RoomBillHeaderCell.h"
#import "RoomBillCell.h"
#import "RoomBillPayWayCell.h"
@interface RoomBillVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSArray *cellids;
@end

@implementation RoomBillVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"订单";
//    self.automaticallyAdjustsScrollViewInsets=NO;
    self.dataArray=[NSMutableArray array];
    self.cellids=@[
               @[@"RoomBillHeaderCell",@"RoomBillCell",@"RoomBillCell",@"RoomBillCell",@"RoomBillCell",@"RoomBillCell"],
                
                   @[@"RoomBillPayWayCell"]
               ];
    [self.view addSubview:self.tableview];
    // Do any additional setup after loading the view.
}

#pragma mark - set/get
-(UITableView *)tableview
{
    if (!_tableview) {
        
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
        [_tableview registerNib:[UINib nibWithNibName:@"HotelRoomListCell" bundle:nil] forCellReuseIdentifier:@"HotelRoomListCell"];
     
        [_tableview registerClass:[RoomBillCell class] forCellReuseIdentifier:@"RoomBillCell"];
        [_tableview registerNib:[UINib nibWithNibName:@"RoomBillHeaderCell" bundle:nil] forCellReuseIdentifier:@"RoomBillHeaderCell"];
        [_tableview registerNib:[UINib nibWithNibName:@"RoomBillPayWayCell" bundle:nil] forCellReuseIdentifier:@"RoomBillPayWayCell"];
        _tableview.delegate=self;
        _tableview.dataSource=self;
       
        
    }
    return _tableview;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cellids.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cellids[section] count] ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RoomBillBaseCell *cell=[tableView dequeueReusableCellWithIdentifier:self.cellids[indexPath.section][indexPath.row]];
    [self swich:self.cellids[indexPath.section][indexPath.row] IndexPath:indexPath Cell:cell];
    return cell;
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellid=self.cellids[indexPath.section][indexPath.row];
    if ([cellid isEqualToString:@"RoomBillHeaderCell"])
    {
        return 109;
        
    }else if ([cellid isEqualToString:@"RoomBillCell"])
    {
        return 44;
        
    }else if([cellid isEqualToString:@"RoomBillPayWayCell"])
    {
        return 44;
    }
    return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSIndexPath *indexPath = [[NSIndexPath alloc]initWithIndex:section];
    if (1 == indexPath.section) {
         return 10;
    }else
    {
        return 0.1;
    }
   
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[UIView new];
    view.backgroundColor=defaultColor1;
    return view;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[UIView new];
    view.backgroundColor=defaultColor1;
    return view;
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
-(void)swich:(NSString*)cellid IndexPath:(NSIndexPath*)path Cell:(RoomBillBaseCell*)cell{

    if ([cellid isEqualToString:@"RoomBillHeaderCell"])
    {
          RoomBillHeaderCell *rcell=(RoomBillHeaderCell*)cell;
        rcell.label1.text=self.model.proname;
        rcell.label2.text=[NSString stringWithFormat:@"%@|%@|%@",self.model.spec,self.model.modelnum,self.model.material];
        rcell.label3.text=@"入住";
        rcell.label4.text=@"退房";
        
    }else if ([cellid isEqualToString:@"RoomBillCell"])
    {
        RoomBillCell *rcell=(RoomBillCell*)cell;
        switch (path.row) {
            case 1:
            {
                rcell.lable.text=@"预定数量";
            }
                break;
            case 2:
            {
                rcell.lable.text=@"入住者";
            }
                break;
            case 3:
            {
                rcell.lable.text=@"入住手机";
            }
                break;
            case 4:
            {
                rcell.lable.text=@"到店时间";
            }
                break;
            case 5:
            {
                rcell.lable.text=@"其他要求";
            }
                break;
                
            default:
                break;
        }
        
    }else if([cellid isEqualToString:@"RoomBillPayWayCell"])
    {
        RoomBillPayWayCell *rcell=(RoomBillPayWayCell*)cell;
        rcell.priceLabel.text=[NSString stringWithFormat:@"¥%@",self.model.saleprice1];
        rcell.priceLabel.textColor=[UIColor redColor];
        rcell.lable.text=@"在线支付";
    }
    
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
