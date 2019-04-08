//
//  ShopCarViewController.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/28.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ShopCarViewController.h"
#import "STShopCarTableViewCell.h"
#import "UIViewController+HUD.h"
#import "ProductVM.h"
#import "ShopCarBottomView.h"
#import "ConfirmBillVC.h"
@interface ShopCarViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _isEdit;
    NSString *_total;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)NSArray *selectedArray;

@property(nonatomic,strong)ShopCarBottomView *bottomView;
@end

@implementation ShopCarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"购物车";
    self.view.backgroundColor=[UIColor whiteColor];
    _selectedArray = [NSArray array];
    _isEdit=NO;
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-HEIGHT_PRO(60));
    }];
    [self.view addSubview:self.bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(HEIGHT_PRO(60));
    }];
    self.dataArray=[NSMutableArray array];
    [self setRefresh];
    [self rightButton];
    self.keyTableView = _tableView;
    NOTIFY_ADD(refreshData, NOTIFICATION_SHOPCAR);
}

-(void)refreshData{
    [self.tableView.mj_header beginRefreshing];
}

-(void)dealloc{
    NOTIFY_REMOVEALL
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-60) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView=[UIView new];
   
    }
    return _tableView;
}

-(void)setRefresh{
    MJWeakSelf
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.dataArray = [NSMutableArray array];
        weakSelf.selectedArray = [NSArray array];
        _isEdit = NO;
        [weakSelf getShopCarData];
    }];
    [_tableView.mj_header beginRefreshing];
    
    
}

#pragma mark - rightButton
-(void)rightButton
{
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,40,20)];
    [rightButton setTitle:@"管理" forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    UIView *rightCustomView = [[UIView alloc] initWithFrame: rightButton.frame];
    [rightCustomView addSubview: rightButton];
    UIBarButtonItem*leftItem = [[UIBarButtonItem alloc]initWithCustomView:rightCustomView];
    
    self.navigationItem.rightBarButtonItem=leftItem;
   
}
-(void)edit:(UIButton*)butt
{
   

    _isEdit=!_isEdit;
    if (_isEdit)
    {
         [butt setTitle:@"完成" forState:UIControlStateNormal];
    }else
    {
         [butt setTitle:@"管理" forState:UIControlStateNormal];
    }
    [self.tableView reloadData];
}
#pragma mark - ShopCarBottomView
-(ShopCarBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView=[[ShopCarBottomView alloc]initWithFrame:CGRectMake(0, ScreenHeight-64-60, ScreenWidth, 60)];
        _bottomView.nextButton.backgroundColor=MainColor;
        [_bottomView.nextButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView.allBtn addTarget:self action:@selector(chooseAll) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
}
#pragma mark - 下一步
-(void)next
{
  
    if (!_selectedArray.count) {
        [self showHint:@"请选中商品"];
        return;
    }
    ConfirmBillVC *bill=[[ConfirmBillVC alloc]init];
    bill.billData=_selectedArray;
    bill.totalPrice=_total;
    bill.blresult=true;
    bill.state = 2;
    [self.navigationController pushViewController:bill animated:YES];
    
}

#pragma mark - 修改购物车数量
-(void)CartModify:(ShopCarModel*)model Num:(NSInteger)num
{
    [self showHudInView:self.view hint:@""];
    NSString *datalist=[DataProcess getJsonStrWithObj:@[@{@"prono":model.prono,@"prospecno":model.prospecno,@"firstclassify":model.firstclassify,@"secondclassify":model.secondclassify,@"memberid":model.memberid,@"membertype":model.membertype,@"shopid":model.shopid,@"nums":[NSNumber numberWithInteger:num]}]];
    DefineWeakSelf;
    [ProductVM CartModifyDataList:datalist Success:^(id responseData) {
   
        [self hideHud];
        NSDictionary *dic=(NSDictionary*)responseData;
        if ([dic[@"sysmodel"][@"blresult"] intValue])
        {
            model.nums=[NSString stringWithFormat:@"%ld",num];
            [weakSelf.tableView reloadData];
            
        }else
        {
            [weakSelf showHint:dic[@"sysmodel"][@"strresult"]];
        }
    
    } Fail:^(id erro) {
        
    }];
    
}

#pragma mark - 删除购物车中的记录
-(void)CartDeleteWith:(UIButton *)btn
{
    ShopCarModel *model = _dataArray[btn.tag];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:model.prono forKey:@"prono"];
    [dict setValue:model.prospecno forKey:@"prospecno"];
    [dict setValue:model.firstclassify forKey:@"firstclassify"];
    [dict setValue:model.secondclassify forKey:@"secondclassify"];
    [dict setValue:UniqUserID forKey:@"memberid"];
    [dict setValue:userType forKey:@"membertype"];
    [dict setValue:model.shopid forKey:@"shopid"];
    
    [self showHudInView:self.view hint:@""];
    MJWeakSelf
    [HttpHandler getCartDelete:@{} DataList:@[dict] start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        [weakSelf hideHud];
        if (ReturnValue==1) {
            [weakSelf showHint:@"删除成功"];
            [weakSelf.tableView.mj_header beginRefreshing];
        }else{
            [weakSelf showHint:ErrorValue];
        }
    } failed:^(id obj) {
        
    }];
    
}

