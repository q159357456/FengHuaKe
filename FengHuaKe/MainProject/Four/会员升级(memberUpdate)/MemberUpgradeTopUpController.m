//
//  MemberUpgradeTopUpController.m
//  FengHuaKe
//
//  Created by chenheng on 2019/6/25.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "MemberUpgradeTopUpController.h"
#import "GuidApplyTxtInputView.h"
#import "GuidApplyBoolChoiceView.h"
#import "GuidApplyAddPicView.h"
#import "GuiApplyClickChoiceView.h"
#import "AreaView.h"
#import "AreaModel.h"
#import "AdressModel.h"
#import "ZWHOrderPayViewController.h"
#define NSLog(FORMAT, ...) fprintf(stderr, "%s:%zd\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String])
@interface MemberUpgradeTopUpController ()<AreaViewDelegate>
@property(nonatomic,strong)AreaView * areaView;
@property(nonatomic,strong)GuidApplyTxtInputView * name;
@property(nonatomic,strong)GuidApplyBoolChoiceView * sex;
@property(nonatomic,strong)GuidApplyTxtInputView * phoneNum;
@property(nonatomic,strong)GuidApplyTxtInputView * code;
@property(nonatomic,strong)GuidApplyTxtInputView * licence;
@property(nonatomic,strong)GuiApplyClickChoiceView * area;
@property(nonatomic,strong)GuidApplyAddPicView * licencePic1;
@property(nonatomic,strong)GuidApplyAddPicView * licencePic2;
@property(nonatomic,strong)AdressModel * adressModel;
@end

@implementation MemberUpgradeTopUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认信息";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initSubViews];
    
    // Do any additional setup after loading the view.
}
-(void)initSubViews{
    UIScrollView *scro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.height-50*MULPITLE)];
    [self.view addSubview:scro];
    //姓名
    GuidApplyTxtInputView * name = [[GuidApplyTxtInputView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40))];
    name.label.text = @"姓名";
    self.name = name;
    //性别
    GuidApplyBoolChoiceView * sex = [[GuidApplyBoolChoiceView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(name.frame), ScreenWidth, WIDTH_PRO(40))];
    sex.label.text = @"性别";
    self.sex = sex;
    //手机号码
    GuidApplyTxtInputView * phoneNum = [[GuidApplyTxtInputView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(sex.frame), ScreenWidth, WIDTH_PRO(40))];
    phoneNum.label.text = @"手机号码";
    self.phoneNum = phoneNum;
    //手机验证码
    GuidApplyTxtInputView * code = [[GuidApplyTxtInputView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(phoneNum.frame), ScreenWidth, WIDTH_PRO(40))];
    code.label.text = @"验证码";
    self.code = code;
    [code.textfield mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(code.mas_right).offset(-80);
    }];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送验证码" forState:UIControlStateNormal];
    btn.titleLabel.font = ZWHFont(12);
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [code addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(code.textfield.mas_right).offset(5);
        make.right.mas_equalTo(code.mas_right).offset(-10);
        make.centerY.mas_equalTo(code);
        make.height.mas_equalTo(24);
    }];
    [btn addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
    
    //身份证号码
    GuidApplyTxtInputView * licence = [[GuidApplyTxtInputView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(code.frame), ScreenWidth, WIDTH_PRO(40))];
    licence.label.text = @"身份证号码";
    self.licence = licence;
    //省市区
    GuiApplyClickChoiceView * area = [[GuiApplyClickChoiceView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(licence.frame), ScreenWidth, WIDTH_PRO(40))];
    area.clickLabel.text = @"";
    self.area = area;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseArea)];
    area.clickLabel.userInteractionEnabled = YES;
    [area addGestureRecognizer:tap];
    area.label.text = @"省市区";
    //身份证正面
    GuidApplyAddPicView * licencePic1 = [[GuidApplyAddPicView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(area.frame), ScreenWidth, WIDTH_PRO(80)) Num:1];
    licencePic1.label.text = @"身份证正面";
    self.licencePic1 = licencePic1;
    //身份证反面
    GuidApplyAddPicView * licencePic2 = [[GuidApplyAddPicView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(licencePic1.frame), ScreenWidth, WIDTH_PRO(80)) Num:1];
    licencePic2.label.text = @"身份证反面";
    self.licencePic2 = licencePic2;
    [scro addSubview:name];
    [scro addSubview:sex];
    [scro addSubview:phoneNum];
    [scro addSubview:code];
    [scro addSubview:licence];
    [scro addSubview:area];
    [scro addSubview:licencePic1];
    [scro addSubview:licencePic2];
    [scro setContentSize:CGSizeMake(ScreenWidth, CGRectGetMaxY(licencePic2.frame))];
    
    
    UIButton * topUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:topUpBtn];
    [topUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(50*MULPITLE);
    }];
    topUpBtn.backgroundColor = MainColor;
    [topUpBtn setTitle:@"确定充值" forState:UIControlStateNormal];
    [topUpBtn addTarget:self action:@selector(uploadInfo) forControlEvents:UIControlEventTouchUpInside];
}

