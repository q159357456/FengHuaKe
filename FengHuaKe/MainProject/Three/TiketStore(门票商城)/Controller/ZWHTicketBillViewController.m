//
//  ZWHTicketBillViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/21.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHTicketBillViewController.h"
#import "TicketNoticeVC.h"
#import "ZWHTicketDateCollectionViewCell.h"
#import "ZWHTimePriceModel.h"
#import "BPPCalendar.h"
#import "ZWHOrderModel.h"
#import "ZWHOrderPayViewController.h"


@interface ZWHTicketBillViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UILabel *sumPrice;
@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)QMUILabel *payNum;

@property(nonatomic,strong)QMUITextField *nameF;
@property(nonatomic,strong)QMUITextField *phoneF;

//选中日期
@property(nonatomic,assign)NSInteger selectIndex;

@property(nonatomic,strong)BPPCalendar *clender;



@end

@implementation ZWHTicketBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    _selectIndex = 0;
    [self creatData];
    [self setUI];
}

-(void)setUI{
    [self addBottom];
    
    QMUILabel *title = [[QMUILabel alloc]qmui_initWithFont:HTFont(32) textColor:[UIColor blackColor]];
    title.text = _model.spec;
    CGFloat navhig = ISIphoneX==0?64.0f:88.0f;
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(WIDTH_PRO(8));
        make.top.equalTo(self.view).offset(HEIGHT_PRO(6+navhig));
    }];
    
    UIView *topbackView = [[UIView alloc]init];
    [self.view addSubview:topbackView];
    topbackView.backgroundColor = ZWHCOLOR(@"#F8F8F8");
    [topbackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title.mas_bottom).offset(WIDTH_PRO(8));
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(HEIGHT_PRO(20));
    }];
    
    QMUILabel *tip = [[QMUILabel alloc]qmui_initWithFont:HTFont(20) textColor:[UIColor blackColor]];
    tip.text = @"温馨提示:06月11日当日使用有效";
    [topbackView addSubview:tip];
    [tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topbackView);
        make.left.equalTo(topbackView).offset(WIDTH_PRO(8));
    }];
    
    QMUIButton *payExplan = [[QMUIButton alloc]init];
    payExplan.tintColorAdjustsTitleAndImage = MAINCOLOR;
    [payExplan setTitle:@"购买须知>" forState:0];
    payExplan.titleLabel.font = HTFont(20);
    [topbackView addSubview:payExplan];
    [payExplan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topbackView);
        make.right.equalTo(topbackView).offset(-WIDTH_PRO(8));
    }];
    [payExplan addTarget:self action:@selector(showExplan) forControlEvents:UIControlEventTouchUpInside];
    
    
    QMUILabel *useDate = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:[UIColor blackColor]];
    useDate.text = @"使用日期";
    [self.view addSubview:useDate];
    [useDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topbackView.mas_bottom).offset(HEIGHT_PRO(6));
        make.left.equalTo(self.view).offset(WIDTH_PRO(8));
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(useDate.mas_bottom).offset(HEIGHT_PRO(10));
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(HEIGHT_PRO(60));
    }];
    
    
    UIView *midbackView = [[UIView alloc]init];
    [self.view addSubview:midbackView];
    midbackView.backgroundColor = [UIColor whiteColor];
    [midbackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_collectionView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(HEIGHT_PRO(50));
    }];
    
    QMUILabel *goumai = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:[UIColor blackColor]];
    goumai.text = @"购买数量";
    [midbackView addSubview:goumai];
    [goumai mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(midbackView);
        make.left.equalTo(midbackView).offset(WIDTH_PRO(8));
    }];
    
    
    
    UIView *calculView = [[UIView alloc]init];
    calculView.layer.borderWidth = 1;
    calculView.layer.borderColor = LINECOLOR.CGColor;
    calculView.layer.cornerRadius = 6;
    calculView.layer.masksToBounds = YES;
    [midbackView addSubview:calculView];
    calculView.backgroundColor = [UIColor whiteColor];
    [calculView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(midbackView).offset(-WIDTH_PRO(15));
        make.centerY.equalTo(midbackView);
        make.height.mas_equalTo(HEIGHT_PRO(40));
        make.width.mas_equalTo(WIDTH_PRO(150));
    }];
    
    
    //加减
    QMUIButton *addBtn = [[QMUIButton alloc]init];
    addBtn.tintColorAdjustsTitleAndImage = MAINCOLOR;
    [addBtn setTitle:@"+" forState:0];
    addBtn.titleLabel.font = HTFont(30);
    [addBtn addTarget:self action:@selector(addNum:) forControlEvents:UIControlEventTouchUpInside];
    [calculView addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(calculView);
        make.right.equalTo(calculView);
        make.width.mas_equalTo(WIDTH_PRO(50));
    }];
    
    QMUIButton *reduceBtn = [[QMUIButton alloc]init];
    reduceBtn.tintColorAdjustsTitleAndImage = MAINCOLOR;
    [reduceBtn setTitle:@"-" forState:0];
    reduceBtn.titleLabel.font = HTFont(30);
    [reduceBtn addTarget:self action:@selector(reduceNum:) forControlEvents:UIControlEventTouchUpInside];
    [calculView addSubview:reduceBtn];
    [reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(calculView);
        make.left.equalTo(calculView);
        make.width.mas_equalTo(WIDTH_PRO(50));
    }];
    
    _payNum = [[QMUILabel alloc]qmui_initWithFont:[UIFont boldSystemFontOfSize:WIDTH_PRO(14)] textColor:[UIColor blackColor]];
    _payNum.text = @"1";
    _payNum.textAlignment = NSTextAlignmentCenter;
    _payNum.qmui_borderColor = LINECOLOR;
    _payNum.qmui_borderWidth = 1;
    _payNum.qmui_borderPosition = QMUIViewBorderPositionLeft | QMUIViewBorderPositionRight;
    [calculView addSubview:_payNum];
    [_payNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(calculView);
        make.left.equalTo(reduceBtn.mas_right);
        make.right.equalTo(addBtn.mas_left);
    }];
    
    
    UIView *midline = [[UIView alloc]init];
    midline.backgroundColor = ZWHCOLOR(@"#F8F8F8");
    [self.view addSubview:midline];
    [midline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(midbackView.mas_bottom);
        make.height.mas_equalTo(HEIGHT_PRO(10));
        make.left.right.equalTo(self.view);
    }];
    
    QMUILabel *infoMan = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:[UIColor blackColor]];
    infoMan.text = @"取票人信息(只需填写1个取票人)";
    NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:@"取票人信息(只需填写1个取票人)"];
    NSRange range1=[infoMan.text rangeOfString:@"(只需填写1个取票人)"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:range1];
    [str addAttribute:NSFontAttributeName value:HTFont(20) range:range1];
    
    NSRange range2=[infoMan.text rangeOfString:@"1个"];
    [str addAttribute:NSForegroundColorAttributeName value:MAINCOLOR range:range2];
    
    infoMan.attributedText = str;
    
    
    [self.view addSubview:infoMan];
    [infoMan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(midline.mas_bottom).offset(HEIGHT_PRO(3));
        make.left.equalTo(midbackView).offset(WIDTH_PRO(8));
    }];
    
    //名字电话
    _nameF = [[QMUITextField alloc]init];
    QMUILabel *lab = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:[UIColor blackColor]];
    lab.text = @"姓名:";
    lab.frame = CGRectMake(0, 0, WIDTH_PRO(40), HEIGHT_PRO(25));
    _nameF.leftView = lab;
    _nameF.leftViewMode = UITextFieldViewModeAlways;
    _nameF.backgroundColor = ZWHCOLOR(@"#F8F8F8");
    _nameF.font = HTFont(28);
    [self.view addSubview:_nameF];
    [_nameF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoMan.mas_bottom).offset(WIDTH_PRO(4));
        make.left.equalTo(self.view).offset(WIDTH_PRO(8));
        make.right.equalTo(self.view).offset(-WIDTH_PRO(8));
        make.height.mas_equalTo(HEIGHT_PRO(25));
    }];
    
    _phoneF = [[QMUITextField alloc]init];
    QMUILabel *lab1 = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:[UIColor blackColor]];
    lab1.text = @"电话:";
    lab1.frame = CGRectMake(0, 0, WIDTH_PRO(40), HEIGHT_PRO(25));
    _phoneF.leftView = lab1;
    _phoneF.leftViewMode = UITextFieldViewModeAlways;
    _phoneF.backgroundColor = ZWHCOLOR(@"#F8F8F8");
    _phoneF.font = HTFont(28);
    _phoneF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_phoneF];
    [_phoneF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameF.mas_bottom).offset(1);
        make.left.equalTo(self.view).offset(WIDTH_PRO(8));
        make.right.equalTo(self.view).offset(-WIDTH_PRO(8));
        make.height.mas_equalTo(HEIGHT_PRO(25));
    }];
    
    [self calculSumPrice];
}

