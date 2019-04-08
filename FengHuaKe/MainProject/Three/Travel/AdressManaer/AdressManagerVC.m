//
//  AdressManagerVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/14.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "AdressManagerVC.h"
#import "AdressManagerInputCell.h"
#import "AdressManagerData.h"
#import "AreaView.h"
#import "AreaModel.h"
#import "AdressManagerChosenCell.h"
#import "AdressManagerDefaultCell.h"
#import "AdressManagerTextCell.h"
#import "UIViewController+HUD.h"
#import "UITextView+PlaceHolder.m"
@interface AdressManagerVC ()<UITableViewDelegate,UITableViewDataSource,AreaViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)NSArray *cellidArray;
@property(nonatomic,strong)AreaView *areaView;
//参数
@property(nonatomic,copy)NSString *MemberNo;
@property(nonatomic,copy)NSString *Contact;
@property(nonatomic,copy)NSString *Mobile;
@property(nonatomic,copy)NSString *Tips;
@property(nonatomic,copy)NSString *ProvinceCode;
@property(nonatomic,copy)NSString *Province;
@property(nonatomic,copy)NSString *CityCode;
@property(nonatomic,copy)NSString *City;
@property(nonatomic,copy)NSString *DistrictCode;
@property(nonatomic,copy)NSString *District;
@property(nonatomic,copy)NSString *Address;
@property(nonatomic,assign)BOOL DefaultAddr;
@property(nonatomic,copy)NSString *Code;

@end

@implementation AdressManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"地址管理";
    self.titleArray=@[@"收货人",@"联系电话",@"标签",@"所在地区",@"",@"设为默认地址"];
    self.cellidArray=@[@"AdressManagerInputCell",@"AdressManagerInputCell",@"AdressManagerInputCell",@"AdressManagerChosenCell",@"AdressManagerTextCell",@"AdressManagerDefaultCell"];
    [self.view addSubview:self.tableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    if (self.model) {
        [self updateWith:self.model];
    }else
    {
         self.DefaultAddr=NO;
    }
    // Do any additional setup after loading the view.
}
-(void)updateWith:(AdressListModel*)model
{
    self.Contact=model.Contact;
    self.Mobile=model.Mobile;
    self.Address=model.Address;
    self.Code=model.Code;
    self.DefaultAddr=[model.DefaultAddr boolValue];
    self.Province=model.Province;
    self.City=model.City;
    self.District=model.District;
    self.ProvinceCode=model.DistrictCode;
    self.CityCode=model.CityCode;
    self.DistrictCode=model.DistrictCode;
    self.Tips=model.Tips;
    
}
- (void) keyboardWillHide:(NSNotification *)notify {
    AdressManagerTextCell *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    self.Address=cell.textView.text;
}
#pragma mark - get
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    
            UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
            _tableView.tableFooterView = footView;
            UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, ScreenWidth-40, 40)];
            addButton.backgroundColor = MainColor;
            [addButton rounded:3];
            if (self.model)
            {
                [addButton setTitle:@"修改地址" forState:UIControlStateNormal];
                
            }else
            {
                [addButton setTitle:@"新增地址" forState:UIControlStateNormal];
            }
            
            [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [addButton addTarget:self action:@selector(aadressFunc) forControlEvents:UIControlEventTouchUpInside];
            [footView addSubview:addButton];
            _tableView.tableFooterView=footView;


        
    }
    return _tableView;
}
-(AreaView *)areaView
{
    if (!_areaView) {
        _areaView=[[AreaView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        UIWindow *keywindow=[UIApplication sharedApplication].keyWindow;
        [keywindow addSubview:_areaView];
        _areaView.delegate=self;
    }
    return _areaView;
}
#pragma mark - AreaViewDelegate
-(void)didChosenProvince:(AreaModel *)proModel City:(AreaModel *)cityModel District:(AreaModel *)disModel
{
    self.Province=proModel.name;
    self.ProvinceCode=proModel.code;
    self.City=cityModel.name;
    self.CityCode=cityModel.code;
    self.District=disModel.name;
    self.DistrictCode=disModel.code;
    [self.tableView reloadData];
    
   
}

#pragma mark -UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 100:
        {
            self.Contact=textField.text;
        }
            break;
        case 101:
        {
            self.Mobile=textField.text;
        }
            break;
        case 102:
        {
            self.Tips=textField.text;
        }
            break;

    }
}