#pragma mark - 获取购物车记录
-(void)getShopCarData
{
    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":UniqUserID,@"para2":@"M"}];
    DefineWeakSelf;
    [ProductVM CartListSysmodel:sysmodel Success:^(id responseData) {
        NSDictionary *dic=(NSDictionary*)responseData;
        NSString *jsonStr=dic[@"sysmodel"][@"strresult"];
        if (![jsonStr isEqual:[NSNull null]]) {
            NSData *data=[jsonStr dataUsingEncoding:NSUTF8StringEncoding];
            NSObject *obj=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *array=(NSArray*)obj;
            weakSelf.dataArray=[ShopCarModel getDatawithdic:array];
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView reloadData];
            [weakSelf refreshAllbtnState];
            [weakSelf totalPrice];

        }
    } Fail:^(id erro) {
        
    }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString*cellid=@"STShopCarTableViewCell";
    STShopCarTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"STShopCarTableViewCell" owner:nil options:nil][0];
    }
    if (_isEdit) {
        [cell setNoHideen];
    }else
    {
        [cell setHideen];
    }
    ShopCarModel *model=self.dataArray[indexPath.row];
    
    /*if (_indexPathArray.count > 0) {
        for (NSIndexPath *index in _indexPathArray) {
            if (index.row==indexPath.row) {
                cell.selLable.backgroundColor=MainColor;
            }else{
                cell.selLable.backgroundColor=[UIColor whiteColor];
            }
        }
    }*/
    cell.model=model;
    cell.selectionStyle = 0;
    
    //加
    DefineWeakSelf;
    cell.pluseBlock = ^{
        NSInteger num=model.nums.integerValue +1;
        [weakSelf CartModify:model Num:num];
        
    };
    //减
    cell.minceBlock = ^{
        if (model.nums.integerValue==1) {
            return ;
        }
        NSInteger num=model.nums.integerValue-1>0?model.nums.integerValue-1:1;
      
        [weakSelf CartModify:model Num:num];
        
    };
    
    //删
    cell.deletButton.tag = indexPath.row;
    [cell.deletButton addTarget:self action:@selector(CartDeleteWith:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
     ShopCarModel *model=self.dataArray[indexPath.row];
     model.isSelected=!model.isSelected;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    //[self.tableView reloadData];
    [self totalPrice];
    [self refreshAllbtnState];
    
}

//全选
-(void)chooseAll{
    //判断是否全选中
    for (ShopCarModel *model in self.dataArray) {
        model.isSelected = ![self samColor:_bottomView.allBtn.backgroundColor withColor:MainColor];
    }
    
    [self totalPrice];
    [self refreshAllbtnState];
    [self.tableView reloadData];
}


//刷新全选按钮
-(void)refreshAllbtnState{
    if (self.dataArray.count==0) {
        _bottomView.allBtn.backgroundColor = [UIColor whiteColor];
        return;
    }
    
    if (_selectedArray.count == self.dataArray.count) {
        _bottomView.allBtn.backgroundColor = MainColor;
    }else{
        _bottomView.allBtn.backgroundColor = [UIColor whiteColor];
    }
}

-(void)totalPrice
{
    //获取选中的商品
    NSMutableArray *selected=[NSMutableArray array];
    
    
    /*for (NSInteger i=0; i<self.dataArray.count; i++) {
        ShopCarModel *model = self.dataArray[i];
    }*/
    
    for (ShopCarModel *model in self.dataArray) {
        if (model.isSelected) {
            [selected addObject:model];
        }
    }
    
    CGFloat totlal=0;
    for (ShopCarModel *model in selected) {
        totlal=totlal+model.saleprice1.floatValue *model.nums.intValue;
    }
    
    
    _selectedArray=selected;

    self.bottomView.lable1.text=[NSString stringWithFormat:@"￥%.2f",totlal];
    _total=self.bottomView.lable1.text;
    
    [self refreshAllbtnState];
}

//判断颜色是否相同
-(BOOL)samColor:(UIColor*)firstColor withColor:(UIColor*)secondColor
{
    if (CGColorEqualToColor(firstColor.CGColor, secondColor.CGColor))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


@end