//发送验证码
-(void)sendCode:(UIButton*)sender{
    sender.enabled = NO;
    NSLog(@"发送验证码");
    if (!(self.phoneNum.textfield.text.length>0&&[self.phoneNum.textfield.text isMobileNumberClassification]==YES)) {
        [self showHint:@"请输入正确的手机号"];
        return;
    }

//    MJWeakSelf;
    [self showEmptyViewWithLoading];
    [HttpHandler getSendMobileCode:@{@"para1":@"X",@"para2":self.phoneNum.textfield.text} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        [self hideEmptyView];
        if (ReturnValue==1) {
            [self showHint:@"发送成功"];
//            [weakSelf startWaitTime];
        }else{
            [self showHint:@"发送验证码失败"];
        }
    } failed:^(id obj) {
        [self hideEmptyView];
        [self showHint:@"发送验证码失败"];
    }];
}

//选择省市区
-(void)chooseArea{
    NSLog(@"选择省市区");
    [self.areaView showAreaView];
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
-(AdressModel *)adressModel
{
    if (!_adressModel) {
        _adressModel = [[AdressModel alloc]init];
    }
    return _adressModel;
}
#pragma mark - AreaViewDelegate
-(void)didChosenProvince:(AreaModel *)proModel City:(AreaModel *)cityModel District:(AreaModel *)disModel
{
    self.adressModel.Province=proModel.name;
    self.adressModel.ProvinceCode=proModel.code;
    self.adressModel.City=cityModel.name;
    self.adressModel.CityCode=cityModel.code;
    self.adressModel.District=disModel.name;
    self.adressModel.DistrictCode=disModel.code;
    self.area.clickLabel.text = [NSString stringWithFormat:@"%@%@%@",proModel.name,cityModel.name,disModel.name];
    
}

-(void)uploadInfo{
 
    if (self.code.outPutTxt.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请填写验证码"];
        return;
    }
    if (self.licence.outPutTxt==0) {
        [SVProgressHUD showErrorWithStatus:@"请填写身份证号码"];
        return;
    }
    if (self.licencePic1.imageArray.count == 0 ) {
        [SVProgressHUD showErrorWithStatus:@"请上传照片"];
        return;
    }
    if (self.licencePic2.imageArray.count == 0 ) {
        [SVProgressHUD showErrorWithStatus:@"请上传照片"];
        return;
    }
    if (self.adressModel.Province.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择地址"];
        return;
    }
    
    UIImage  * image1 = self.licencePic1.imageArray[0];
    UIImage  * image2 = self.licencePic2.imageArray[0];
    NSString * pic1 = [UIImageJPEGRepresentation(image1,0.1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString * pic2 = [UIImageJPEGRepresentation(image2,0.1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary *sysmodel = @{@"para1":self.code.outPutTxt,@"para2":@"jpg",@"para3":@"jpg"};
    NSArray * array = @[@{@"memberid":UniqUserID,@"membertype":MEMBERTYPE,@"memberlevel":self.value,@"idPhoto_1":pic1,@"idPhoto_2":pic2,@"idCard":self.licence.outPutTxt,@"mobile":self.phoneNum.outPutTxt,@"name":self.name.outPutTxt,@"sex":self.sex.value,@"provCode":self.adressModel.ProvinceCode,@"provName":self.adressModel.Province,@"cityCode":self.adressModel.CityCode,@"cityName":self.adressModel.City,@"boroCode":self.adressModel.DistrictCode,@"boroName":self.adressModel.District}];
    [SVProgressHUD showWithStatus:@"加载中"];
    NSString  * requestStr = GETRequestStr(array, sysmodel, nil, nil, nil);
    requestStr = [requestStr stringByReplacingOccurrencesOfString:@"rn" withString:@""];
    [DataProcess requestDataWithURL:MemberLevel_Apply RequestStr:requestStr Result:^(id obj, id erro) {
        [SVProgressHUD dismiss];
        NSLog(@"上传结果===>%@",obj);
        NSLog(@"wwwwerro===>%@",erro);
        if (!erro) {
            ServiceBaseModel * model = [ServiceBaseModel mj_objectWithKeyValues:obj];
            if (model.DataList.count) {
                [self preparePay:model];
                ZWHOrderPayViewController * vc = [[ZWHOrderPayViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                
            }else
            {
                 [SVProgressHUD showErrorWithStatus:model.msg];
            }
            
        }else
        {
            [SVProgressHUD showErrorWithStatus:erro[@"msg"]];
        }
        
    }];
    
}


//预支付接口
-(void)preparePay:(ServiceBaseModel*)model{
    DatalistBaseModel * datalist = model.DataList[0];
    datalist.MG001 = self.value;
    NSDictionary * sysmodel = @{@"para1":UniqUserID,@"para2":MEMBERTYPE,@"para3":datalist.MG001,@"para4":model.sysmodel.para1,@"para5":datalist.MBR000,@"para6":@"W"};
    [DataProcess requestDataWithURL:Pay_MemberLevel RequestStr:GETRequestStr(nil, sysmodel, nil, nil, nil) Result:^(id obj, id erro) {
        NSLog(@"上传结果===>%@",obj);
        NSLog(@"wwwwerro===>%@",erro);
        
    }];
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
