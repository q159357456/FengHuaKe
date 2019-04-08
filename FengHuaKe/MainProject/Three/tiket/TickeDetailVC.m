//
//  TickeDetailVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/21.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "TickeDetailVC.h"
#import "TicketVM.h"
#import "TicketSingleModel.h"
#import "UIViewController+HUD.h"
#import "TicketNoticeVC.h"
#import "TiketDetailFirstCell.h"
#import "TiketDetailSecondCell.h"
#import "TiketDetailThirdCell.h"
#import "TiketDetailForthCell.h"
#import "TiketDetailFifthCell.h"
#import "NSString+Addition.h"
#import "TicektBillVC.h"
@interface TickeDetailVC ()<UITableViewDelegate,UITableViewDataSource,PublishCountBaseDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)TicketSingleModel *model;
@property(nonatomic,strong)NSMutableArray *ticketInfoData;
@property(nonatomic,strong)UIImageView *headerView;
@end

@implementation TickeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.tableview];
    [self TicketSingle];
    // Do any additional setup after loading the view.
}
#pragma mark - 懒加载
-(UITableView *)tableview
{
    if (!_tableview) {
        
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
        _tableview.tableHeaderView=self.headerView;
        [_tableview registerClass:[TiketDetailFirstCell class] forCellReuseIdentifier:@"TiketDetailFirstCell"];
        [_tableview registerClass:[TiketDetailSecondCell class] forCellReuseIdentifier:@"TiketDetailSecondCell"];
        [_tableview registerClass:[TiketDetailThirdCell class] forCellReuseIdentifier:@"TiketDetailThirdCell"];
        [_tableview registerClass:[TiketDetailForthCell class] forCellReuseIdentifier:@"TiketDetailForthCell"];
        [_tableview registerClass:[TiketDetailFifthCell class] forCellReuseIdentifier:@"TiketDetailFifthCell"];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        
        
    }
    return _tableview;
}
-(UIImageView *)headerView
{
    if (!_headerView) {
        _headerView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*0.5)];

    }
    return _headerView;
}
#pragma mark - privcy
-(void)getticketInfoData{
    self.ticketInfoData=[NSMutableArray array];
    NSArray *array1=self.model.SpecTree;
    for (TicketSonTypeModel *son in array1) {
        [self.ticketInfoData addObject:son];
        for (TicketSubSonModel *sub in son.Table) {
            [self.ticketInfoData addObject:sub];
            
        }
        
    }
    [self.tableview reloadData];
    
}
#pragma mark - PublishCountBaseDelegate
-(void)CellEvent:(RoomBillBaseCell *)cell Valuae:(id)valuae{
    if ([cell isKindOfClass:[TiketDetailForthCell class]]) {
        
        switch ([valuae integerValue]) {
            case 1:
            {
                NSIndexPath *path=[self.tableview indexPathForCell:cell];
                TicketSubSonModel *model=self.ticketInfoData[path.row];
                TicektBillVC *vc=[[TicektBillVC alloc]init];
                vc.model=model;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                
                NSIndexPath *path=[self.tableview indexPathForCell:cell];
                TicketSubSonModel *model=self.ticketInfoData[path.row];
                [self buyNoticeWith:model];
            }
                break;
                
          
        }
        
    }
    
}

