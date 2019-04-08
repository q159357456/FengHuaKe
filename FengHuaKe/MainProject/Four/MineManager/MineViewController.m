//
//  MineViewController.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/13.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "MineViewController.h"
#import <Hyphenate/Hyphenate.h>
#import "MineHeadview.h"
#import "MineOneCell.h"
#import "MineTwoCell.h"
#import "MineThreeCell.h"
#import "MineFourCell.h"
#import "CatageThreeCell.h"
#import "FriendsShowTBVC.h"
#import "MyNotosVC.h"
#import "ShopCarViewController.h"
#import "AdressListVC.h"
#import "AllUnCompleteBillVC.h"
#import "ZWHCashcouponViewController.h"
#import "ZWHCashViewController.h"
#import "ZWHIntegralViewController.h"
#import "ZWHBrokerageViewController.h"
#import "ZWHColleagueViewController.h"
#import "ZWHCollectionViewController.h"
#import "ZWHHistoryViewController.h"
#import "ZWHInvoiceListViewController.h"
#import "ZWHOrderViewController.h"
#import "ZWHAfterSaleViewController.h"
#import "ZWHOrderServiceViewController.h"
#import "ZWHMyinsuranceViewController.h"
#import "ZWHMyHeaderView.h"
#import "ZWHMyQRViewController.h"
#import "FMDBUserTable.h"
#import "FMDBGroupTable.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *unchangArray;
@property(nonatomic,strong)NSArray *titeArray;
@property(nonatomic,strong)NSArray *imageArray;
@property(nonatomic,strong)NSArray *rowHeightArray;

@property(nonatomic,strong)NSDictionary *assetDict;

//@property(nonatomic,strong)MineHeadview *headerView;

@property(nonatomic,strong)ZWHMyHeaderView *ZWHheaderView;

@end

@implementation MineViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self getDataSource];
    //[self setUI];
}

-(void)setUI{
    self.unchangArray=@[@[@"MineOneCell",@"MineTwoCell",@"MineTwoCell"],@[@"MineThreeCell",@"MineThreeCell"],@[@"CatageThreeCell",@"MineFourCell"],@[@"CatageThreeCell",@"MineFourCell"],@[@"CatageThreeCell",@"MineFourCell"],@[@"CatageThreeCell",@"MineFourCell"]];
    NSArray *array1=@[@"全部订单",@"待付款",@"待评价",@"售后服务"];
    NSArray *array2=@[@"旅游订单",@"酒店订单",@"商城订单",@"餐饮订单"];
    NSArray *array3=@[@"代金券",@"现金",@"返现",@"积分",@"优惠券",@"佣金"];
    NSArray *array4=@[@"我的上级",@"我的下级",@"我的商家",@"我的供应商"];
    NSArray *array5=@[@"收获地址",@"我的收藏",@"浏览历史",@"历史行程"];
    NSArray *array6=@[@"我的保险",@"发票管理",@"出行管家",@"签证"];
    
    self.titeArray=@[@[@"",@"旅游直播",@"自主程序链接"],@[array1,array2],@[@"我的资产",array3],@[@"我的团队",array4],@[@"记录",array5],@[@"其他",array6]];
    
    NSArray *imageArray1=@[@"ceshi_4_6",@"ceshi_4_7",@"ceshi_4_8",@"ceshi_4_7",@"ceshi_4_9",@"ceshi_4_10"];
    NSArray *imageArray2=@[@"ceshi_4_11",@"ceshi_4_12",@"ceshi_4_13",@"ceshi_4_14"];
    NSArray *imageArray3=@[@"ceshi_4_15",@"ceshi_4_16",@"ceshi_4_17",@"ceshi_4_18"];
    NSArray *imageArray4=@[@"ceshi_4_19",@"ceshi_4_20",@"ceshi_4_21",@"ceshi_4_22"];
    self.imageArray=@[@[@"",@"ceshi_4_4",@"ceshi_4_5"],@[@"",@""],@[@"",imageArray1],@[@"",imageArray2],@[@"",imageArray3],@[@"",imageArray4]];
    
    
    self.rowHeightArray=@[@[@43,@43,@43],@[@43,@43],@[@38,@200],@[@38,@100],@[@38,@100],@[@38,@100]];
    [self.view addSubview:self.tableview];
    self.tableview.tableFooterView=[[UIView alloc]init];
    self.tableview.tableHeaderView = self.ZWHheaderView;
    
    
    self.keyTableView = self.tableview;
}



