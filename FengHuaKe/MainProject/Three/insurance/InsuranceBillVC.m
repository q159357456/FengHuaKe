//
//  InsuranceBillVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/26.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "InsuranceBillVC.h"
#import "InsuranceVM.h"
#import "POCreat.h"
#import "InsuranceBillCell.h"
#import "InsurancePersonCell.h"
#import "Masonry.h"
#import "BPPCalendar.h"
#import "UIViewController+HUD.h"
#import "NSObject+dicANDmodel.h"
#import "NSDate+Extension.h"
#import "NSString+Addition.h"
#import "KJChangeUserInfoTableViewCell.h"
#import "ZWHInsurancePriceModel.h"
#import "ZWHOrderPayViewController.h"
#import "ZWHOrderModel.h"
#import "ZWHVacationBillViewController.h"

@interface InsuranceBillVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *userList;
@property(nonatomic,strong)Product *product;
@property(nonatomic,strong)Oter_info *other_info;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,strong)UILabel *headerLable;

@property(nonatomic,strong)UILabel *sumPrice;

@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,copy)NSString *adress;
@property(nonatomic,copy)NSString *mannumber;

@property(nonatomic,strong)ZWHInsurancePriceModel *priceModel;

@end

@implementation InsuranceBillVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"保险订单";
    _titleArray = @[@"目的地",@"出发日期",@"结束日期",@"投保人数"];
    self.adress = @"";
    self.mannumber = @"1";
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-HEIGHT_PRO(50));
    }];
    [self addBottom];
    self.tableview .tableHeaderView=self.headerLable;
    [self calculPrice];
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
    _sumPrice.textColor = [UIColor redColor];
    [self.view addSubview:_sumPrice];
    
    UIButton *button2=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth*0.4,self.view.height-64-50, ScreenWidth*0.6, 50)];
    [button2 setTitle:@"立即购买" forState:0];
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

#pragma mark -  懒加载
-(NSMutableArray *)userList
{
    if (!_userList) {
        _userList=[NSMutableArray array];
        
    }
    return _userList;
}
-(UILabel *)headerLable
{
    if (!_headerLable) {
        _headerLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        NSString *str=@"  [境外] 境外旅游 经济款";
        NSMutableAttributedString *attr=[[NSMutableAttributedString alloc]initWithString:str];
        _headerLable.attributedText=attr;
        //_headerLable.text = _model.claim;
    }
    return _headerLable;
}
-(UITableView *)tableview
{
    if (!_tableview) {
        
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, self.view.height-64) style:UITableViewStylePlain];
        _tableview.tableFooterView=[UIView new];
        _tableview.rowHeight=UITableViewAutomaticDimension;
        [_tableview registerNib:[UINib nibWithNibName:@"InsuranceBillCell" bundle:nil] forCellReuseIdentifier:@"InsuranceBillCell"];
        [_tableview registerNib:[UINib nibWithNibName:@"InsurancePersonCell" bundle:nil] forCellReuseIdentifier:@"InsurancePersonCell"];
        [_tableview registerClass:[KJChangeUserInfoTableViewCell class] forCellReuseIdentifier:@"KJChangeUserInfoTableViewCell"];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        
        
    }
    return _tableview;
}
-(Product *)product
{
    if (!_product) {
        _product=[[Product alloc ]init];
        _product.product=self.code;
        _product.nums=@"0";
    }
    return _product;
}
-(Oter_info *)other_info
{
    if (!_other_info) {
        _other_info=[[Oter_info alloc]init];
        NSDate *date=[NSDate date];
        NSDate *tomm=[NSDate dateTomorrow];
        _other_info.start_date=[NSString stringWithFormat:@"%ld-%ld-%ld",date.year,date.month,date.day];
        _other_info.end_date=[NSString stringWithFormat:@"%ld-%ld-%ld",date.year,tomm.month,tomm.day];
    }
    return _other_info;
}
#pragma mark - 获取规格
-(void)InsurePrice{
    //NSInteger day = [self getDifferenceByDate:self.other_info.start_date with:self.other_info.end_date];
    MJWeakSelf
    [HttpHandler getInsurePrice:@{@"para1":self.code,@"intresult":@"1"} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        if (ReturnValue==1) {
            weakSelf.priceModel = [ZWHInsurancePriceModel mj_objectWithKeyValues:obj[@"DataList"][0]];
            [weakSelf calculPrice];
        }
    } failed:^(id obj) {
        
    }];
}