-(void)creatData{
    self.dataArray=[NSMutableArray array];
    //获取日期
    NSDate *nowDate=[NSDate date];
    NSDate *tomorrow=[NSDate dateTomorrow];
    NSDate *yestoday=[NSDate dateWithDaysFromNow:2];
    NSDateFormatter *formater=[[NSDateFormatter alloc]init];
    formater.dateFormat=@"yyyy-MM-dd";
    NSString *t=[formater stringFromDate:tomorrow];
    NSString *y=[formater stringFromDate:yestoday];
    NSString *n=[formater stringFromDate:nowDate];
    NSString *d=@"更多日期>";
    NSArray *array=@[n,t,y,d];
    for (NSInteger i=0; i<4; i++) {
        ZWHTimePriceModel *p=[[ZWHTimePriceModel alloc]init];
        p.time=[NSString stringWithFormat:@"%@",array[i]];
        p.price=[NSString stringWithFormat:@"%@",self.model.saleprice1];
        [self.dataArray addObject:p];
        
    }
    
}

#pragma mark - 计算总价
-(void)calculSumPrice{
    ZWHTimePriceModel *model = _dataArray[_selectIndex];
    float price = [model.price floatValue];
    NSInteger num = [_payNum.text integerValue];
    NSString *text=[NSString stringWithFormat:@"总计:%.2f",price*num];
    NSRange range1=[text rangeOfString:[NSString stringWithFormat:@"%.2f",price*num]];
    NSRange range2=[text rangeOfString:@"总计:"];
    _sumPrice.attributedText=[text Color:[UIColor redColor] ColorRange:range1 Font:HTFont(32) FontRange:range2];
}

