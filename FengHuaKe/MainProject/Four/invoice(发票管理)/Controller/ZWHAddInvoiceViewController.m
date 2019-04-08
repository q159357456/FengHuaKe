//
//  ZWHAddInvoiceViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/7.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHAddInvoiceViewController.h"
#import "KJChangeUserInfoTableViewCell.h"
#import "ZWHTextViewTableViewCell.h"
#import "AreaView.h"

@interface ZWHAddInvoiceViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSArray *strArr;

@property(nonatomic,assign)BOOL isdefault;

/*填写资料*/
@property(nonatomic,copy)NSString *companyname;
@property(nonatomic,copy)NSString *taxid;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *bank;
@property(nonatomic,copy)NSString *account;
@property(nonatomic,copy)NSString *code;

@end

@implementation ZWHAddInvoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
}


-(void)setUI{
    _titleArr = @[@"公司名称",@"电话",@"注册地址",@"开户银行",@"银行号码",@"统一信征码"];
    if (_myModel) {
        _companyname = _myModel.companyname;
        _phone = _myModel.phone;
        _address = _myModel.address;
        _bank = _myModel.bank;
        _account = _myModel.account;
        _taxid = _myModel.taxid;
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"保存" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    [btn addTarget:self action:@selector(saveAdressWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-ZWHNavHeight-100) style:UITableViewStylePlain];
    [self.view addSubview:_tableview];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle = 0;
    [_tableview registerClass:[KJChangeUserInfoTableViewCell class] forCellReuseIdentifier:@"KJChangeUserInfoTableViewCell"];
}

#pragma mark - 保存
-(void)saveAdressWithBtn:(UIButton *)btn{
    [self.view endEditing:YES];
    if (_companyname.length > 0 && _phone.length > 0 && _address.length > 0 && _bank.length > 0 && _account.length > 0 && _taxid.length > 0 ) {
        NSLog(@"\n%@\n%@\n%@\n%@\n%@\n%@\n",_companyname,_phone,_address,_bank,_account,_taxid);
        MJWeakSelf
        if (_myModel) {
            [HttpHandler getInvoiceEdit:@{@"para1":UniqUserID,@"para2":userType,@"para3":_companyname,@"para4":_taxid,@"para5":_address,@"para6":_phone,@"para7":_bank,@"para8":_account,@"para9":_myModel.code} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
                if (ReturnValue==1) {
                    [self showHint:@"已保存"];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"invoiceRefresh" object:nil];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            } failed:^(id obj) {
                [self showHint:@"保存失败"];
            }];
        }else{
            [self showHudInView:self.view hint:@"正在添加..."];
            [HttpHandler getInvoiceAdd:@{@"para1":UniqUserID,@"para2":userType,@"para3":_companyname,@"para4":_taxid,@"para5":_address,@"para6":_phone,@"para7":_bank,@"para8":_account} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
                if (ReturnValue==1) {
                    [self showHint:@"已保存"];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"invoiceRefresh" object:nil];
                }
            } failed:^(id obj) {
                [self hideHud];
                [self showHint:@"保存失败"];
            }];
        }
        
    }else{
        [self showHint:@"请完善资料"];
    }
}

#pragma mark - tableviewdelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_PRO(45);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section==0?HEIGHT_PRO(10):0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section==0?HEIGHT_PRO(10):0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KJChangeUserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KJChangeUserInfoTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.isWidTitle = YES;
    cell.leftTitleStr = _titleArr[indexPath.row];
    if (indexPath.row == 1 || indexPath.row == 4 || indexPath.row == 5) {
        cell.contentTex.keyboardType = UIKeyboardTypeNumberPad;
    }
    MJWeakSelf
    switch (indexPath.row) {
        case 0:
            {
                cell.contentTex.text = _companyname;
                [cell didEndInput:^(NSString *input) {
                    NSLog(@"%@",input);
                    weakSelf.companyname = input;
                }];
            }
            break;
        case 1:
        {
            cell.contentTex.text = _phone;
            [cell didEndInput:^(NSString *input) {
                NSLog(@"%@",input);
                weakSelf.phone = input;
            }];
        }
            break;
        case 2:
        {
            cell.contentTex.text = _address;
            [cell didEndInput:^(NSString *input) {
                NSLog(@"%@",input);
                weakSelf.address = input;
            }];
        }
            break;
        case 3:
        {
            cell.contentTex.text = _bank;
            [cell didEndInput:^(NSString *input) {
                NSLog(@"%@",input);
                weakSelf.bank = input;
            }];
        }
            break;
        case 4:
        {
            cell.contentTex.text = _account;
            [cell didEndInput:^(NSString *input) {
                NSLog(@"%@",input);
                weakSelf.account = input;
            }];
        }
            break;
        case 5:
        {
            cell.contentTex.text = _taxid;
            [cell didEndInput:^(NSString *input) {
                NSLog(@"%@",input);
                weakSelf.taxid = input;
            }];
        }
            break;
        default:
            break;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}



#pragma mark - 设置为默认地址
-(void)setDefaultAdressWithBtn:(UIButton *)btn{
    _isdefault = !_isdefault;
    [self.tableview reloadData];
}





@end
