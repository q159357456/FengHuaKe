//
//  GuidBlogViewController.m
//  FengHuaKe
//
//  Created by chenheng on 2019/6/14.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "GuidBlogViewController.h"
#import "GuidApplyTxtInputView.h"
#import "GuidApplyBoolChoiceView.h"
#import "GuidApplyAddPicView.h"
#import "GuiApplyClickChoiceView.h"
#import "DatePickerView.h"
#import "GuidModel.h"
//#import "GuidModel.h"
@interface GuidBlogViewController ()
@property(nonatomic,strong)GuidApplyTxtInputView * name;
@property(nonatomic,strong)GuidApplyBoolChoiceView * sex;
@property(nonatomic,strong)GuiApplyClickChoiceView * birthday;
@property(nonatomic,strong)GuidApplyTxtInputView * education;
@property(nonatomic,strong)GuidApplyTxtInputView * licenceCode;
@property(nonatomic,strong)GuidApplyAddPicView * licencePic;
@property(nonatomic,strong)GuidApplyAddPicView * guidPic1;
@property(nonatomic,strong)GuidApplyAddPicView * guidPic2;
@property(nonatomic,strong)GuidModel * guidModel;
@end

@implementation GuidBlogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    //判断是不是已经是导游
    NSDictionary *dic = @{@"para1":UniqUserID,@"para2":MEMBERTYPE};
        NSLog(@"dic===>%@",dic);
    DefineWeakSelf;
    [SVProgressHUD showWithStatus:@"加载中.."];
    [DataProcess requestDataWithURL:Guide_Verify RequestStr:GETRequestStr(nil, dic, nil, nil, nil) Result:^(id obj, id erro) {
        [SVProgressHUD dismiss];
                NSLog(@"判断结果===>%@",obj);
                NSLog(@"erro===>%@",erro);
        switch (ReturnState) {
            case -1:
            {
            //还不是导游
                [weakSelf initSubViews];
            }
                break;
            case 0:
            {
                //导游审核中
            }
                break;
            case 1:
            {
                //是导游
            }
                break;
            case 2:
            {
                //导游驳回
            }
                break;
                
            default:
                break;
        }
        
    }];
    
    //拉取导游信息
    
    //上传导导游信息
    // Do any additional setup after loading the view.
}
-(void)initSubViews{
    
    UIScrollView *scro = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scro];
    //姓名
    GuidApplyTxtInputView * name = [[GuidApplyTxtInputView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40))];
    name.label.text = @"姓名";
    self.name = name;
    //性别
    GuidApplyBoolChoiceView * sex = [[GuidApplyBoolChoiceView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(name.frame), ScreenWidth, WIDTH_PRO(40))];
    sex.label.text = @"性别";
    self.sex = sex;
    //出生年月
    GuiApplyClickChoiceView * birthday = [[GuiApplyClickChoiceView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(sex.frame) , ScreenWidth, WIDTH_PRO(40))];
    birthday.label.text = @"出生年月";
    birthday.tag = 1;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseBirthDay:)];
    birthday.clickLabel.userInteractionEnabled = YES;
    [birthday addGestureRecognizer:tap];
    self.birthday = birthday;
    //学历
    GuidApplyTxtInputView * education = [[GuidApplyTxtInputView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(birthday.frame), ScreenWidth, WIDTH_PRO(40))];
     education.label.text = @"学历";
    self.education = education;
    //身份证号码
     GuidApplyTxtInputView * licenceCode = [[GuidApplyTxtInputView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(education.frame), ScreenWidth, WIDTH_PRO(40))];
    self.licenceCode = licenceCode;
    licenceCode.label.text = @"身份证号码";
    //身份证正反面
    GuidApplyAddPicView * licencePic = [[GuidApplyAddPicView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(licenceCode.frame), ScreenWidth, WIDTH_PRO(80)) Num:2];
    licencePic.label.text = @"身份证正反面";
    self.licencePic = licencePic;
//    //导游证正面
    GuidApplyAddPicView * guidPic1 = [[GuidApplyAddPicView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(licencePic.frame), ScreenWidth, WIDTH_PRO(80)) Num:1];
    guidPic1.label.text = @"导游证正面";
    self.guidPic1 = guidPic1;
