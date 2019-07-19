//
//  DoGroupBuyController.m
//  FengHuaKe
//
//  Created by chenheng on 2019/7/18.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "DoGroupBuyController.h"
#import "GuidApplyTxtInputView.h"
#import "GuiApplyClickChoiceView.h"
#import "GuidApplyTextView.h"
#import "GuidApplyFilterView.h"
#import "ListChooseView.h"
#import "ZWHClassifyModel.h"
#import "DatePickerView.h"
#import "AdressListVC.h"
#import "ZWHTiketStoreViewController.h"
#import "ZWHHotelViewController.h"
#import "CookingViewController.h"
#import "ZWHProductStoreViewController.h"
#import "ZWHProductStoreViewController.h"
@interface DoGroupBuyController ()<ListChooseViewDelegate,AdressListVCDelegate>
//标题
@property(nonatomic,strong)GuidApplyTxtInputView * ptitle;
//产品大类
@property(nonatomic,strong)GuiApplyClickChoiceView * bigClassfy;
//成单数
@property(nonatomic,strong)GuidApplyTxtInputView * orderNums;
//产品
@property(nonatomic,strong)GuiApplyClickChoiceView * product;
//拼单结束日期
@property(nonatomic,strong)GuiApplyClickChoiceView * group_end_date;
//拼单失败是否保留
@property(nonatomic,strong)GuidApplyFilterView * group_result;
//文字介绍
@property(nonatomic,strong)GuidApplyTextView * describ;

/*门票*/
//使用日期
@property(nonatomic,strong)GuiApplyClickChoiceView * use_date;

/*酒店*/
@property(nonatomic,strong)GuiApplyClickChoiceView * live_date;
@property(nonatomic,strong)GuiApplyClickChoiceView * left_date;

/*旅游城市特产*/
@property(nonatomic,strong)GuiApplyClickChoiceView * shipping_addres;

/*美食美味*/
@property(nonatomic,strong)GuidApplyFilterView * use_Time;
//@property(nonatomic,strong)GuidApplyTxtInputView * use_date;

/*美食美味*/
//@property(nonatomic,strong)GuidApplyTxtInputView * shipping_addres;
@property(nonatomic,strong)NSArray * titles;
@property(nonatomic,strong)UIScrollView * scro;
@end