#pragma mark - DATA
-(void)TicketSingle{
    MJWeakSelf;
    [HttpHandler getTicketSingle:@{@"para1":self.code} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        if (ReturnValue==1) {
            
            
            
            NSArray *array = [HttpTool getArrayWithData:obj[@"sysmodel"][@"strresult"]];
            NSArray *result=[TicketSingleModel getDatawitharray:array];
            weakSelf.model=result.firstObject;
            weakSelf.model= [TicketSingleModel mj_objectWithKeyValues:array[0]];
            [weakSelf getticketInfoData];
            NSString *url=[self.model.url URLEncodedString];
            [weakSelf.headerView sd_setImageWithURL:[NSURL URLWithString:[DataProcess PicAdress:url]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
        }
    } failed:^(id obj) {
        
    }];
    
//     NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":self.code}];
//    DefineWeakSelf;
//    [self showHudInView:self.view hint:@""];
//    NSLog(@"%@",sysmodel);
//[TicketVM TicketSingleSysmodel:sysmodel Success:^(id responseData) {
//        [weakSelf hideHud];
//        NSDictionary *dic=responseData;
//        if ([dic[@"sysmodel"][@"blresult"] intValue]) {
//            NSString *jsonStr=dic[@"sysmodel"][@"strresult"];
//
//            if (![jsonStr isEqual:[NSNull null]]) {
//
//                NSData *data=[jsonStr dataUsingEncoding:NSUTF8StringEncoding];
//                NSObject *obj=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//                NSArray *array=(NSArray*)obj;
//                NSArray *result=[TicketSingleModel getDatawitharray:array];
//                weakSelf.model=result.firstObject;
//                [weakSelf getticketInfoData];
//                NSString *url=[self.model.url URLEncodedString];
//                [weakSelf.headerView sd_setImageWithURL:[NSURL URLWithString:[DataProcess PicAdress:url]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
//            }
//
//        }else
//        {
//
//            [self showHint:@"获取失败"];
//        }
//    } Fail:^(id erro) {
//
//    }];
}

#pragma mark - 购买须知
-(void)buyNoticeWith:(TicketSubSonModel *)model{
    
    TicketNoticeVC *vc=[[TicketNoticeVC alloc]init];
    vc.model=model;
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:vc animated:YES completion:nil];
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.model) {
        return 3;
    }else
    {
        return 0;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    switch (section) {
        case 0:
        {
            return 3;
        }
            break;
        case 1:
        {
            return self.ticketInfoData.count;
        }
            break;
        case 2:
        {
            return 2;
        }
            break;
            
    };
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0)
            {
                TiketDetailFirstCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TiketDetailFirstCell"];
                cell.lable.text=self.model.proname;
                cell.lable1.text=[NSString stringWithFormat:@"%@分",self.model.grade];
                cell.freight=self.model.freight;
                return cell;
                
            }else if(indexPath.row == 1)
            {
                TiketDetailSecondCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TiketDetailSecondCell"];
            
                cell.lable.text=[NSString stringWithFormat:@"%@%@%@",self.model.brand,self.model.fitsex,self.model.material];
                return cell;
                
            }else{
                TiketDetailSecondCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TiketDetailSecondCell"];
                cell.lable.text=self.model.remark;
                return cell;
            }
            
            
        }
            break;
        case 1:
        {
            NSObject *obj= self.ticketInfoData[indexPath.row];
            
            if ([obj isKindOfClass:[TicketSonTypeModel class]])
            {
                TicketSonTypeModel *model=(TicketSonTypeModel*)obj;
                TiketDetailThirdCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TiketDetailThirdCell"];
                cell.lable.text=model.Value;
                return cell;
            }else
            {
                TicketSubSonModel *model=(TicketSubSonModel*)obj;
                TiketDetailForthCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TiketDetailForthCell"];
                cell.baseDelegate=self;
                cell.model=model;
                return cell;
            }
            
        }
            break;
        case 2:
        {
            if (indexPath.row==0)
            {
                TiketDetailFifthCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TiketDetailFifthCell"];
                cell.lable.text=@"开放时间";
                return cell;
            }else
            {
                TiketDetailSecondCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TiketDetailSecondCell"];
                cell.lable.text=@"用时建议";
                return cell;
            }
            
        }
            break;
            
    };
 
//            TicketClassifyCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TicketClassifyCell"];
//            cell.titles=self.classifyData;
//            return cell;
      
    
    
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                return 70;
                
            }else if(indexPath.row == 1)
            {
                 return 43;
            }else{
                 return 43;
            }
            
            
        }
            break;
        case 1:
        {
            NSObject *obj= self.ticketInfoData[indexPath.row];
            
            if ([obj isKindOfClass:[TicketSonTypeModel class]]) {
                
                 return 40;
            }else
            {
                 return 88;
            }
            
        }
            break;
        case 2:
        {
            if (indexPath.row==0)
            {
                return 80;
            }else
            {
                return 43;
            }
            
        }
            break;
            
    };
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 0.01;
        }
            break;
            
        case 1:
        {
            return 40;
        }
            break;
        case 2:
        {
            return 40;
        }
            break;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 10;
    }else if(section == 1)
    {
        return 10;
       
    }else
    {
         return 0.01;
    }
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UILabel *lable=[UILabel new];
        lable.font=[UIFont boldSystemFontOfSize:13];
        lable.backgroundColor=[UIColor whiteColor];
        lable.text=@"  门票预定";
        return lable;
    }else if(section == 2)
    {
        UILabel *lable=[UILabel new];
        lable.font=[UIFont boldSystemFontOfSize:13];
        lable.backgroundColor=[UIColor whiteColor];
        lable.text=@"  景点信息";
        return lable;
        
    }else
    {
         return [UIView new];
    }
   
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return  [UIView new];
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