#pragma mark - 加 减
-(void)addNum:(QMUIButton *)btn{
    NSInteger num = [_payNum.text integerValue];
    num++;
    _payNum.text = [NSString stringWithFormat:@"%ld",num];
    [self calculSumPrice];
}

-(void)reduceNum:(QMUIButton *)btn{
    NSInteger num = [_payNum.text integerValue];
    if (num==1) {
        return;
    }
    num--;
    _payNum.text = [NSString stringWithFormat:@"%ld",num];
    [self calculSumPrice];
}

#pragma mark - 立即购买
-(void)POCreate{
    [self.view endEditing:YES];
    if (!(self.nameF.text.length>0&&self.phoneF.text.length>0&&[self.phoneF.text isMobileNumberClassification])) {
        [self showHint:@"请完善信息"];
        return;
    }
    
    if ([GroupBuyMananger singleton].isGroupStyle) {
        [GroupBuyMananger singleton].ticket.commonArguments.prono = _model.prono;
        [GroupBuyMananger singleton].ticket.groupBuyParams.para9 = _model.code;
        [GroupBuyMananger singleton].ticket.groupBuyParams.intresult = self.payNum.text;
        [GroupBuyMananger singleton].ticket.groupBuyParams.para1 = _nameF.text;
        [GroupBuyMananger singleton].ticket.groupBuyParams.para2 = _phoneF.text;
        [[GroupBuyMananger singleton] backToGroupBuyWithProName:self.proname];
        
    }else
    {
        [self toPay];
    }
 
}