//    //毕业证
     GuidApplyAddPicView * guidPic2 = [[GuidApplyAddPicView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(guidPic1.frame), ScreenWidth, WIDTH_PRO(100)) Num:1];
    guidPic2.label.text = @"毕业证";
    self.guidPic2 = guidPic2;
    
    UIButton * btn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    btn.frame = CGRectMake(ScreenWidth/2 - WIDTH_PRO(180)/2, CGRectGetMaxY(guidPic2.frame)+50, WIDTH_PRO(180), 50);
    btn.layer.cornerRadius = 8;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = MainColor;
    [btn addTarget:self action:@selector(upLoadGuidInfo) forControlEvents:UIControlEventTouchUpInside];

    [scro addSubview:name];
    [scro addSubview:sex];
    [scro addSubview:birthday];
    [scro addSubview:education];
    [scro addSubview:licenceCode];
    [scro addSubview:licencePic];
    [scro addSubview:guidPic1];
    [scro addSubview:guidPic2];
    [scro addSubview:btn];
    [scro setContentSize:CGSizeMake(ScreenWidth, CGRectGetMaxY(guidPic2.frame))];
    
}
#pragma mark - action
-(void)chooseBirthDay:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
    MJWeakSelf;
    [DatePickerView showDatePickerCallBack:^(NSDate * _Nonnull date) {
        NSLog(@"date==>%@",date);
        GuiApplyClickChoiceView * birthday = (GuiApplyClickChoiceView*)[weakSelf.view viewWithTag:1];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *strDate = [dateFormatter stringFromDate:date];
        birthday.clickLabel.text = strDate;
    }];
    
}

//上传
-(void)upLoadGuidInfo{
//    [SVProgressHUD setMaximumDismissTimeInterval:1];
//    NSLog(@"self.name===> %@",[self.name outPutTxt]);
    if (self.name.outPutTxt.length== 0 ) {
        [SVProgressHUD showErrorWithStatus:@"名字必须填写"];
        return;
    }
    if (self.licencePic.imageArray.count!=2) {
        [SVProgressHUD showErrorWithStatus:@"身份证必须上传"];
        return;
    }
    if (self.guidPic1.imageArray.count != 1 ) {
        [SVProgressHUD showErrorWithStatus:@"导游证必须上传"];
        return;
    }
    
    self.guidModel = [[GuidModel alloc]init];
    self.guidModel.age = 0;
    self.guidModel.memberid = UniqUserID;
    self.guidModel.membertype = MEMBERTYPE;
    self.guidModel.name = self.name.outPutTxt;
    self.guidModel.sex = self.sex.value;
    self.guidModel.birthdate = [self.birthday.clickLabel.text  isEqual: @"请选择生日"] ? @"":self.birthday.clickLabel.text;
    self.guidModel.education = self.education.outPutTxt;
    self.guidModel.id_type = @"身份证";
    self.guidModel.id_num = self.licenceCode.outPutTxt;
    UIImage  * image1 = self.licencePic.imageArray[0];
    UIImage  * image2 = self.licencePic.imageArray[1];
    self.guidModel.id_card_1 = [UIImagePNGRepresentation(image1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    self.guidModel.id_card_2 = [UIImagePNGRepresentation(image2) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    UIImage  * image3 = self.guidPic1.imageArray[0];
    self.guidModel.guide_card = [UIImagePNGRepresentation(image3) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    if (self.guidPic2.imageArray.count>0) {
        UIImage  * image4 = self.guidPic2.imageArray[0];
        self.guidModel.education_card = [UIImagePNGRepresentation(image4) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }else
    {
        self.guidModel.education_card = @"";
    }
//     NSLog(@"===>%@",self.guidModel.education_card);
//     NSLog(@"===>%@",self.guidModel.guide_card);
//     NSLog(@"===>%@",self.guidModel.id_card_1);
//     NSLog(@"===>%@",self.guidModel.id_card_2);
////     self.guidModel.education_card = @"";
//     self.guidModel.guide_card = @"";
//     self.guidModel.id_card_1 = @"";
//     self.guidModel.id_card_2 = @"";
//    NSLog(@"%@",self.guidModel.id_card_1);
//    NSLog(@"%@",self.guidModel.id_card_2);
    self.guidModel.id_num = @"513436200006129153";
//    self.guidModel.id_card_1 = @"";
//    self.guidModel.id_card_2 = @"";
//    self.guidModel.guide_card = @"";
    NSDictionary * paramsDic = [self.guidModel mj_keyValuesWithIgnoredKeys:@[@"statu",@"applydate",@"auditdate",@"fansnums",@"likenums",@"focusnums",@"collectnums"]];
    NSDictionary * sysmodel = @{@"blresult":@"false",@"para1":@"png",@"para2":@"png",@"para3":@"png",@"para4":@"png"};
    [SVProgressHUD showWithStatus:@"加载中"];
//    NSLog(@"参数==>%@",GETRequestStr(@[paramsDic], sysmodel, nil, nil, nil));
//    NSString *temp = @"";
    [DataProcess requestDataWithURL:Guide_ApplyGuide RequestStr: GETRequestStr(@[paramsDic], sysmodel, nil, nil, nil) Result:^(id obj, id erro) {
        [SVProgressHUD dismiss];
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
