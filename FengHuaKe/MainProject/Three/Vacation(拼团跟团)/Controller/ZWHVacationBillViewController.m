//
//  ZWHVacationBillViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/28.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHVacationBillViewController.h"
#import "KJChangeUserInfoTableViewCell.h"
#import "ZWHPickView.h"
#import "BPPCalendar.h"
#import "InsuranceVC.h"
#import "ZWHOrderPayViewController.h"
#import "ZWHOrderModel.h"

@interface ZWHVacationBillViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)BPPCalendar *clender;


@property(nonatomic,strong)UITableView *detailTable;

@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSArray *placeArr;

@property(nonatomic,strong)NSArray *sectionArr;

@property(nonatomic,strong)NSString *manNum;
@property(nonatomic,strong)NSString *travelTime;
@property(nonatomic,strong)NSString *manName;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *phoneCode;
@property(nonatomic,strong)NSString *remark;

//保险名称
@property(nonatomic,strong)NSString *insuranceName;

//保险信息
@property(nonatomic,strong)NSDictionary *insurDict;

//发送验证码btn
@property(nonatomic,strong)UIButton *sendCodeBtn;
//验证码定时
@property(nonatomic,strong)NSTimer *codeTimer;
//定时秒数
@property(nonatomic,assign)NSInteger waitSecond;

@property(nonatomic,strong)UILabel *sumPrice;

//保险总价
@property(nonatomic,strong)NSString *insurPrice;



@end

@implementation ZWHVacationBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认下单";
    _titleArr = @[@[@"出行人数",@"出行日期"],@[@""],@[@"联系人",@"手机号码",@"验证码",@"备注"]];
    _placeArr = @[@[@"请选择出行人数",@"请选择出行日期"],@[@"点击选择需要的险种"],@[@"填写订单联系人姓名",@"填写订单联系人手机号",@"请填写验证码",@"如有特殊需求请备注"]];
    _sectionArr = @[@"出行信息",@"保险",@"预订人信息"];
    self.manNum = @"1";
    NOTIFY_ADD(getInsuranceDict:, NOTIFICATION_GETINSURANCE);
    [self setUI];
    [self addBottom];
    [self calculprice];
}

-(void)getInsuranceDict:(NSNotification *)nsnot{
    _insurDict = nsnot.object;
    self.insuranceName = _insurDict[@"name"];
    _insurPrice = _insurDict[@"price"];
    [self calculprice];
    [self.detailTable reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    NSLog(@"%@",_insurDict);
}

-(void)setUI{
    
    _detailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-HEIGHT_PRO(50)) style:UITableViewStyleGrouped];
    [self.view addSubview:_detailTable];
    [_detailTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(ZWHNavHeight);
        make.bottom.equalTo(self.view).offset(-HEIGHT_PRO(50));
    }];
    _detailTable.delegate = self;
    _detailTable.dataSource = self;
    _detailTable.separatorStyle = 0;
    _detailTable.backgroundColor = LINECOLOR;
    _detailTable.showsVerticalScrollIndicator = NO;
    [_detailTable registerClass:[KJChangeUserInfoTableViewCell class] forCellReuseIdentifier:@"KJChangeUserInfoTableViewCell"];
    self.keyTableView = _detailTable;
    
    [self setHeader];
}

-(void)setHeader{
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = [UIColor whiteColor];
    headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(90));
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = LINECOLOR;
    line.frame = CGRectMake(0, headView.height-HEIGHT_PRO(10), SCREEN_WIDTH, HEIGHT_PRO(10));
    [headView addSubview:line];
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_PRO(8), WIDTH_PRO(8), WIDTH_PRO(70), WIDTH_PRO(70))];
    img.layer.cornerRadius = WIDTH_PRO(6);
    img.layer.masksToBounds = YES;
    [headView addSubview:img];
    [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,_model.Product.url]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
    
    QMUILabel *title = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:[UIColor blackColor]];
    title.text = _model.Product.proname;
    [headView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(img.mas_right).offset(WIDTH_PRO(8));
        make.top.equalTo(img.mas_top);
    }];
    
    QMUILabel *price = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:[UIColor redColor]];
    price.text = [NSString stringWithFormat:@"¥%@",_model.Product.saleprice];
    [headView addSubview:price];
    [price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(img.mas_right).offset(WIDTH_PRO(8));
        make.bottom.equalTo(img.mas_bottom);
    }];
    
    self.detailTable.tableHeaderView = headView;
}