-(void)calculPrice{
    NSInteger day = [self getDifferenceByDate:self.other_info.start_date with:self.other_info.end_date];
    MJWeakSelf;
    [HttpHandler getInsurePrice:@{@"para1":self.code,@"intresult":[NSString stringWithFormat:@"%ld",day]} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        if (ReturnValue==1) {
            weakSelf.priceModel = [ZWHInsurancePriceModel mj_objectWithKeyValues:obj[@"DataList"][0]];
            float price = [_priceModel.price floatValue];
            NSString *text=[NSString stringWithFormat:@"总计:%.2f",price*[_mannumber floatValue]];
            //NSRange range1=[text rangeOfString:[NSString stringWithFormat:@"%.2f",price*[_mannumber floatValue]]];
            NSRange range2=[text rangeOfString:@"总计:"];
            NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:text];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
            //[str addAttribute:NSFontAttributeName value:font range:fontRange];
            ///_sumPrice.attributedText=[text Color:[UIColor redColor] ColorRange:range1 Font:HTFont(32) FontRange:range2];
            _sumPrice.attributedText = str;
        }
    } failed:^(id obj) {
        [self showHint:@"？？？"];
    }];
    
}

#pragma mark - 生成订单
-(void)POCreate{
    [self.view endEditing:YES];
    
    if (!(self.adress.length>0&&self.userList.count==[self.mannumber integerValue])) {
        [self showHint:@"请完善信息"];
        return;
    }
    
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:UniqUserID forKey:@"memberid"];
    [dict setValue:userType forKey:@"member_type"];
    [dict setValue:@"0" forKey:@"pay"];
    [dict setValue:@"insure" forKey:@"command"];
    [dict setValue:[NSNumber numberWithBool:false] forKey:@"cart"];
    [dict setValue:self.adress forKey:@"address"];
    
    NSMutableDictionary *infodict = [NSMutableDictionary dictionary];
    [infodict setValue:self.other_info.start_date forKey:@"start_date"];
    [infodict setValue:self.other_info.end_date forKey:@"end_date"];
    [infodict setValue:@"" forKey:@"name"];
    [infodict setValue:@"" forKey:@"moblie"];
    [infodict setValue:@"" forKey:@"address"];
    
    NSMutableArray *datalistArray=[NSMutableArray array];
    
    NSArray *productArr = @[@{@"product":self.code,@"prospec":_priceModel.dayname,@"nums":self.mannumber}];
    
    for (User *model in self.userList) {
        [datalistArray addObject:@{@"name":model.name,@"doc_type":@"01",@"doc_no":model.doc_no,@"mobile":model.mobile,@"birth_date":[NSString birthdayStrFromIdentityCard:model.doc_no],@"sex":@"3"}];
    }
    
    [dict setObject:infodict forKey:@"other_info"];
    [dict setObject:datalistArray forKey:@"user"];
    [dict setObject:productArr forKey:@"product"];
    
    if (_isTravel == YES) {
        NSMutableDictionary *dictTravel = [NSMutableDictionary dictionary];
        [dictTravel setObject:datalistArray forKey:@"user"];
        [dictTravel setObject:_priceModel.dayname forKey:@"address"];
        [dictTravel setObject:self.code forKey:@"end_date"];
        [dictTravel setObject:_model.codename forKey:@"name"];
        float price = [_priceModel.price floatValue];
        NSString *money = [NSString stringWithFormat:@"%.2f",price*[_mannumber floatValue]];
        [dictTravel setObject:money forKey:@"price"];
        for (UIViewController *vc in self.navigationController.childViewControllers) {
            if ([vc isKindOfClass:[ZWHVacationBillViewController class]]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_GETINSURANCE object:dictTravel];
                [self.navigationController popToViewController:vc animated:YES];
                return;
            }
        }
    }
    
    MJWeakSelf
    [HttpHandler getBillCreate:@{} DataList:@[dict] start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        if (ReturnValue==1) {
            NSDictionary *dict = obj[@"DataList"][0];
            [ZWHOrderModel mj_objectClassInArray];
            ZWHOrderModel *model = [ZWHOrderModel mj_objectWithKeyValues:dict];
            ZWHOrderPayViewController *vc = [[ZWHOrderPayViewController alloc]init];
            vc.state = 3;
            vc.orderModelList = @[model];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else{
            [self showHint:@"下单失败"];
        }
    } failed:^(id obj) {
        
    }];
   
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    switch (section) {
        case 0:
        {
            return _titleArray.count;
            
        }
            break;
            
        case 1:
        {
            return self.userList.count;
        }
            break;
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        KJChangeUserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KJChangeUserInfoTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isWidTitle = YES;
        cell.leftTitleStr = _titleArray[indexPath.row];
        MJWeakSelf
        switch (indexPath.row) {
            case 0:
                {
                    cell.rightImage.userInteractionEnabled = NO;
                    cell.rightbtn.userInteractionEnabled = NO;
                    cell.contentTex.placeholder = _titleArray[indexPath.row];
                    [cell didEndInput:^(NSString *input) {
                        weakSelf.adress = input;
                    }];
                }
                break;
            case 1:
            {
                cell.contentTex.text = weakSelf.other_info.start_date;
                cell.contentTex.enabled =NO;
            }
                break;
            case 2:
            {
                cell.contentTex.text = weakSelf.other_info.end_date;
                cell.contentTex.enabled =NO;
            }
                break;
            case 3:
            {
                cell.contentTex.text = weakSelf.mannumber;
                cell.contentTex.keyboardType = UIKeyboardTypeNumberPad;
                cell.rightImage.userInteractionEnabled = NO;
                cell.rightbtn.userInteractionEnabled = NO;
                [cell didEndInput:^(NSString *input) {
                    if ([input isEqualToString:@""] || [input isEqualToString:@"0"]) {
                        weakSelf.mannumber = @"1";
                        cell.contentTex.text = @"1";
                    }else{
                        weakSelf.mannumber = input;
                    }
                    [weakSelf calculPrice];
                }];
            }
                break;
            default:
                break;
        }
        return cell;
    }else{
        InsurancePersonCell *cell=[tableView dequeueReusableCellWithIdentifier:@"InsurancePersonCell"];
        User *u=self.userList[indexPath.row];
        cell.lable1.text=u.name;
        //cell.lable2.text=u.doc_no;
        //cell.lable3.text=u.mobile;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return 44;
    }
    return 0;
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
    
        return [self secondHeaderView];
    }else
        return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }else
        return 0;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
   
    if (section == 0) {
         UIView *view=[UIView new];
        view.backgroundColor=defaultColor1;
        return view;
    }else
    {
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return 43;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        DefineWeakSelf;
        //InsuranceBillCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        if (indexPath.row == 1)
        {
            BPPCalendar *clender=[[BPPCalendar alloc]initWithFrame:[UIScreen mainScreen].bounds SlectBlock:^(NSInteger year,NSInteger moth, NSInteger day) {
                
                if ([weakSelf compareOneDay:[NSString stringWithFormat:@"%ld-%ld-%ld",year,moth,day] withAnotherDay:weakSelf.other_info.end_date]>=0) {
                    [weakSelf showHint:@"出发日期晚于结束日期"];
                }else{
                    weakSelf.other_info.start_date=[NSString stringWithFormat:@"%ld-%ld-%ld",year,moth,day];
                    [weakSelf calculPrice];
                }
                [weakSelf.tableview reloadData];
            }];
             clender.minDate=[NSDate date];
            [self.view addSubview:clender];
        }else if (indexPath.row == 2)
        {
            BPPCalendar *clender=[[BPPCalendar alloc]initWithFrame:[UIScreen mainScreen].bounds SlectBlock:^(NSInteger year,NSInteger moth, NSInteger day) {
                
                if ([weakSelf compareOneDay:[NSString stringWithFormat:@"%ld-%ld-%ld",year,moth,day] withAnotherDay:weakSelf.other_info.start_date]<=0) {
                    [weakSelf showHint:@"结束日期早于出发日期"];
                }else{
                    weakSelf.other_info.end_date=[NSString stringWithFormat:@"%ld-%ld-%ld",year,moth,day];
                    [weakSelf calculPrice];
                }
                [weakSelf.tableview reloadData];
            }];
            clender.minDate=[NSDate date];
            [self.view addSubview:clender];
        }else
        {
            return;
        }
    }
    
}

