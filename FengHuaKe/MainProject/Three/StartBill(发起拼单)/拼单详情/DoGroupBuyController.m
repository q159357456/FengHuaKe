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
@property(nonatomic,strong)GroupBuyMananger * groupBuyMananger;
@end

@implementation DoGroupBuyController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _groupBuyMananger = [GroupBuyMananger singleton];
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
    _groupBuyMananger.isGroupStyle = YES;
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
            weakSelf.live_date.tempObj = [formatter stringFromDate:date];
        }
        if ([weakSelf.left_date.clickLabel isEqual:tap.view]) {
            weakSelf.left_date.clickLabel.text = [formatter stringFromDate:date];
            weakSelf.left_date.tempObj = [formatter stringFromDate:date];
        }
        if ([weakSelf.group_end_date.clickLabel isEqual:tap.view]) {
            weakSelf.group_end_date.clickLabel.text = [formatter stringFromDate:date];
            weakSelf.group_end_date.tempObj = [formatter stringFromDate:date];
        }
        if ([weakSelf.use_date.clickLabel isEqual:tap.view]) {
            weakSelf.use_date.clickLabel.text= [formatter stringFromDate:date];
            weakSelf.use_date.tempObj = [formatter stringFromDate:date];
        }
        
    }];
}
-(void)addres:(UITapGestureRecognizer*)tap{
    AdressListVC * vc = [[AdressListVC alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)groupBuy:(UIButton*)btn{
    if (!self.bigClassfy.tempObj) {
        [self showHint:@"请选择大类"];
        return;
    }
    if (!self.ptitle.outPutTxt.length) {
        [self showHint:@"请填写标题"];
        return;
    }
    if (!self.group_end_date.tempObj) {
        [self showHint:@"请填写截止日期"];
        return;
    }
    /*----------*/
    ZWHClassifyModel * model = (ZWHClassifyModel*)self.bigClassfy.tempObj;
    if ([model.module isEqualToString:@"ticket"]) {
        if (!_groupBuyMananger.ticket.proName.length) {
            [self showHint:@"选择产品"];
            return;
        }
        if (!self.use_date.tempObj) {
            [self showHint:@"选择时间"];
            return;
        }
        _groupBuyMananger.ticket.commonArguments.title = self.ptitle.outPutTxt;
        _groupBuyMananger.ticket.commonArguments.nums = self.orderNums.outPutTxt;
        _groupBuyMananger.ticket.commonArguments.firstclassify = model.code;
        _groupBuyMananger.ticket.commonArguments.deadline = (NSString*)self.group_end_date.tempObj;
        _groupBuyMananger.ticket.commonArguments.remark = self.describ.textview.text;
        _groupBuyMananger.ticket.groupBuyParams.para5 = @"tickets";
        _groupBuyMananger.ticket.groupBuyParams.para6 = (NSString*)self.use_date.tempObj;
        _groupBuyMananger.ticket.groupBuyParams.blresult = self.group_result.selctIndex==0?@"true":@"false";
        [_groupBuyMananger po_GroupBuyIdentify:@"ticket"];
    }
    
    /*----------*/
    if ([model.module isEqualToString:@"hotel"]) {
        if (!self.live_date.tempObj || !self.left_date.tempObj) {
            [self showHint:@"选择时间"];
            return;
        }
        if (!_groupBuyMananger.hotel.proName.length) {
            [self showHint:@"选择产品"];
            return;
        }
        _groupBuyMananger.hotel.commonArguments.title = self.ptitle.outPutTxt;
        _groupBuyMananger.hotel.commonArguments.nums = self.orderNums.outPutTxt;
        _groupBuyMananger.hotel.commonArguments.firstclassify = model.code;
        _groupBuyMananger.hotel.commonArguments.deadline = (NSString*)self.group_end_date.tempObj;
        _groupBuyMananger.hotel.commonArguments.remark = self.describ.textview.text;
        _groupBuyMananger.hotel.groupBuyParams.para5 = @"hotel";
        _groupBuyMananger.hotel.groupBuyParams.blresult = self.group_result.selctIndex==0?@"true":@"false";
        _groupBuyMananger.hotel.groupBuyParams.para6 = (NSString*)self.live_date.tempObj;
        _groupBuyMananger.hotel.groupBuyParams.para7 = (NSString*)self.left_date.tempObj;
        _groupBuyMananger.hotel.groupBuyParams.intresult = @"1";
        [_groupBuyMananger po_GroupBuyIdentify:@"hotel"];
    }
    
    /*----------*/
    if ([model.module isEqualToString:@"travelspec"]) {
        if (!self.shipping_addres.tempObj) {
            [self showHint:@"选择收货地址"];
        }
        if (!_groupBuyMananger.travelgoods.proName.length) {
            [self showHint:@"选择产品"];
            return;
        }
        _groupBuyMananger.travelgoods.commonArguments.title = self.ptitle.outPutTxt;
        _groupBuyMananger.travelgoods.commonArguments.nums = self.orderNums.outPutTxt;
        _groupBuyMananger.travelgoods.commonArguments.firstclassify = model.code;
        _groupBuyMananger.travelgoods.commonArguments.deadline = (NSString*)self.group_end_date.tempObj;
        _groupBuyMananger.travelgoods.commonArguments.remark = self.describ.textview.text;
        _groupBuyMananger.travelgoods.groupBuyParams.para5 = @"store";
        _groupBuyMananger.travelgoods.groupBuyParams.blresult = self.group_result.selctIndex==0?@"true":@"false";
        AdressListModel * model = (AdressListModel*)self.shipping_addres.tempObj;
        _groupBuyMananger.travelgoods.groupBuyParams.para3 = model.Code;;
        [_groupBuyMananger po_GroupBuyIdentify:@"travelgoods"];
    }
    
    /*----------*/
    if ([model.module isEqualToString:@"repast"]) {
        if (!self.use_date.tempObj || !self.group_end_date.tempObj) {
            [self showHint:@"选择时间"];
            return;
        }
        if (!_groupBuyMananger.repast.proName.length) {
            [self showHint:@"选择产品"];
            return;
        }
        _groupBuyMananger.repast.commonArguments.title = self.ptitle.outPutTxt;
        _groupBuyMananger.repast.commonArguments.nums = self.orderNums.outPutTxt;
        _groupBuyMananger.repast.commonArguments.firstclassify = model.code;
        _groupBuyMananger.repast.commonArguments.deadline = (NSString*)self.group_end_date.tempObj;
        _groupBuyMananger.repast.commonArguments.remark = self.describ.textview.text;
        _groupBuyMananger.repast.groupBuyParams.para4 = self.use_Time.filerTitles[self.use_Time.selctIndex];
        _groupBuyMananger.repast.groupBuyParams.para5 = @"repast";
        _groupBuyMananger.repast.groupBuyParams.para6 = (NSString*)self.use_date.tempObj;
        _groupBuyMananger.repast.groupBuyParams.intresult = @"1";
        _groupBuyMananger.repast.groupBuyParams.blresult = self.group_result.selctIndex==0?@"true":@"false";
        [_groupBuyMananger po_GroupBuyIdentify:@"repast"];
    }
    
    /*----------*/
    if ([model.module isEqualToString:@"travelgoods"]) {
        if (!self.shipping_addres.tempObj) {
            [self showHint:@"选择收货地址"];
        }
        if (!_groupBuyMananger.travelgoods.proName.length) {
            [self showHint:@"选择产品"];
            return;
        }
        _groupBuyMananger.travelgoods.commonArguments.title = self.ptitle.outPutTxt;
        _groupBuyMananger.travelgoods.commonArguments.nums = self.orderNums.outPutTxt;
        _groupBuyMananger.travelgoods.commonArguments.firstclassify = model.code;
        _groupBuyMananger.travelgoods.commonArguments.deadline = (NSString*)self.group_end_date.tempObj;
        _groupBuyMananger.travelgoods.commonArguments.remark = self.describ.textview.text;
        _groupBuyMananger.travelgoods.groupBuyParams.para5 = @"store";
        _groupBuyMananger.travelgoods.groupBuyParams.blresult = self.group_result.selctIndex==0?@"true":@"false";
        AdressListModel * model = (AdressListModel*)self.shipping_addres.tempObj;
        _groupBuyMananger.travelgoods.groupBuyParams.para3 = model.Code;;
        [_groupBuyMananger po_GroupBuyIdentify:@"travelgoods"];
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
            self.product.clickLabel.text = _groupBuyMananger.ticket.proName?:@"请选择产品";
           
        }
        
        if ([model.module isEqualToString:@"hotel"]) {
            self.titles = @[self.ptitle,self.bigClassfy,self.orderNums,self.product,self.live_date,self.left_date,self.group_end_date,self.group_result,self.describ];
            [self setUI];
            self.product.clickLabel.text = _groupBuyMananger.hotel.proName?:@"请选择产品";
            
        }
        
        if ([model.module isEqualToString:@"travelspec"]) {
            self.titles = @[self.ptitle,self.bigClassfy,self.orderNums,self.product,self.shipping_addres,self.group_end_date,self.group_result,self.describ];
            [self setUI];
            self.product.clickLabel.text = _groupBuyMananger.travelspec.proName?:@"请选择产品";
        }
        
        if ([model.module isEqualToString:@"repast"]) {
            self.titles = @[self.ptitle,self.bigClassfy,self.orderNums,self.product,self.use_date,self.group_end_date,self.use_Time,self.group_result,self.describ];
            [self setUI];
            self.product.clickLabel.text = _groupBuyMananger.repast.proName?:@"请选择产品";
        }
        
        if ([model.module isEqualToString:@"travelgoods"]) {
            self.titles = @[self.ptitle,self.bigClassfy,self.orderNums,self.product,self.shipping_addres,self.group_end_date,self.group_result,self.describ];
            [self setUI];
            self.product.clickLabel.text = _groupBuyMananger.travelgoods.proName?:@"请选择产品";
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

-(void)setProductInfo:(NSString *)proName
{
    self.product.clickLabel.text = proName;
    ZWHClassifyModel * model = (ZWHClassifyModel*)self.bigClassfy.tempObj;
    if ([model.module isEqualToString:@"ticket"]) {
        _groupBuyMananger.ticket.proName = proName;
    }
    
    if ([model.module isEqualToString:@"hotel"]) {
        _groupBuyMananger.hotel.proName = proName;
    }
    
    if ([model.module isEqualToString:@"travelspec"]) {
        _groupBuyMananger.travelspec.proName = proName;
    }
    
    if ([model.module isEqualToString:@"repast"]) {
      
       _groupBuyMananger.repast.proName = proName;
    }
    
    if ([model.module isEqualToString:@"travelgoods"]) {
        _groupBuyMananger.travelgoods.proName = proName;
    }
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