-(void)toPay{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:UniqUserID forKey:@"memberid"];
    [dict setValue:userType forKey:@"member_type"];
    [dict setValue:@"0" forKey:@"pay"];
    [dict setValue:@"tickets" forKey:@"command"];
    [dict setValue:[NSNumber numberWithBool:false] forKey:@"cart"];
    
    
    ZWHTimePriceModel *timemodel = _dataArray[_selectIndex];
    NSMutableDictionary *infodict = [NSMutableDictionary dictionary];
    [infodict setValue:timemodel.time forKey:@"start_date"];
    [infodict setValue:@"" forKey:@"end_date"];
    [infodict setValue:_nameF.text forKey:@"name"];
    [infodict setValue:_phoneF.text forKey:@"moblie"];
    [infodict setValue:@"" forKey:@"address"];
    NSArray *productArr = @[@{@"product":_model.prono,@"prospec":_model.code,@"nums":self.payNum.text}];
    
    [dict setObject:infodict forKey:@"other_info"];
    [dict setObject:productArr forKey:@"product"];
    
    MJWeakSelf
    [HttpHandler getBillCreate:@{} DataList:@[dict] start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        if (ReturnValue==1) {
            NSDictionary *dict = obj[@"DataList"][0];
            [ZWHOrderModel mj_objectClassInArray];
            ZWHOrderModel *model = [ZWHOrderModel mj_objectWithKeyValues:dict];
            ZWHOrderPayViewController *vc = [[ZWHOrderPayViewController alloc]init];
            vc.state = 4;
            vc.orderModelList = @[model];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else{
            [self showHint:@"下单失败"];
        }
    } failed:^(id obj) {
        
    }];
}
#pragma mark - uicollectionviewdelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZWHTicketDateCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"ZWHTicketDateCollectionViewCell" forIndexPath:indexPath];
    cell.layer.borderColor = LINECOLOR.CGColor;
    cell.layer.borderWidth = 1;
    cell.layer.cornerRadius = 6;
    cell.layer.masksToBounds = YES;
    ZWHTimePriceModel *timemodel = _dataArray[indexPath.row];
    cell.price.text = [NSString stringWithFormat:@"¥%@",timemodel.price];
    cell.title.text = timemodel.time;
    if (indexPath.row == _selectIndex) {
        cell.layer.borderColor = MAINCOLOR.CGColor;
    }else{
        cell.layer.borderColor = LINECOLOR.CGColor;
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    if (indexPath.row<3) {
        _selectIndex = indexPath.row;
        [_collectionView reloadData];
    }else{
        MJWeakSelf
        self.clender=[[BPPCalendar alloc]initWithFrame:[UIScreen mainScreen].bounds SlectBlock:^(NSInteger year,NSInteger moth, NSInteger day) {
            
            [weakSelf updateDataWithDate:[NSString stringWithFormat:@"%ld-%ld-%ld",year,moth,day]];
            
        }];
        self.clender.minDate=[NSDate date];
        [self.view addSubview:self.clender];
    }
    [self calculSumPrice];
}

-(void)updateDataWithDate:(NSString *)time{
    ZWHTimePriceModel *model = [[ZWHTimePriceModel alloc]init];
    model.time = time;
    model.price = _model.saleprice1;
    [_dataArray replaceObjectAtIndex:2 withObject:model];
    _selectIndex = 2;
    [_collectionView reloadData];
}


-(void)addBottom{
    
    UIView *bottomview = [[UIView alloc]init];
    [self.view addSubview:bottomview];
    [bottomview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(HEIGHT_PRO(50));
    }];
    
    
    _sumPrice= [[UILabel alloc]init];
    
    NSString *text=@"总计:0.00";
    NSRange range1=[text rangeOfString:@"0.00"];
    NSRange range2=[text rangeOfString:@"总计:"];
    _sumPrice.attributedText=[text Color:[UIColor redColor] ColorRange:range1 Font:HTFont(32) FontRange:range2];
    _sumPrice.font = HTFont(32);
    _sumPrice.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_sumPrice];
    
    UIButton *button2=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth*0.4,self.view.height-64-50, ScreenWidth*0.6, 50)];
    NSString * title = [GroupBuyMananger singleton].isGroupStyle?@"拼单拼团":@"立即购买";
    [button2 setTitle:title forState:0];
    button2.backgroundColor=MainColor;
    [self.view addSubview:button2];
    [_sumPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomview).offset(WIDTH_PRO(8));
        make.centerY.equalTo(bottomview);
    }];
    
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(bottomview);
        make.width.mas_equalTo(SCREEN_WIDTH*0.6);
    }];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line.backgroundColor = LINECOLOR;
    [bottomview addSubview:line];
    
    [button2 addTarget:self action:@selector(POCreate) forControlEvents:UIControlEventTouchUpInside];
    
}




#pragma mark - 购买须知
-(void)showExplan{
    TicketNoticeVC *vc=[[TicketNoticeVC alloc]init];
    vc.model=_model;
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:vc animated:YES completion:nil];
}


#pragma mark - getter
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        // 初始化一个布局对象
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.sectionInset =UIEdgeInsetsMake(0,0,0, 0);
        
        // 设置最小行距
        flowLayout.minimumLineSpacing = HEIGHT_PRO(10);
        // 设置最小间距
        flowLayout.minimumInteritemSpacing = WIDTH_PRO(10);
        
        // 设置格子大小
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH-WIDTH_PRO(10)*5)/4, HEIGHT_PRO(50));
        // 设置组边界
        flowLayout.sectionInset = UIEdgeInsetsMake(WIDTH_PRO(0), WIDTH_PRO(8), WIDTH_PRO(0), WIDTH_PRO(8));
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // 初始化集合视图
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
        
        // 设置背景色
        _collectionView.backgroundColor = [UIColor whiteColor];
        // 设置代理和数据源
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[ZWHTicketDateCollectionViewCell class] forCellWithReuseIdentifier:@"ZWHTicketDateCollectionViewCell"];
    }
    return _collectionView;
}


@end

