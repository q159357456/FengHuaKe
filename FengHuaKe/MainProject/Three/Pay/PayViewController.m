//
//  PayViewController.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/17.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "PayViewController.h"
#import "PayTableViewCell.h"
#import "UIViewController+HUD.h"
#import <AlipaySDK/AlipaySDK.h>
#import "PayVM.h"
@interface PayViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_imageArray;
    NSArray *_titleArray;
    NSInteger _sletIndex;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"支付";
    self.view.backgroundColor=[UIColor whiteColor];
    self.tableView.tableFooterView=[UIView new];
    _imageArray=@[@"weixin",@"zhifubao"];
    _titleArray=@[@"微信",@"支付宝"];
    self.button.backgroundColor=MainColor;
//    NSLog(@"self.orderDetailL%@",self.orderDetail);
//    [self.tableView registerNib:[UINib nibWithNibName:@"PayTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PayTableViewCell"];
//    [self.tableView registerNib:[UINib nibWithNibName:@"PayHeaderCell" bundle:nil] forCellReuseIdentifier:@"PayHeaderCell"];
    // Do any additional setup after loading the view from its nib.
}
-(void)SeverPay
{
    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":UniqUserID}];
    DefineWeakSelf;
    [PayVM AlipayPaySysmodel:sysmodel Datalist:self.orderDetail Success:^(id responseData){
        NSDictionary *dic=(NSDictionary*)responseData;
        if ([dic[@"sysmodel"][@"blresult"] intValue]) {
            [weakSelf AlipayWithOrder:dic[@"sysmodel"][@"strresult"]];
        }else
        {
            [self showHint:dic[@"msg"]];
        }

    } Fail:^(id erro) {
        
    }];

}
#pragma mark - Alipay
-(void)AlipayWithOrder:(NSString*)order
{
  [[AlipaySDK defaultService]payOrder:order fromScheme:@"FengHuaKe" callback:^(NSDictionary *resultDic) {
      
      NSLog(@"Alipay---resultDic  :%@",resultDic);
  }];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}
- (IBAction)pay:(UIButton *)sender {

    if (_sletIndex==1) {
        //微信
        NSLog(@"/微信");
        
    }else if (_sletIndex==2)
    {
        //支付宝
         NSLog(@"/支付宝");
        [self SeverPay];
    }else
    {
        //没选中
          NSLog(@"/没选中");
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    return 2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        PayHeaderCell *cell=[[NSBundle mainBundle]loadNibNamed:@"PayTableViewCell" owner:nil options:nil][1];
        cell.lable1.text=[NSString stringWithFormat:@"￥%@",self.totalAmount];
        return cell;
    }else
    {
        PayTableViewCell *cell=[[NSBundle mainBundle]loadNibNamed:@"PayTableViewCell" owner:nil options:nil][0];
        cell.lable.text=_titleArray[indexPath.row];
        cell.headImage.image=[UIImage imageNamed:_imageArray[indexPath.row]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 100;
    }else
    {
        return 44;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0)
    {
        
    }else
    {
        PayTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        cell.sleted.backgroundColor=MainColor;
        _sletIndex=indexPath.row+1;
        
    }
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        
    }else
    {
        PayTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        cell.sleted.backgroundColor=[UIColor whiteColor];
        
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
