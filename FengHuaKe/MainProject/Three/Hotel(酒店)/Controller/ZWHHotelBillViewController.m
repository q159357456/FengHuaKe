//
//  ZWHHotelBillViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/24.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHHotelBillViewController.h"
#import "RoomModel.h"
#import "NSDate+Extension.h"
#import "KJChangeUserInfoTableViewCell.h"
#import "ZWHPickView.h"
#import "WSDatePickerView.h"
#import "ZWHOrderPayViewController.h"
#import "ZWHOrderModel.h"


@interface ZWHHotelBillViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *billTable;

@property(nonatomic,strong)RoomModel *roomModel;

@property(nonatomic,strong)UILabel *sumPrice;

@property(nonatomic,strong)NSArray *titleArr;

@property(nonatomic,strong)NSString *salenum;
@property(nonatomic,strong)NSString *manName;
@property(nonatomic,strong)NSString *manPhone;
@property(nonatomic,strong)NSString *mantime;
@property(nonatomic,strong)NSString *remark;


@end

@implementation ZWHHotelBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArr = @[@"预定数量",@"入住人",@"手机号",@"到店时间",@"其他要求",@"发票"];
    _salenum = @"1";
    _remark = @"";
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"HH:mm"];
    _mantime = [format stringFromDate:[NSDate date]];
    [self getHotelRoom];
}

-(void)getHotelRoom{
    [self showEmptyViewWithLoading];
    MJWeakSelf
    [HttpHandler getHotelRoom:@{@"para1":self.hotelID,@"para2":_model.productno} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        [weakSelf hideEmptyView];
        if (ReturnValue==1) {
            NSLog(@"%@",obj);
            NSArray *toparr = [HttpTool getArrayWithData:obj[@"sysmodel"][@"strresult"]];
            weakSelf.roomModel = [RoomModel mj_objectWithKeyValues:toparr[0]];
            [weakSelf setUI];
        }else{
            [weakSelf showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(getHotelRoom)];
        }
    } failed:^(id obj) {
        [weakSelf hideEmptyView];
        [weakSelf showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(getHotelRoom)];
    }];
}


-(void)setUI{
    _billTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-HEIGHT_PRO(50)) style:UITableViewStylePlain];
    [self.view addSubview:_billTable];
    [_billTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(ZWHNavHeight);
        make.bottom.equalTo(self.view).offset(-HEIGHT_PRO(50));
    }];
    _billTable.delegate = self;
    _billTable.dataSource = self;
    _billTable.separatorStyle = 0;
    _billTable.showsVerticalScrollIndicator = NO;
    [_billTable registerClass:[KJChangeUserInfoTableViewCell class] forCellReuseIdentifier:@"KJChangeUserInfoTableViewCell"];
    self.keyTableView = _billTable;
    
    [self setHeader];
    [self addBottom];
}

#pragma mark - 设置头部视图
-(void)setHeader{
    UIView *header = [[UIView alloc]init];
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(165));
    header.backgroundColor = ZWHCOLOR(@"#EBEBEB");
    
    QMUILabel *title = [[QMUILabel alloc]qmui_initWithFont:HTFont(34) textColor:MAINCOLOR];
    title.text = _model.proname;
    [header addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(header).offset(WIDTH_PRO(15));
    }];
    
    QMUILabel *detail = [[QMUILabel alloc]qmui_initWithFont:HTFont(30) textColor:DEEPLINE];
    detail.text = [NSString stringWithFormat:@"%@ %@ %@人 %@ %@",[_roomModel.saleunit boolValue]?@"有早餐":@"无早餐",_roomModel.spec,_model.rowindex,_roomModel.modelnum,_roomModel.fitobject];
    [header addSubview:detail];
    [detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(title.mas_left);
        make.top.equalTo(title.mas_bottom).offset(WIDTH_PRO(20));
    }];
    
    QMUILabel *starttime = [[QMUILabel alloc]qmui_initWithFont:HTFont(30) textColor:DEEPLINE];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDate = [format dateFromString:_timeArr[0]];
    [format setDateFormat:@"MM月dd日"];
    starttime.text = [NSString stringWithFormat:@"入住 %@ (%@)",[format stringFromDate:startDate],[startDate chineseWeekDay]];
    [header addSubview:starttime];
    [starttime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(title.mas_left);
        make.top.equalTo(detail.mas_bottom).offset(WIDTH_PRO(20));
    }];
    
    QMUILabel *endtime = [[QMUILabel alloc]qmui_initWithFont:HTFont(30) textColor:DEEPLINE];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *endDate = [format dateFromString:_timeArr[1]];
    [format setDateFormat:@"MM月dd日"];
    endtime.text = [NSString stringWithFormat:@"离开 %@ (%@)",[format stringFromDate:endDate],[endDate chineseWeekDay]];
    [header addSubview:endtime];
    [endtime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(title.mas_left);
        make.top.equalTo(starttime.mas_bottom).offset(WIDTH_PRO(20));
    }];
    
    
    
    _billTable.tableHeaderView = header;
}