@implementation DoGroupBuyController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.titles = @[self.ptitle,self.bigClassfy,self.orderNums,self.product,self.group_end_date,self.group_result,self.describ];
    [self setUI];
    UIButton * btn = [[UIButton alloc]init];
    btn.backgroundColor = MainColor;
    [btn setTitle:@"立即发起" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(groupBuy:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [self.view bringSubviewToFront:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.height.mas_equalTo(50*MULPITLE);
    }];
  
}
#pragma mark - action
-(void)chooseBigClassify:(UITapGestureRecognizer*)tap{
    CGRect relativeRect = [self.view convertRect:self.bigClassfy.frame toView:UIApplication.sharedApplication.keyWindow];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [DataProcess requestDataWithURL:FirstClassify_Group RequestStr:GETRequestStr(nil, nil, nil, nil, nil) Result:^(id obj, id erro) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"obj===>%@",obj);
        if (obj) {
            NSArray * array = [ZWHClassifyModel mj_objectArrayWithKeyValuesArray:ReturnDataList];
           ListChooseView  * listView = [ListChooseView showListChoose:CGRectSetY(relativeRect, relativeRect.origin.y+NAV_HEIGHT) DataSource:array Identifier:NSStringFromClass([ZWHClassifyModel class])];
           listView.delegate = self;
        }
        
    }];
}
-(void)chooseProduct:(UITapGestureRecognizer*)tap{
    if (!self.bigClassfy.tempObj) {
        [self showHint:@"请先选择大类"];
    }
    [GroupBuyMananger singleton].isGroupStyle = YES;
    ZWHClassifyModel * model = (ZWHClassifyModel*)self.bigClassfy.tempObj;
    if ([model.module isEqualToString:@"ticket"]) {
        ZWHTiketStoreViewController *vc = [[ZWHTiketStoreViewController alloc]init];
        vc.code=model.code;
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if ([model.module isEqualToString:@"hotel"]) {
        ZWHHotelViewController *vc = [[ZWHHotelViewController alloc]init];
        vc.code=model.code;
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if ([model.module isEqualToString:@"travelspec"]) {
        ZWHProductStoreViewController *vc = [[ZWHProductStoreViewController alloc]init];
        vc.code = model.code;
        vc.adcode = @"tc";
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if ([model.module isEqualToString:@"repast"]) {
        CookingViewController *vc = [[CookingViewController alloc]init];
        vc.code=model.code;
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if ([model.module isEqualToString:@"travelgoods"]) {
        ZWHProductStoreViewController *vc = [[ZWHProductStoreViewController alloc]init];
        vc.code = model.code;
        vc.adcode = @"tyyp";
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }

}
-(void)chooseDate:(UITapGestureRecognizer*)tap{
    DefineWeakSelf;
    [DatePickerView showDatePickerCallBack:^(NSDate * _Nonnull date) {
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        if ([weakSelf.live_date.clickLabel isEqual:tap.view]) {
            weakSelf.live_date.clickLabel.text= [formatter stringFromDate:date];
        }
        if ([weakSelf.left_date.clickLabel isEqual:tap.view]) {
            weakSelf.left_date.clickLabel.text = [formatter stringFromDate:date];
        }
        if ([weakSelf.group_end_date.clickLabel isEqual:tap.view]) {
            weakSelf.group_end_date.clickLabel.text = [formatter stringFromDate:date];
        }
        if ([weakSelf.use_date.clickLabel isEqual:tap.view]) {
            weakSelf.use_date.clickLabel.text= [formatter stringFromDate:date];
        }
        
    }];
}
-(void)addres:(UITapGestureRecognizer*)tap{
    AdressListVC * vc = [[AdressListVC alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)groupBuy:(UIButton*)btn{
    if ([model.module isEqualToString:@"ticket"]) {
        
        [[GroupBuyMananger singleton] po_GroupBuyIdentify:@"ticket"];
    }
    
    if ([model.module isEqualToString:@"hotel"]) {
        [[GroupBuyMananger singleton] po_GroupBuyIdentify:@"hotel"];
    }
    
    if ([model.module isEqualToString:@"travelspec"]) {
        [[GroupBuyMananger singleton] po_GroupBuyIdentify:@"travelspec"];
    }
    
    if ([model.module isEqualToString:@"repast"]) {
        [[GroupBuyMananger singleton] po_GroupBuyIdentify:@"repast"];
    }
    
    if ([model.module isEqualToString:@"travelgoods"]) {
        [[GroupBuyMananger singleton] po_GroupBuyIdentify:@"travelgoods"];
    }
}

#pragma mark - proxy
-(void)ListChooseViewCallBack:(NSString *)identifier Obj:(NSObject *)obj
{
    if ([identifier isEqualToString:NSStringFromClass(ZWHClassifyModel.class)]) {
        ZWHClassifyModel * model = (ZWHClassifyModel*)obj;
        self.bigClassfy.clickLabel.text = model.name;
        self.bigClassfy.tempObj = model;
        self.orderNums.textfield.text = [NSString stringWithFormat:@"%@",model.property];
        if ([model.module isEqualToString:@"ticket"]) {
            self.titles = @[self.ptitle,self.bigClassfy,self.orderNums,self.product,self.use_date,self.group_end_date,self.group_result,self.describ];
            [self setUI];
        }
        
        if ([model.module isEqualToString:@"hotel"]) {
            self.titles = @[self.ptitle,self.bigClassfy,self.orderNums,self.product,self.live_date,self.left_date,self.group_end_date,self.group_result,self.describ];
            [self setUI];
        }
        
        if ([model.module isEqualToString:@"travelspec"]) {
            self.titles = @[self.ptitle,self.bigClassfy,self.orderNums,self.product,self.shipping_addres,self.group_end_date,self.group_result,self.describ];
            [self setUI];
        }
        
        if ([model.module isEqualToString:@"repast"]) {
            self.titles = @[self.ptitle,self.bigClassfy,self.orderNums,self.product,self.use_date,self.group_end_date,self.use_Time,self.group_result,self.describ];
            [self setUI];
        }
        
        if ([model.module isEqualToString:@"travelgoods"]) {
            self.titles = @[self.ptitle,self.bigClassfy,self.orderNums,self.product,self.shipping_addres,self.group_end_date,self.group_result,self.describ];
            [self setUI];
        }
        
    }
}
-(void)didSelectreturnModel:(AdressListModel *)model
{
  self.shipping_addres.tempObj = model;
  self.shipping_addres.clickLabel.text = [NSString stringWithFormat:@"%@%@%@%@",model.Province,model.City,model.District,model.Address];
   
}

-(void)setUI{
    [self.use_date removeFromSuperview];
    [self.live_date removeFromSuperview];
    [self.left_date removeFromSuperview];
    [self.shipping_addres removeFromSuperview];
    [self.use_Time removeFromSuperview];
    UIView * last = nil;
    for (NSInteger i = 0; i<self.titles.count; i++) {
        UIView * view = self.titles[i];
        view.frame = CGRectMake(view.x,last?CGRectGetMaxY(last.frame):0 , view.width, view.height);
        if (![self.scro.subviews containsObject:view])
        {
             [self.scro addSubview:view];
        }
       
        last = view;
    }
    [self.scro setContentSize:CGSizeMake(self.scro.width, CGRectGetMaxY(last.frame))];
}


-(UIScrollView *)scro
{
    if (!_scro) {
        _scro = [[UIScrollView alloc]initWithFrame:CGRectMake(0,NAV_HEIGHT, self.view.width, SCREEN_HEIGHT-50*MULPITLE-NAV_HEIGHT)];
        [self.view addSubview:_scro];
    }
    return _scro;
}
-(GuidApplyTxtInputView *)ptitle
{
    if (!_ptitle) {
        _ptitle = [[GuidApplyTxtInputView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40))];
        //标题
        _ptitle.label.text = @"标题";
        _ptitle.textfield.placeholder = @"输入标题";
    }
    return _ptitle;
}

-(GuiApplyClickChoiceView *)bigClassfy
{
    if (!_bigClassfy) {
        _bigClassfy = [[GuiApplyClickChoiceView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40))];
        //产品大类
        _bigClassfy.label.text = @"产品大类";
        _bigClassfy.clickLabel.text = @"选择产品大类";
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseBigClassify:)];
        [_bigClassfy.clickLabel addGestureRecognizer:tap];
        
    }
    return _bigClassfy;
}

-(GuidApplyTxtInputView *)orderNums
{
    if (!_orderNums) {
        _orderNums = [[GuidApplyTxtInputView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40))];
        //成单数
        _orderNums.label.text = @"成单数";
        _orderNums.textfield.text= @"拼单多少可以成功";
        _orderNums.not_edit_avilble = YES;
    }
    return _orderNums;
}

-(GuiApplyClickChoiceView *)product
{
    if (!_product) {
        _product = [[GuiApplyClickChoiceView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40)) style:ClickSyle_3];
        //产品
        _product.label.text = @"产品";
        _product.clickLabel.text = @"选择产品";
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseProduct:)];
        [ _product.clickLabel addGestureRecognizer:tap];
        
    }
    return _product;
}