#pragma mark DataSoure
-(void)getDataSource{
    MJWeakSelf
    [weakSelf showEmptyViewWithLoading];
    [HttpHandler getMemberAsset:@{@"para1":UniqUserID,@"para2":userType} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        NSLog(@"%@",obj);
        [weakSelf hideEmptyView];
        if (ReturnValue==1) {
            NSDictionary *dic = [HttpTool getArrayWithData:obj[@"sysmodel"][@"strresult"]][0];
            _assetDict = [NSDictionary dictionaryWithDictionary:[HttpTool takeOffNullWithDict:dic]];
            [weakSelf setUI];
        }else{
            if ([obj[@"err"] integerValue] == 500) {
                [weakSelf reLogin];
            }else{
                [weakSelf showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(getDataSource)];
            }
        }
    } failed:^(id obj) {
        [weakSelf hideEmptyView];
        [weakSelf showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(getDataSource)];
        [weakSelf outLogin];
    }];
}

#pragma mark private

-(ZWHMyHeaderView *)ZWHheaderView{
    if (!_ZWHheaderView) {
        _ZWHheaderView = [[ZWHMyHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(200))];
        [_ZWHheaderView.img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,userIcon]] placeholderImage:[UIImage imageNamed:@"default_head"]];
        _ZWHheaderView.name.text=userNickNmae;
        _ZWHheaderView.num.text=UniqUserID;
        [_ZWHheaderView.quit addTarget:self action:@selector(outLogin) forControlEvents:UIControlEventTouchUpInside];
        [_ZWHheaderView.imgBtn addTarget:self action:@selector(changeIcon) forControlEvents:UIControlEventTouchUpInside];
        [_ZWHheaderView.qrCode addTarget:self action:@selector(showMyQrcode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ZWHheaderView;
}

#pragma mark - 个人w二维码
-(void)showMyQrcode{
    ZWHMyQRViewController *vc = [[ZWHMyQRViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 更改头像
-(void)changeIcon{
    UIAlertController *aler = [UIAlertController alertControllerWithTitle:@"选择类型" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *pz = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self chooseImageWithType:UIImagePickerControllerSourceTypeCamera];
    }];
    UIAlertAction *xc = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self chooseImageWithType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [aler addAction:pz];
    [aler addAction:xc];
    [aler addAction:cancel];
    [self presentViewController:aler animated:YES completion:nil];
}

#pragma mark -调用相机，选择图片
-(void)chooseImageWithType:(UIImagePickerControllerSourceType)type{
    
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = type;
    [self presentViewController:imagePickerController animated:YES completion:^{}];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    MJWeakSelf;
    [self showEmptyViewWithLoading];
    [HttpHandler getRegisterLogo:@{@"para1":UniqUserID,@"para2":userType} dataList:@[] image:@[image] start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        [weakSelf hideEmptyView];
        if (ReturnValue==1) {
            [self showHint:@"更换成功"];
            NSString *icon = obj[@"sysmodel"][@"strresult"];
            [userDefault setObject:icon forKey:@"userIcon"];
            [userDefault synchronize];
            NSLog(@"%@",[NSString stringWithFormat:@"%@%@",SERVER_IMG,userIcon]);
            [weakSelf.ZWHheaderView.img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,userIcon]] placeholderImage:[UIImage imageNamed:@"default_head"]];
        }
    } failed:^(id obj) {
        [weakSelf hideEmptyView];
    }];
}