#pragma mark - 设置底部按钮
-(void)addBottom{
    
    UIView *bottomview = [[UIView alloc]init];
    [self.view addSubview:bottomview];
    [bottomview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(HEIGHT_PRO(50));
    }];
    
    _sumPrice= [[UILabel alloc]init];
    _sumPrice.font = HTFont(32);
    _sumPrice.backgroundColor=[UIColor whiteColor];
    _sumPrice.textColor = [UIColor blackColor];
    _sumPrice.numberOfLines = 2;
    [bottomview addSubview:_sumPrice];
    
    [_sumPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomview).offset(WIDTH_PRO(20));
        make.centerY.equalTo(bottomview);
    }];
    
    UIButton *button2=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth*0.4,self.view.height-64-50, ScreenWidth*0.6, 50)];
    [button2 setTitle:@"提交订单" forState:0];
    button2.backgroundColor=MainColor;
    [self.view addSubview:button2];
    
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(bottomview);
        make.width.mas_equalTo(SCREEN_WIDTH*0.4);
    }];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line.backgroundColor = LINECOLOR;
    [bottomview addSubview:line];
    
    [button2 addTarget:self action:@selector(isCodeRig) forControlEvents:UIControlEventTouchUpInside];
    
}

//计算总价
-(void)calculprice{
    NSString *text = [NSString stringWithFormat:@"订单总价:¥%.2f",[self.manNum integerValue]*[_model.Product.saleprice floatValue]];
    float sum;
    if (_insurPrice.length > 0) {
        sum = [self.manNum integerValue]*[_model.Product.saleprice floatValue]+[_insurPrice floatValue];
        text = [NSString stringWithFormat:@"%@\n(含)保险金额:¥%@",[NSString stringWithFormat:@"订单总价:¥%.2f",sum],_insurPrice];
    }else{
        sum = [self.manNum integerValue]*[_model.Product.saleprice floatValue];
    }
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:text];
    
    
    
    NSRange rag1 = [text rangeOfString:[NSString stringWithFormat:@"¥%.2f",sum]];
    NSRange rag2 = [text rangeOfString:[NSString stringWithFormat:@"(含)保险金额:¥%@",_insurPrice]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:rag1];
    [str addAttribute:NSForegroundColorAttributeName value:ZWHCOLOR(@"5C5C5C") range:rag2];
    [str addAttribute:NSFontAttributeName value:HTFont(24) range:rag2];

    
    _sumPrice.attributedText = str;
}