#pragma mark - action
-(void)aadressFunc
{
    [self.view endEditing:YES];
    if (self.model)
    {
        
        if (!(self.Contact.length>0&&self.Mobile.length>0&&self.Tips.length>0&&self.ProvinceCode.length>0&&self.Address.length>0)) {
            [self showHint:@"请填写完整资料"];
            return;
        }
        //修改
        NSArray *datalidt=@[@{@"MemberNo":UniqUserID,@"Contact":self.Contact,@"Mobile":self.Mobile,@"Tips":self.Tips,@"ProvinceCode":self.ProvinceCode,@"Province":self.Province,@"CityCode":self.CityCode,@"City":self.City,@"DistrictCode":self.DistrictCode,@"District":self.District,@"Address":self.Address,@"DefaultAddr":[NSNumber numberWithBool:self.DefaultAddr],@"Code":self.Code}];
        DefineWeakSelf;
           [self showHudInView:self.view hint:@""];
        [AdressManagerData AddressEditorDatalist:[DataProcess getJsonStrWithObj:datalidt] Success:^(id responseData) {
            [self hideHud];
            NSDictionary *dic=(NSDictionary*)responseData;
            if ([dic[@"sysmodel"][@"blresult"] intValue])
            {
                [weakSelf showHint:@"修改成功!"];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else
            {
                [weakSelf showHint:dic[@"sysmodel"][@"strresult"]];
            }
            
        } Fail:^(id erro) {
            
        }];
    }else
    {
        if (!(self.Contact.length>0&&self.Mobile.length>0&&self.Tips.length>0&&self.ProvinceCode.length>0&&self.Address.length>0)) {
            [self showHint:@"请填写完整资料"];
            return;
        }
        //新增
        NSArray *datalidt=@[@{@"MemberNo":UniqUserID,@"Contact":self.Contact,@"Mobile":self.Mobile,@"Tips":self.Tips,@"ProvinceCode":self.ProvinceCode,@"Province":self.Province,@"CityCode":self.CityCode,@"City":self.City,@"DistrictCode":self.DistrictCode,@"District":self.District,@"Address":self.Address,@"DefaultAddr":[NSNumber numberWithBool:self.DefaultAddr]}];
        DefineWeakSelf;
           [self showHudInView:self.view hint:@""];
        [AdressManagerData AddressAddDatalist:[DataProcess getJsonStrWithObj:datalidt] Success:^(id responseData) {
            [self hideHud];
            NSDictionary *dic=(NSDictionary*)responseData;
            if ([dic[@"sysmodel"][@"blresult"] intValue])
            {
                 [weakSelf showHint:@"添加成功!"];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else
            {
                [weakSelf showHint:dic[@"sysmodel"][@"strresult"]];
            }
            
        } Fail:^(id erro) {
            
        }];
    }
    
}

#pragma mark - table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AdressManagerBaseCell *cell=[tableView cellForRowAtIndexPath:indexPath] ;
    if (!cell) {
        Class class=NSClassFromString(_cellidArray[indexPath.row]);
        cell=[[class alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_cellidArray[indexPath.row]];
    }
    cell.lable.text=_titleArray[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if ([_cellidArray[indexPath.row] isEqualToString:@"AdressManagerInputCell"]) {
        AdressManagerInputCell *acell=(AdressManagerInputCell*)cell;
        acell.inputTextField.tag=indexPath.row+100;
        acell.inputTextField.delegate=self;
        acell.inputTextField.textAlignment = NSTextAlignmentRight;
        if (indexPath.row==1) {
            acell.inputTextField.keyboardType = UIKeyboardTypeNumberPad;
        }
        [self getCellData:acell Path:indexPath];
    }
    
    if ([_cellidArray[indexPath.row] isEqualToString:@"AdressManagerChosenCell"]) {
         AdressManagerChosenCell *acell=(AdressManagerChosenCell*)cell;
        acell.adressLbale.text=self.Province.length?[NSString stringWithFormat:@"%@%@%@",self.Province,self.City,self.District]:@"请选择地址";
    }
    if ([_cellidArray[indexPath.row] isEqualToString:@"AdressManagerTextCell"]) {
         AdressManagerTextCell *acell=(AdressManagerTextCell*)cell;
         acell.textView.text=self.Address;
        if (acell.textView.text.length==0) {
            [acell.textView addPlaceHolder:@"填写详细地址"];
        }
        
    }
    if ([_cellidArray[indexPath.row] isEqualToString:@"AdressManagerDefaultCell"]) {
         AdressManagerDefaultCell *acell=(AdressManagerDefaultCell*)cell;
        if (!self.DefaultAddr) {
            acell.sleImageView.image=[UIImage imageNamed:@"slected_1"];
        }else
        {
            acell.sleImageView.image=[UIImage imageNamed:@"slected_2"];
        }
    }
    return cell;
}
-(void)getCellData:(AdressManagerInputCell*)cell Path:(NSIndexPath*)path
{
    switch (path.row) {
        case 0:
        {
            cell.inputTextField.text=self.Contact;
        }
            break;
        case 1:
        {
            cell.inputTextField.text=self.Mobile;
        }
            break;
        case 2:
        {
            cell.inputTextField.text=self.Tips;
        }
            break;
            
   
    }


}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *cellClass=_cellidArray[indexPath.row];
    if ([cellClass isEqualToString:@"AdressManagerInputCell"]) {
        return 44;
    }else if ([cellClass isEqualToString:@"AdressManagerChosenCell"])
    {
        return 44;
    }else if ([cellClass isEqualToString:@"AdressManagerDefaultCell"])
    {
        return 44;
    }else if ([cellClass isEqualToString:@"AdressManagerTextCell"])
    {
        return 88;
    }
    return 0;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellClass=_cellidArray[indexPath.row];
     if ([cellClass isEqualToString:@"AdressManagerChosenCell"])
     {
       
         [self.areaView showAreaView];
     }
    if ([cellClass isEqualToString:@"AdressManagerDefaultCell"])
    {
        
        self.DefaultAddr=!self.DefaultAddr;
        [self.tableView reloadData];
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
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

@end
