//
//  GroupBuyMananger.m
//  FengHuaKe
//
//  Created by chenheng on 2019/7/19.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "GroupBuyMananger.h"
#import "DoGroupBuyController.h"
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

-(void)backToGroupBuy
{
    UIViewController * current = [[DataProcess shareInstance] getCurrentVC];
    for (UIViewController * vc in current.navigationController.viewControllers) {
        if ([vc.class isEqual:DoGroupBuyController.class]) {
            [current.navigationController popToViewController:vc animated:YES];
        }
    }
    
}
-(void)po_GroupBuyIdentify:(NSString*)identify;
{
    NSDictionary * datalistDic;
    NSDictionary * system;
    if ([model.module isEqualToString:@"ticket"]) {
        datalistDic = [self.ticket.commonArguments mj_keyValues];
        system = [self.ticket.groupBuyParams mj_keyValues];
    }
    
    if ([model.module isEqualToString:@"hotel"]) {
        datalistDic = [self.hotel.commonArguments mj_keyValues];
        system = [self.hotel.groupBuyParams mj_keyValues];
    }
    
    if ([model.module isEqualToString:@"travelspec"]) {
        datalistDic = [self.travelspec.commonArguments mj_keyValues];
        system = [self.travelspec.groupBuyParams mj_keyValues];
    }
    
    if ([model.module isEqualToString:@"repast"]) {
        datalistDic = [self.repast.commonArguments mj_keyValues];
        system = [self.repast.groupBuyParams mj_keyValues];
    }
    
    if ([model.module isEqualToString:@"travelgoods"]) {
        datalistDic = [self.travelgoods.commonArguments mj_keyValues];
        system = [self.travelgoods.groupBuyParams mj_keyValues];
    }
    
    NSLog(@"po_GroupBuy:%@",GETRequestStr(@[datalistDic], system, nil, nil, nil));
//        [DataProcess requestDataWithURL:PO_GroupBuy RequestStr:GETRequestStr(@[datalistDic], system, nil, nil, nil) Result:^(id obj, id erro) {
//            if (obj) {
//                [SVProgressHUD showSuccessWithStatus:@"拼单成功!"];
//            }
//        }];
}

    
@end

@implementation CommonArguments



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