//开启和关闭编辑模式，默认可编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return NO;
    }
    return YES;
}

//开启或关闭移动功能
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return NO;
    }
    return YES;
}

//设置编辑的方式(删除或插入)
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return UITableViewCellEditingStyleNone;
    }
    return UITableViewCellEditingStyleDelete;
}

//监听编辑按钮的事件回调方法
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //根据传入的编辑模式
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_userList removeObjectAtIndex:indexPath.row];
        [self.tableview deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimation)UITableViewRowAnimationFade];
    }
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
-(UIView*)secondHeaderView{
    UIView *view=[[UIView alloc]init];
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectZero];
    lable.font=[UIFont systemFontOfSize:13];
    lable.text=@"投保人信息";
    QMUIGhostButton *button=[[QMUIGhostButton alloc]initWithFrame:CGRectZero];
    [button setTitle:@"添加投保人" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    button.titleLabel.font = UIFontMake(13);
    button.contentEdgeInsets = UIEdgeInsetsMake(3, 8, 3, 8);
    [view addSubview:lable];
    [view addSubview:button];
    button.ghostColor = MAINCOLOR;
    
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left).offset(8);
        make.centerY.mas_equalTo(view.mas_centerY);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(view.mas_right).offset(-16);
        make.centerY.mas_equalTo(view.mas_centerY);
        //make.width.mas_equalTo(70);
        //make.height.mas_equalTo(35);
    }];
    [button addTarget:self action:@selector(addPerson) forControlEvents:UIControlEventTouchUpInside];
    return view;
    
}
-(void)addPerson{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"填写投保人信息" message:@"可添加多个投保人" preferredStyle:UIAlertControllerStyleAlert];
    //增加确定按钮；
    DefineWeakSelf;
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取第1个输入框；
        UITextField *userNameTextField = alertController.textFields.firstObject;
   
        UITextField *personid=alertController.textFields[1];
      
        UITextField *phone=alertController.textFields[2];
      

        if (userNameTextField.text.length>0 && personid.text.length>0 &&phone.text.length>0&&[NSString accurateVerifyIDCardNumber:personid.text]) {
            //dosomething
            User *u=[[User alloc]init];
            u.name=userNameTextField.text;
            u.doc_no=personid.text;
            u.mobile=phone.text;
            [weakSelf.userList addObject:u];
            [weakSelf.tableview reloadData];
        }else
        {
            [self showHint:@"信息不完整!"];
            
        }

    }]];
    
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    
    //定义第一个输入框；
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
      
            textField.placeholder = @"投保人名称";

    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
         textField.placeholder = @"投保人身份证号码";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"投保人手机号码";
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    
    
    
    [self presentViewController:alertController animated:true completion:nil];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (NSInteger)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay
{
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateA = [dateFormatter dateFromString:oneDay];
    NSDate *dateB = [dateFormatter dateFromString:anotherDay];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}

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