//底部按钮
-(void)addBottom{
    
    UIView *bottomview = [[UIView alloc]init];
    [self.view addSubview:bottomview];
    [bottomview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(HEIGHT_PRO(50));
    }];
    
    
    _sumPrice= [[UILabel alloc]init];
    
    NSString *text=[NSString stringWithFormat:@"总计:%@",_roomModel.buyprice];
    NSRange range1=[text rangeOfString:_roomModel.buyprice];
    NSRange range2=[text rangeOfString:@"总计:"];
    _sumPrice.attributedText=[text Color:[UIColor redColor] ColorRange:range1 Font:HTFont(32) FontRange:range2];
    _sumPrice.font = HTFont(32);
    _sumPrice.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_sumPrice];
    UIButton *button2=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth*0.4,self.view.height-64-50, ScreenWidth*0.6, 50)];
    [button2 setTitle:@"提交订单" forState:0];
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
    
    [self calculSumPrice];
}

#pragma mark - 计算总价
-(void)calculSumPrice{
    float price = [_roomModel.buyprice floatValue];
    NSInteger num = [_salenum integerValue];
    NSInteger day = [self getDifferenceByDate:_timeArr[0] with:_timeArr[1]];
    
    NSString *text=[NSString stringWithFormat:@"总计:%.2f",price*num*day];
    NSRange range1=[text rangeOfString:[NSString stringWithFormat:@"%.2f",price*num*day]];
    NSRange range2=[text rangeOfString:@"总计:"];
    _sumPrice.attributedText=[text Color:[UIColor redColor] ColorRange:range1 Font:HTFont(32) FontRange:range2];
}

