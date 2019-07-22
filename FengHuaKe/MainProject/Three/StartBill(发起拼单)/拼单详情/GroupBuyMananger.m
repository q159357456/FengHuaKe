//
//  GroupBuyMananger.m
//  FengHuaKe
//
//  Created by chenheng on 2019/7/19.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "GroupBuyMananger.h"
#import "DoGroupBuyController.h"
#import "ZWHOrderModel.h"
#import "ZWHOrderPayViewController.h"
static GroupBuyMananger *groupBuyMananger = nil;
@implementation GroupBuyMananger
+ (instancetype)singleton
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        groupBuyMananger = [[super allocWithZone:nil]init];
    });
    return groupBuyMananger;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [GroupBuyMananger singleton];
}
-(GroupBuyClassify *)ticket
{
    if (!_ticket) {
        _ticket = [[GroupBuyClassify alloc]init];
    }
    return _ticket;
}

-(GroupBuyClassify *)hotel
{
    if (!_hotel) {
        _hotel = [[GroupBuyClassify alloc]init];
    }
    return _hotel;
    
}

-(GroupBuyClassify *)travelspec
{
    if (!_travelspec) {
        _travelspec = [[GroupBuyClassify alloc]init];
    }
    return _travelspec;
}

-(GroupBuyClassify *)repast
{
    if (!_repast) {
        _repast = [[GroupBuyClassify alloc]init];
    }
    return _repast;
}

-(GroupBuyClassify *)travelgoods
{
    if (!_travelgoods) {
        _travelgoods = [[GroupBuyClassify alloc]init];
    }
    return _travelgoods;
}

-(void)backToGroupBuyWithProName:(NSString*)proName
{
    UIViewController * current = [[DataProcess shareInstance] getCurrentVC];
    for (UIViewController * vc in current.navigationController.viewControllers) {
        if ([vc.class isEqual:DoGroupBuyController.class]) {
            [vc performSelector:@selector(setProductInfo:) withObject:proName];
            [current.navigationController popToViewController:vc animated:YES];
        }
    }
    
}
-(void)po_GroupBuyIdentify:(NSString*)identify;
{
    NSDictionary * datalistDic;
    NSDictionary * system;
    if ([identify isEqualToString:@"ticket"]) {
        datalistDic = [self.ticket.commonArguments mj_keyValues];
        system = [self.ticket.groupBuyParams mj_keyValues];
    }
    
    if ([identify isEqualToString:@"hotel"]) {
        datalistDic = [self.hotel.commonArguments mj_keyValues];
        system = [self.hotel.groupBuyParams mj_keyValues];
    }
//
//    if ([identify isEqualToString:@"travelspec"]) {
//        datalistDic = [self.travelspec.commonArguments mj_keyValues];
//        system = [self.travelspec.groupBuyParams mj_keyValues];
//    }
    
    if ([identify isEqualToString:@"repast"]) {
        datalistDic = [self.repast.commonArguments mj_keyValues];
        system = [self.repast.groupBuyParams mj_keyValues];
    }
    
    if ([identify isEqualToString:@"travelgoods"] || [identify isEqualToString:@"travelspec"]) {
        datalistDic = [self.travelgoods.commonArguments mj_keyValues];
        system = [self.travelgoods.groupBuyParams mj_keyValues];
    }
    NSLog(@"1:%@",datalistDic);
    NSLog(@"2:%@",system);
    [DataProcess requestDataWithURL:PO_GroupBuy RequestStr:GETRequestStr(@[datalistDic], system, nil, nil, nil) Result:^(id obj, id erro) {
            NSLog(@"obj===>%@",obj);
            NSLog(@"erro===>%@",erro);
            if (ReturnValue) {
//                [SVProgressHUD showSuccessWithStatus:@"拼单成功!"];
                UIViewController * current = [[DataProcess shareInstance] getCurrentVC];
//                [current.navigationController popViewControllerAnimated:YES];
                NSDictionary *dict = obj[@"DataList"][0];
                [ZWHOrderModel mj_objectClassInArray];
                ZWHOrderModel *model = [ZWHOrderModel mj_objectWithKeyValues:dict];
                ZWHOrderPayViewController *vc = [[ZWHOrderPayViewController alloc]init];
                vc.state = 9;
                vc.orderModelList = @[model];
                [current.navigationController pushViewController:vc animated:YES];
                
            }else
            {
                if (erro) {
                [SVProgressHUD showErrorWithStatus:erro[@"msg"]];
            }
               
            }
        }];
}

    
@end

@implementation CommonArguments
-(NSString *)memberid
{
    if (!_memberid) {
        
        _memberid = UniqUserID;
    }
    return _memberid;
}
-(NSString *)membertype
{
    if (!_membertype) {
        
        _membertype = MEMBERTYPE;
    }
    return _membertype;
}
-(NSString *)remark
{
    if (!_remark) {
        
        _remark = @"";
    }
    return  _remark;
}
@end

@implementation GroupBuyParams



@end

@implementation GroupBuyClassify

-(CommonArguments *)commonArguments
{
    if (!_commonArguments) {
        _commonArguments = [[CommonArguments alloc]init];
    }
    return _commonArguments;
}

-(GroupBuyParams *)groupBuyParams
{
    if (!_groupBuyParams) {
        _groupBuyParams = [[GroupBuyParams alloc]init];
    }
    return _groupBuyParams;
}
@end