#pragma mark - uitabledelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _titleArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_titleArr[section] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_PRO(40);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HEIGHT_PRO(40);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return HEIGHT_PRO(10);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(40))];
    view.backgroundColor = [UIColor whiteColor];
    
    
    QMUILabel *explan = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:[UIColor blackColor]];
    explan.text = _sectionArr[section];
    explan.font = [UIFont boldSystemFontOfSize:WIDTH_PRO(14)];
    [view addSubview:explan];
    [explan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(WIDTH_PRO(8));
        make.centerY.equalTo(view);
    }];
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0||indexPath.section==2) {
        KJChangeUserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KJChangeUserInfoTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        cell.isWidTitle = YES;
        cell.leftTitleStr = _titleArr[indexPath.section][indexPath.row];
        cell.contentTex.textAlignment = NSTextAlignmentLeft;
        cell.contentTex.placeholder = _placeArr[indexPath.section][indexPath.row];
        MJWeakSelf
        switch (indexPath.section) {
            case 0:
                {
                    cell.contentTex.enabled = NO;
                    switch (indexPath.row) {
                        case 0:
                            {
                                cell.contentTex.text = self.manNum;
                            }
                            break;
                        case 1:
                        {
                            cell.contentTex.text = self.travelTime;
                        }
                            break;
                        default:
                            break;
                    }
                }
                break;
            case 2:
            {
                switch (indexPath.row) {
                    case 0:
                        {
                            [cell didEndInput:^(NSString *input) {
                                weakSelf.manName = input;
                            }];
                        }
                        break;
                    case 1:
                    {
                        cell.contentTex.keyboardType = UIKeyboardTypeNumberPad;
                        cell.contentTex.maximumTextLength = 11;
                        [cell didEndInput:^(NSString *input) {
                            weakSelf.phone = input;
                        }];
                    }
                        break;
                    case 2:
                    {
                        _sendCodeBtn = cell.rightbtn;
                        [cell.rightbtn setTitle:@"发送验证码" forState:0];
                        [cell.rightbtn setTitleColor:MAINCOLOR forState:0];
                        cell.rightbtn.titleLabel.font = HTFont(26);
                        cell.contentTex.keyboardType = UIKeyboardTypeNumberPad;
                        cell.contentTex.maximumTextLength = 6;
                        [cell.rightbtn addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
                        [cell didEndInput:^(NSString *input) {
                            weakSelf.phoneCode = input;
                        }];
                    }
                        break;
                    case 3:
                    {
                        [cell didEndInput:^(NSString *input) {
                            weakSelf.remark = input;
                        }];
                    }
                        break;
                    default:
                        break;
                }
            }
                break;
            default:
                break;
        }
        return cell;
    }else{
        KJChangeUserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KJChangeUserInfoTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        cell.contentTex.textAlignment = NSTextAlignmentLeft;
        cell.contentTex.placeholder = _placeArr[indexPath.section][indexPath.row];
        [cell showRightImage:YES];
        cell.rightImage.image = [UIImage imageNamed:@"choosePhoto"];
        cell.contentTex.enabled = NO;
        cell.contentTex.text = self.insuranceName;
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [self.view endEditing:YES];
        switch (indexPath.row) {
            case 0:
                {
                    NSMutableArray *array = [NSMutableArray array];
                    for (NSInteger i = 1; i<=200; i++) {
                        [array addObject:[NSString stringWithFormat:@"%ld",i]];
                    }
                    MJWeakSelf
                    [ZWHPickView showZWHPickView:array with:^(NSString *value, NSInteger index) {
                        weakSelf.manNum = value;
                        [weakSelf.detailTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                        [weakSelf calculprice];
                    }];
                }
                break;
            case 1:
            {
                MJWeakSelf
                self.clender=[[BPPCalendar alloc]initWithFrame:[UIScreen mainScreen].bounds SlectBlock:^(NSInteger year,NSInteger moth, NSInteger day) {
                                weakSelf.travelTime = [NSString stringWithFormat:@"%ld-%02ld-%02ld",year,moth,day];
                    [weakSelf.detailTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                      
                }];
                self.clender.minDate=[NSDate date];
                [self.view addSubview:self.clender];
            }
                break;
            default:
                break;
        }
    }else if (indexPath.section == 1){
        //保险
        InsuranceVC *vc=[[InsuranceVC alloc]init];
        vc.code=_InsuranceCode;
        vc.isTravel = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 发送验证码  验证按钮状态
-(void)sendCode:(UIButton *)btn{
    if (!(self.phone.length>0&&[self.phone isMobileNumberClassification]==YES)) {
        [self showHint:@"请输入正确的手机号"];
        return;
    }
    
    MJWeakSelf;
    [self showEmptyViewWithLoading];
    [HttpHandler getSendMobileCode:@{@"para1":@"X",@"para2":_phone} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        [self hideEmptyView];
        if (ReturnValue==1) {
            [self showHint:@"发送成功"];
            [weakSelf startWaitTime];
        }else{
            [self showHint:@"发送验证码失败"];
        }
    } failed:^(id obj) {
        [self hideEmptyView];
        [self showHint:@"发送验证码失败"];
    }];
}

//开始计时
-(void)startWaitTime{
    _waitSecond = 60;
    [_sendCodeBtn setTitle:[NSString stringWithFormat:@"已发送(%ld)",_waitSecond] forState:0];
    [_sendCodeBtn setTitleColor:[UIColor grayColor] forState:0];
    _sendCodeBtn.userInteractionEnabled = NO;
    
    self.codeTimer  = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.codeTimer forMode:NSDefaultRunLoopMode];
}

//定时方法
-(void)timerMethod{
    _waitSecond--;
    if (_waitSecond==0) {
        [self.codeTimer invalidate];
        self.codeTimer = nil;
        [self iscanSendState];
    }else{
         [_sendCodeBtn setTitle:[NSString stringWithFormat:@"已发送(%ld)",_waitSecond] forState:0];
    }
    
}

//恢复发送状态
-(void)iscanSendState{
    [_sendCodeBtn setTitle:@"发送验证码" forState:0];
    [_sendCodeBtn setTitleColor:MAINCOLOR forState:0];
    _sendCodeBtn.userInteractionEnabled = YES;
}

-(void)dealloc{
    [self.codeTimer invalidate];
    self.codeTimer = nil;
    NOTIFY_REMOVEALL;
}

#pragma mark - 验证是否有效

-(void)isCodeRig{
    if (!(self.phone.length>0&&self.phoneCode.length>0)) {
        [self showHint:@"请输入手机号和验证码"];
        return;
    }
    MJWeakSelf
    [self showEmptyViewWithLoading];
    [HttpHandler getIsValidCode:@{@"para1":@"X",@"para2":self.phone,@"para3":self.phoneCode} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        [weakSelf hideEmptyView];
        if (ReturnValue==1) {
            [weakSelf POCreate];
        }else{
            [self showHint:@"验证码错误"];
        }
    } failed:^(id obj) {
        [weakSelf hideEmptyView];
    }];
}


#pragma mark - 生成订单
-(void)POCreate{
    [self.view endEditing:YES];
    
    if (!(self.manNum.length>0&&self.travelTime.length>0&&self.manName.length>0&&self.phone.length>0&&self.phoneCode.length>0)) {
        [self showHint:@"请完善信息"];
        return;
    }
    if (_insurDict==nil) {
        [self showHint:@"请完善信息"];
        return;
    }
    
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:UniqUserID forKey:@"memberid"];
    [dict setValue:userType forKey:@"member_type"];
    [dict setValue:@"0" forKey:@"pay"];
    [dict setValue:@"travel" forKey:@"command"];
    [dict setValue:[NSNumber numberWithBool:false] forKey:@"cart"];
    
    NSMutableDictionary *infodict = [NSMutableDictionary dictionary];
    [infodict setValue:self.travelTime forKey:@"start_date"];
    [infodict setValue:_insurDict[@"end_date"] forKey:@"end_date"];
    [infodict setValue:self.manName forKey:@"name"];
    [infodict setValue:self.phone forKey:@"moblie"];
    [infodict setValue:_insurDict[@"address"] forKey:@"address"];
    
    
    NSArray *productArr = @[@{@"product":_model.Product.productno,@"prospec":_prospec,@"nums":self.manNum}];
    
    
    [dict setObject:infodict forKey:@"other_info"];
    [dict setObject:_insurDict[@"user"] forKey:@"user"];
    [dict setObject:productArr forKey:@"product"];
    
    MJWeakSelf
    [HttpHandler getBillCreate:@{} DataList:@[dict] start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        if (ReturnValue==1) {
            NSDictionary *dict = obj[@"DataList"][0];
            [ZWHOrderModel mj_objectClassInArray];
            ZWHOrderModel *model = [ZWHOrderModel mj_objectWithKeyValues:dict];
            ZWHOrderPayViewController *vc = [[ZWHOrderPayViewController alloc]init];
            vc.state = 6;
            vc.orderModelList = @[model];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else{
            [self showHint:@"下单失败"];
        }
    } failed:^(id obj) {
        
    }];
    
}



@end