-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
        _tableview.delegate=self;
        _tableview.dataSource=self;
    }
    return _tableview;
}
#pragma mark- tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _unchangArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array=_unchangArray[section];
    return array.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellid=_unchangArray[indexPath.section][indexPath.row];
    GroupBaseCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        
        cell=[[NSBundle mainBundle]loadNibNamed:cellid owner:nil options:nil][0];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if ([cellid isEqualToString:@"MineOneCell"]) {
        cell.funBlock=^(id data){
            
            switch ([data integerValue]) {
                case 1:
                {
                    //我型我秀
                    FriendsShowTBVC*vc=[[FriendsShowTBVC alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                    break;
                case 2:
                {
                    //游记
                    MyNotosVC*vc=[[ MyNotosVC alloc]init];
                    vc.title=@"我的游记 ";
                    [vc setHidesBottomBarWhenPushed:YES];
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                    break;
                    
                default:
                {
                    //ShopCarViewController
                    ShopCarViewController*vc=[[ShopCarViewController alloc]init];
                    
                    [vc setHidesBottomBarWhenPushed:YES];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
            }
        };
    }
    if ([cellid isEqualToString:@"MineTwoCell"]) {
        [cell updateCellWithData:@[self.titeArray[indexPath.section][indexPath.row],self.imageArray[indexPath.section][indexPath.row]]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    if ([cellid isEqualToString:@"CatageThreeCell"]) {
        [cell updateCellWithData:self.titeArray[indexPath.section][indexPath.row]];
        CatageThreeCell *gcell=(CatageThreeCell*)cell;
        gcell.more.hidden=YES;
    }
    if ([cellid isEqualToString:@"MineThreeCell"]) {
        
        [ cell updateCellWithData:self.titeArray[indexPath.section][indexPath.row]];
        if (indexPath.row==0)
        {
            cell.funBlock=^(id data){
                
                switch ([data integerValue]) {
                    case 1:
                    {
                        //全部订单
                        /*AllUnCompleteBillVC*vc=[[AllUnCompleteBillVC alloc]init];
                         [self.navigationController pushViewController:vc animated:YES];*/
                        ZWHOrderViewController *vc = [[ZWHOrderViewController alloc]init];
                        vc.index = 0;
                        vc.poType = @"all";
                        [self.navigationController pushViewController:vc animated:YES];
                        
                    }
                        break;
                    case 2:
                    {
                        ZWHOrderViewController *vc = [[ZWHOrderViewController alloc]init];
                        vc.index = 1;
                        vc.poType = @"all";
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                        break;
                    case 3:
                    {
                        ZWHOrderViewController *vc = [[ZWHOrderViewController alloc]init];
                        vc.index = 4;
                        vc.poType = @"all";
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                        break;
                    case 4:
                    {
                        ZWHOrderServiceViewController *vc = [[ZWHOrderServiceViewController alloc]init];
                        [self.navigationController pushViewController:vc animated:YES];
                        
                    }
                        break;
                }
            };
            
        }else
        {
            cell.funBlock = ^(id data) {
                switch ([data integerValue]) {
                    case 1:
                    {
                        //全部订单
                        /*AllUnCompleteBillVC*vc=[[AllUnCompleteBillVC alloc]init];
                         [self.navigationController pushViewController:vc animated:YES];*/
                        ZWHOrderViewController *vc = [[ZWHOrderViewController alloc]init];
                        vc.index = 0;
                        vc.poType = @"travel";
                        [self.navigationController pushViewController:vc animated:YES];
                        
                    }
                        break;
                    case 2:
                    {
                        ZWHOrderViewController *vc = [[ZWHOrderViewController alloc]init];
                        vc.index = 0;
                        vc.poType = @"hotel";
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                        break;
                    case 3:
                    {
                        ZWHOrderViewController *vc = [[ZWHOrderViewController alloc]init];
                        vc.index = 0;
                        vc.poType = @"store";
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                        break;
                }
            };
        }
    }
    
    
    
    
    if ([cellid isEqualToString:@"MineFourCell"]) {
        [cell updateCellWithData:@[self.titeArray[indexPath.section][indexPath.row],self.imageArray[indexPath.section][indexPath.row]]];
        MineFourCell *fourcell = (MineFourCell *)cell;
        if (indexPath.section==self.unchangArray.count-2) {
            fourcell.isDouble = NO;
            cell.funBlock=^(id data){
                switch ([data integerValue]) {
                    case 1:
                    {
                        //地址管理
                        AdressListVC*vc=[[AdressListVC alloc]init];
                        [self.navigationController pushViewController:vc animated:YES];
                        
                    }
                        break;
                    case 2:
                    {
                        //我的收藏
                        ZWHCollectionViewController*vc=[[ZWHCollectionViewController alloc]init];
                        [self.navigationController pushViewController:vc animated:YES];
                        
                    }
                        break;
                    case 3:
                    {
                        //历史记录
                        ZWHHistoryViewController*vc=[[ZWHHistoryViewController alloc]init];
                        [self.navigationController pushViewController:vc animated:YES];
                        
                    }
                        break;
                }
            };
        }else if (indexPath.section==self.unchangArray.count-4){
            fourcell.isDouble = YES;
            if (_assetDict) {
                NSLog(@"%@",_assetDict);
                fourcell.cash.text = [NSString stringWithFormat:@"%@",_assetDict[@"cash"]];
                fourcell.eCoupon.text = [NSString stringWithFormat:@"%@张",_assetDict[@"eCoupon"]];
                fourcell.integral.text = [NSString stringWithFormat:@"%@",_assetDict[@"integral"]];
                fourcell.brokerage.text = [NSString stringWithFormat:@"%@",_assetDict[@"brokerage"]];
            }
            cell.funBlock=^(id data){
                switch ([data integerValue]) {
                    case 1:
                    {
                        //代金券
                        ZWHCashcouponViewController *vc=[[ZWHCashcouponViewController alloc]init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                        break;
                    case 2:
                    {
                        //现金
                        ZWHCashViewController *vc=[[ZWHCashViewController alloc]init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                        break;
                    case 4:
                    {
                        //积分
                        ZWHIntegralViewController *vc=[[ZWHIntegralViewController alloc]init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                        break;
                    case 6:
                    {
                        //佣金
                        ZWHBrokerageViewController *vc=[[ZWHBrokerageViewController alloc]init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                        break;
                }
            };
        }else if (indexPath.section==self.unchangArray.count-3){
            fourcell.isDouble = NO;
            cell.funBlock=^(id data){
                switch ([data integerValue]) {
                    case 1:
                    {
                        //我的上级
                        ZWHColleagueViewController *vc=[[ZWHColleagueViewController alloc]init];
                        vc.title = @"我的上级";
                        [self.navigationController pushViewController:vc animated:YES];
                        
                    }
                        break;
                    case 2:
                    {
                        //我的下级
                        ZWHColleagueViewController *vc=[[ZWHColleagueViewController alloc]init];
                        vc.title = @"我的下级";
                        [self.navigationController pushViewController:vc animated:YES];
                        
                    }
                        break;
                }
            };
        }else{
            fourcell.isDouble = NO;
            cell.funBlock=^(id data){
                switch ([data integerValue]) {
                    case 1:
                    {
                        //我的保险
                        ZWHMyinsuranceViewController *vc=[[ZWHMyinsuranceViewController alloc]init];
                        [self.navigationController pushViewController:vc animated:YES];
                        
                    }
                        break;
                    case 2:
                    {
                        //发票管理
                        ZWHInvoiceListViewController *vc=[[ZWHInvoiceListViewController alloc]init];
                        [self.navigationController pushViewController:vc animated:YES];
                        
                    }
                        break;
                }
            };
        }
        
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [self.rowHeightArray[indexPath.section][indexPath.row] integerValue];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section!=0) {
        return 15;
    }
    return 0;
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
-(void)outLogin
{
    EMError *error = [[EMClient sharedClient] logout:YES];
    if (!error) {
        NSLog(@"退出成功");
        [[FMDBGroupTable shareInstance] deleteTable];
        [[FMDBUserTable shareInstance] deleteTable];
        [userDefault removeObjectForKey:@"token"];
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:nil userInfo:nil];
    }
}


-(void)reLogin
{
    EMError *error = [[EMClient sharedClient] logout:YES];
    if (!error) {
        NSLog(@"退出成功");
        [[FMDBGroupTable shareInstance] deleteTable];
        [[FMDBUserTable shareInstance] deleteTable];
        [QMUITips showInfo:@"登录已过期，请重新登录"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [userDefault removeObjectForKey:@"token"];
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:nil userInfo:nil];
        });
        
    }
}


@end
