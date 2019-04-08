//
//  CatageManagerVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/8.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "CatageManagerVC.h"
#import "CatageOneCell.h"
#import "CatageTwoCell.h"
#import "CatageThreeCell.h"
#import "CatageFourCell.h"
#import "CatageManagerVM.h"
#import "CatageFiveCell.h"
#import "CatageSixCell.h"
#import "CatageSevenCell.h"
#import "UIViewController+HUD.h"
#import "CatageModel.h"
#import "CatageDetailWebVC.h"
#import "ProductViewController.h"
#import "UIViewController+NavBarHidden.h"
#import "ProductVM.h"
#import "HotelDestinationVC.h"
#import "TicketViewController.h"
#import "InsuranceVC.h"
#import "ZWHProductStoreViewController.h"
#define NAVBAR_CHANGE_POINT 50
@interface CatageManagerVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *cellidArray;
@property(nonatomic,strong)NSArray *unchangArray;
@property(nonatomic,strong)NSMutableArray *notesArray;
@property(nonatomic,strong)NSMutableArray *newsArray;
@property(nonatomic,strong)NSMutableArray *guisArray;
@property(nonatomic,strong)NSMutableArray *firstProductOne;
@property(nonatomic,strong)NSMutableArray *firstProductTwo;
@end

@implementation CatageManagerVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setInViewWillAppear];
    
  
  
  
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setInViewWillDisappear];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"NSHomeDirectory:%@",NSHomeDirectory());

    self.unchangArray=@[@"CatageOneCell",@"CatageTwoCell",@"CatageThreeCell",@"CatageFourCell",@"CatageFourCell",@"CatageThreeCell",@"CatageSixCell",@"CatageFiveCell",@"CatageThreeCell",@"CatageSevenCell",@"CatageSevenCell",@"CatageSevenCell"];
    [self.view addSubview:self.tableview];
     self.tableview.contentInset=UIEdgeInsetsMake(ScreenWidth*0.5,0,0,0);
    [self.tableview addSubview:[self headview]];
//    [self getNews];
    [self firstProduct];
    
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - scroDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    //rate将决定颜色变化程度,值越大,颜色变化越明显,rate的取值范围是0.01 - 0.999999
    if (scrollView == self.tableview) {
        [self scrollControlByOffsetY:ScreenWidth*0.5];
    }

}
#pragma mark - set/get
-(UITableView *)tableview
{
    if (!_tableview) {
        CGFloat h;
        if (@available(iOS 11.0, *)) {
            UIEdgeInsets insets=[UIApplication sharedApplication].delegate.window.safeAreaInsets;
            h=insets.top-44;
        } else {
            // Fallback on earlier versions
            h=-64;
        }
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0,h, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _tableview.delegate=self;
        _tableview.dataSource=self;
    }
    return _tableview;
}
-(NSMutableArray *)notesArray
{
    if (!_notesArray) {
        _notesArray=[NSMutableArray array];
    }
    return _notesArray;
}
-(NSMutableArray *)newsArray
{
    if (!_newsArray) {
        _newsArray=[NSMutableArray array];
    }
    return _newsArray;
}
-(NSMutableArray *)guisArray
{
    if (!_guisArray) {
        _guisArray=[NSMutableArray array];
    }
    return _guisArray;
}
#pragma mark - net
//获取一级大类
-(void)firstProduct
{
    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{}];
    DefineWeakSelf;
    [ProductVM FirstClassifyListSysmodel:sysmodel Success:^(id responseData) {
        NSDictionary *dic=(NSDictionary*)responseData;
        if ([dic[@"sysmodel"][@"blresult"] intValue]) {
           
//            NSLog(@"FirstClassifyList:%@",dic);
            weakSelf.firstProductOne=[ClassifyModel getDatawithdic:dic];
            NSString *jsonStr=dic[@"sysmodel"][@"strresult"];
            if (![jsonStr isEqual:[NSNull null]]) {
                NSData *data=[jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                NSObject *obj=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                NSArray *array=(NSArray*)obj;
                weakSelf.firstProductTwo=[ClassifyModel getDatawithArray:array];
               
            }
            [weakSelf getNews];
            
        }else
        {
            [weakSelf showHint:dic[@"sysmodel"][@"msg"]];
            
        }
        
    } Fail:^(id erro) {
        
    }];
}