#pragma mark - tableviewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_PRO(35);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KJChangeUserInfoTableViewCell *cell = [[KJChangeUserInfoTableViewCell alloc]init];
    cell.selectionStyle = 0;
    cell.isWidTitle = YES;
    cell.leftTitleStr = _titleArr[indexPath.row];
    cell.leftLable.textColor = DEEPLINE;
    cell.leftLable.font = HTFont(28);
    cell.contentTex.textAlignment = NSTextAlignmentLeft;
    MJWeakSelf
    switch (indexPath.row) {
        case 0:
            {
                cell.rightTitleStr = @"间";
                cell.contentTex.enabled = NO;
                cell.contentTex.text = _salenum;
            }
            break;
        case 1:
        {
            cell.contentTex.placeholder = @"入住人姓名";
            [cell didEndInput:^(NSString *input) {
                weakSelf.manName = input;
            }];
        }
            break;
        case 2:
        {
            cell.contentTex.placeholder = @"入住人手机号";
            cell.contentTex.keyboardType = UIKeyboardTypeNumberPad;
            [cell didEndInput:^(NSString *input) {
                weakSelf.manPhone = input;
            }];
        }
            break;
        case 3:
        {
            [cell showRightImage:YES];
            cell.rightImage.image = [UIImage imageNamed:@"clear_icon"];
            cell.contentTex.enabled = NO;
            cell.contentTex.text = _mantime;
        }
            break;
        case 4:
        {
            cell.contentTex.placeholder = @"特殊需求 如楼层";
            [cell didEndInput:^(NSString *input) {
                weakSelf.remark = input;
            }];
        }
            break;
        case 5:
        {
            cell.contentTex.placeholder = @"如需提供发票，请在离店时向酒店索取";
            cell.contentTex.enabled = NO;
            [cell didEndInput:^(NSString *input) {
                self.remark = input;
            }];
        }
            break;
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self.view endEditing:YES];
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger i = 1; i<=50; i++) {
            [array addObject:[NSString stringWithFormat:@"%ld",i]];
        }
        MJWeakSelf
        [ZWHPickView showZWHPickView:array with:^(NSString *value, NSInteger index) {
            NSLog(@"%ld",index);
            weakSelf.salenum = value;
            [weakSelf.billTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [weakSelf calculSumPrice];
        }];
    }else if (indexPath.row == 3){
        [self.view endEditing:YES];
        MJWeakSelf
        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowHourMinute CompleteBlock:^(NSDate *selectDate) {
            weakSelf.mantime = [selectDate stringWithFormat:@"HH:mm"];
            [weakSelf.billTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        datepicker.dateLabelColor = [UIColor clearColor];//年-月-日-时-分 颜色
        datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
        datepicker.doneButtonColor = MAINCOLOR;//确定按钮的颜色
        datepicker.yearLabelColor = [UIColor clearColor];//大号年份字体颜色
        [datepicker show];
    }
}


#pragma mark - 立即购买
-(void)POCreate{
    [self.view endEditing:YES];
    if (!(self.manName.length>0&&self.manPhone.length>0)) {
        [self showHint:@"请完善信息"];
        return;
    }
    
    if (![self.manPhone isMobileNumberClassification]) {
        [self showHint:@"手机号不合法"];
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:UniqUserID forKey:@"memberid"];
    [dict setValue:userType forKey:@"member_type"];
    [dict setValue:@"0" forKey:@"pay"];
    [dict setValue:@"hotel" forKey:@"command"];
    [dict setValue:[NSNumber numberWithBool:false] forKey:@"cart"];
    [dict setValue:_remark forKey:@"remark"];
    
    
    //ZWHTimePriceModel *timemodel = _dataArray[_selectIndex];
    NSMutableDictionary *infodict = [NSMutableDictionary dictionary];
    [infodict setValue:_timeArr[0] forKey:@"start_date"];
    [infodict setValue:_timeArr[1] forKey:@"end_date"];
    [infodict setValue:_manName forKey:@"name"];
    [infodict setValue:_manPhone forKey:@"moblie"];
    [infodict setValue:[NSString stringWithFormat:@"%@ %@",_timeArr[0],_mantime] forKey:@"address"];
    NSArray *productArr = @[@{@"product":_roomModel.prono,@"prospec":_roomModel.code,@"nums":_salenum}];
    
    [dict setObject:infodict forKey:@"other_info"];
    [dict setObject:productArr forKey:@"product"];
    [self showHudInView:self.view hint:@""];
    MJWeakSelf
    [HttpHandler getBillCreate:@{} DataList:@[dict] start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        [weakSelf hideHud];
        if (ReturnValue==1) {
            NSDictionary *dict = obj[@"DataList"][0];
            [ZWHOrderModel mj_objectClassInArray];
            ZWHOrderModel *model = [ZWHOrderModel mj_objectWithKeyValues:dict];
            ZWHOrderPayViewController *vc = [[ZWHOrderPayViewController alloc]init];
            vc.state = 5;
            vc.orderModelList = @[model];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else{
            [self showHint:@"下单失败"];
        }
    } failed:^(id obj) {
        [weakSelf hideHud];
    }];
}


//时间差
- (NSInteger)getDifferenceByDate:(NSString *)oneday with:(NSString *)twoday {
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *oneDate = [dateFormatter dateFromString:oneday];
    NSDate *twoDate = [dateFormatter dateFromString:twoday];
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    //unsigned int unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ;
    unsigned int unitFlags = NSCalendarUnitDay;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:oneDate  toDate:twoDate  options:0];
    return [comps day];
}


@end