-(GuiApplyClickChoiceView *)group_end_date
{
    if (!_group_end_date) {
        _group_end_date = [[GuiApplyClickChoiceView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40)) style:ClickSyle_3];
        //拼单结束日期
        _group_end_date.label.text = @"拼单结束日期";
        _group_end_date.clickLabel.text = @"选择结束日期";
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseDate:)];
        [_group_end_date.clickLabel addGestureRecognizer:tap];
    }
    return _group_end_date;
}

-(GuidApplyTextView *)describ
{
    if (!_describ) {
        _describ = [[GuidApplyTextView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(150)) ];
        //文字介绍
        _describ.label.text = @"文字介绍";
//        _describ.textview.qmui_borderColor = [UIColor lightGrayColor];
//        _describ.textview.qmui_borderWidth = 1;
        _describ.textview.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        _describ.textview.layer.borderWidth = 1.0f;
        
    }
    return _describ;
}

-(GuidApplyFilterView *)group_result
{
    if (!_group_result) {
        _group_result = [[GuidApplyFilterView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40))];
        //拼单失败是否保留
        _group_result.label.text = @"拼单失败是否保留";
        _group_result.filerTitles = @[@"是",@"否"];
    }
    return _group_result;
}

-(GuiApplyClickChoiceView *)use_date
{
    if (!_use_date) {
        _use_date = [[GuiApplyClickChoiceView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40)) style:ClickSyle_3];
        //产品
        _use_date.label.text = @"使用日期";
        _use_date.clickLabel.text = @"选择使用日期";
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseDate:)];
        [_use_date.clickLabel addGestureRecognizer:tap];
    }
    return _use_date;
}

-(GuiApplyClickChoiceView *)live_date
{
    if (!_live_date) {
        _live_date = [[GuiApplyClickChoiceView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40)) style:ClickSyle_3];
        //产品
        _live_date.label.text = @"入住日期";
        _live_date.clickLabel.text = @"选择入住日期";
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseDate:)];
        [_live_date.clickLabel addGestureRecognizer:tap];
    }
    return _live_date;
}

-(GuiApplyClickChoiceView *)left_date
{
    if (!_left_date) {
        _left_date = [[GuiApplyClickChoiceView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40)) style:ClickSyle_3];
        //产品
        _left_date.label.text = @"离店日期";
        _left_date.clickLabel.text = @"选择离店日期";
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseDate:)];
        [_left_date.clickLabel addGestureRecognizer:tap];
    }
    return _left_date;
}

-(GuiApplyClickChoiceView *)shipping_addres
{
    if (!_shipping_addres) {
        _shipping_addres = [[GuiApplyClickChoiceView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40)) style:ClickSyle_3];
        //产品
        _shipping_addres.label.text = @"收货地址";
        _shipping_addres.clickLabel.text = @"选择收货地址";
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addres:)];
        [_shipping_addres.clickLabel addGestureRecognizer:tap];
    }
    return _shipping_addres;
}

-(GuidApplyFilterView *)use_Time
{
    if (!_use_Time) {
        _use_Time = [[GuidApplyFilterView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40))];
        //产品
        _use_Time.label.text = @"使用时间";
        _use_Time.filerTitles = @[@"早",@"中",@"晚"];
    }
    return _use_Time;
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