//新闻
-(void)getNews
{
    DefineWeakSelf;
    [CatageManagerVM NewNewsStartindex:@"1" Endindex:@"3" Success:^(id responseData) {
        
        NSDictionary *dic=(NSDictionary*)responseData;
        if ([dic[@"sysmodel"][@"blresult"] intValue]) {
            
            weakSelf.newsArray=[CatageModel getDatawithdic:dic];
//            NSLog(@"weakSelf.newsArray.count:%ld",weakSelf.newsArray.count);
            [weakSelf Guides];
        }else
        {
            [weakSelf showHint:dic[@"sysmodel"][@"msg"]];
            
        }
    } Fail:^(id erro) {
        
    }];
    
}
//攻略
-(void)Guides
{
    DefineWeakSelf;
    [CatageManagerVM NewGuidesStartindex:@"1" Endindex:@"2" Success:^(id responseData) {
        NSDictionary *dic=(NSDictionary*)responseData;
        if ([dic[@"sysmodel"][@"blresult"] intValue]) {
            
             weakSelf.guisArray=[CatageModel getDatawithdic:dic];
//            NSLog(@"weakSelf.guisArray.count:%ld",weakSelf.guisArray.count);
            [weakSelf getNotes];
            
        }else
        {
            [weakSelf showHint:dic[@"sysmodel"][@"msg"]];
            
        }
    } Fail:^(id erro) {
        
    }];
}
//游记
-(void)getNotes
{
    DefineWeakSelf;
    [CatageManagerVM NewNotesStartindex:@"1" Endindex:@"2" Success:^(id responseData) {
        NSDictionary *dic=(NSDictionary*)responseData;
        if ([dic[@"sysmodel"][@"blresult"] intValue]) {
            
             weakSelf.notesArray=[CatageModel getDatawithdic:dic];
//               NSLog(@"weakSelf.notesArray.count:%ld",weakSelf.notesArray.count);
            
        }else
        {
            [weakSelf showHint:dic[@"sysmodel"][@"msg"]];
            
        }
        [weakSelf.tableview reloadData];
    } Fail:^(id erro) {
        
    }];
}
#pragma mark - private
-(UIView*)headview
{
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, -ScreenWidth*0.5, ScreenWidth, ScreenWidth*0.5)];
    imageview.image=[UIImage imageNamed:@"ceshi_3_1"];
    return imageview;
}
//旅游
-(void)TravelSwich:(NSInteger)index
{
    ClassifyModel*model = self.firstProductTwo[index-1];
    switch (index) {
        case 1:
        {
            NSLog(@"拼单");
        }
            break;
        case 2:
        {
            NSLog(@"旅游保险");
            InsuranceVC *vc=[[InsuranceVC alloc]init];
            [vc setHidesBottomBarWhenPushed:YES];
            vc.code=model.code;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 3:
        {
            NSLog(@"旅游城市特产");
        }
            break;
        case 4:
        {
            NSLog(@"旅游定制");
        }
            break;
        case 5:
        {
            NSLog(@"旅游金融");
        }
            break;
        case 6:
        {
            NSLog(@"旅行用品");
            ProductViewController *vc=[[ProductViewController alloc]init];
            [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
     
    }
}

//机票酒店美食
-(void)OneCellSwich:(NSInteger)index{
    ClassifyModel*model = self.firstProductOne[index-1];
    switch (index) {
        case 1:
        {
            
        }
            break;
        case 2:
        {
            //酒店
            HotelDestinationVC *vc=[[HotelDestinationVC alloc]init];
             [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
          
        }
            break;
        case 3:
        {
           
        }
            break;
        case 4:
        {
           //门票
            TicketViewController *vc=[[TicketViewController alloc]init];
            [vc setHidesBottomBarWhenPushed:YES];
            vc.classifyNo=model.code;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 5:
        {
           
        }
            break;
        case 6:
        {
           
        }
            break;
        case 7:
        {
            
        }
            break;
        case 8:
        {
            
        }
            break;
            
            
    }
}


#pragma mark - tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
      return _unchangArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellid=_unchangArray[indexPath.row];
    GroupBaseCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        if ([cellid isEqualToString:@"CatageOneCell"]) {
            cell=[[CatageOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
         
            
        }else
        {
            cell=[[NSBundle mainBundle]loadNibNamed:cellid owner:nil options:nil][0];
        }
       
    }
    if ([cellid isEqualToString:@"CatageOneCell"]) {
        CatageOneCell *tcell=(CatageOneCell*)cell;
        tcell.array=self.firstProductOne;
        DefineWeakSelf;
        tcell.funBlock = ^(id data) {
            [weakSelf OneCellSwich:[data integerValue]];
        };
    }
    if ([cellid isEqualToString:@"CatageTwoCell"]) {
        CatageTwoCell *tcell=(CatageTwoCell*)cell;
        tcell.array=self.firstProductTwo;
        DefineWeakSelf;
        tcell.funBlock = ^(id data) {
            [weakSelf TravelSwich:[data integerValue]];
        };
        
    }
    else if ([cellid isEqualToString:@"CatageThreeCell"]) {
        
        switch (indexPath.row) {
            case 2:
                [cell updateCellWithData:@"旅游攻略"];
                break;
            case 5:
                [cell updateCellWithData:@"游记"];
                break;
            case 8:
                [cell updateCellWithData:@"新闻列表"];
                break;
         
        }
     
    }else if ([cellid isEqualToString:@"CatageFourCell"])
    {
        if (self.guisArray.count>=2) {
            
            switch (indexPath.row) {
                case 3:
                    [cell updateCellWithData:self.guisArray[0]];
                    break;
                case 4:
                    [cell updateCellWithData:self.guisArray[1]];
                    break;
                    
            }
        }
        
        
    }else if ([cellid isEqualToString:@"CatageFiveCell"])
    {
        if (self.notesArray.count>=2) {
            [cell updateCellWithData:self.notesArray[0]];
        }
          
        
     
    }else if ([cellid isEqualToString:@"CatageSixCell"])
    {
        if (self.notesArray.count>=2) {
             [cell updateCellWithData:self.notesArray[1]];
        }
        
        
    }else if ([cellid isEqualToString:@"CatageSevenCell"])
    {
        if (self.newsArray.count>=3) {
            switch (indexPath.row) {
                case 9:
                    [cell updateCellWithData:self.newsArray[0]];
                    break;
                case 10:
                    [cell updateCellWithData:self.newsArray[1]];
                    break;
                case 11:
                    [cell updateCellWithData:self.newsArray[2]];
                    break;
                    
            }
        }
       
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   

    NSString *str=_unchangArray[indexPath.row];
    if ([str isEqualToString:@"CatageOneCell"]) {
        return 200;
    }else if ([str isEqualToString:@"CatageTwoCell"])
    {
        return 200;
    }else if ([str isEqualToString:@"CatageThreeCell"])
    {
        return 43;
        
    }else if ([str isEqualToString:@"CatageFourCell"])
    {
        return 200;
    }else if ([str isEqualToString:@"CatageFiveCell"])
    {
        return 160;
    }else if ([str isEqualToString:@"CatageSixCell"])
    {
        return 160;
    }
    else if ([str isEqualToString:@"CatageSevenCell"])
    {
        return 120;
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *cellid=_unchangArray[indexPath.row];
    if ([cellid isEqualToString:@"CatageFourCell"])
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (self.guisArray.count>=2) {
            if (indexPath.row==3) {
                CatageModel *model=self.guisArray[0];
                CatageDetailWebVC *vc=[[CatageDetailWebVC alloc]init];
                vc.code=model.code;
                [self.navigationController pushViewController:vc animated:YES];
                
            }else
            {
                CatageModel *model=self.guisArray[1];
                CatageDetailWebVC *vc=[[CatageDetailWebVC alloc]init];
                vc.code=model.code;
                [self.navigationController pushViewController:vc animated:YES];
            }
       
        }
        
        
    }else if ([cellid isEqualToString:@"CatageFiveCell"])
    {
        if (self.notesArray.count>=2) {
            CatageModel *model=self.notesArray[0];
            CatageDetailWebVC *vc=[[CatageDetailWebVC alloc]init];
            vc.code=model.code;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
        
    }else if ([cellid isEqualToString:@"CatageSixCell"])
    {
        if (self.notesArray.count>=2) {

            CatageModel *model=self.notesArray[1];
            CatageDetailWebVC *vc=[[CatageDetailWebVC alloc]init];
            vc.code=model.code;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
    }else if ([cellid isEqualToString:@"CatageSevenCell"])
    {
        if (self.newsArray.count>=3) {
            switch (indexPath.row) {
                case 9:
                {
                    CatageModel *model=self.newsArray[0];
                    CatageDetailWebVC *vc=[[CatageDetailWebVC alloc]init];
                    vc.code=model.code;
                    [self.navigationController pushViewController:vc animated:YES];
          
                }
                    break;
                case 10:
                {
                    CatageModel *model=self.newsArray[1];
                    CatageDetailWebVC *vc=[[CatageDetailWebVC alloc]init];
                    vc.code=model.code;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                    break;
                case 11:

                {
                    CatageModel *model=self.newsArray[2];
                    CatageDetailWebVC *vc=[[CatageDetailWebVC alloc]init];
                    vc.code=model.code;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
            }
        }
        
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
