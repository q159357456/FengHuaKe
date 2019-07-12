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
#import "AlreadyApplyController.h"


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
                 self.guidModel = [GuidModel mj_objectWithKeyValues:ReturnDataList[0]];
                 [weakSelf initSubViews];
//               [ weakSelf addAlreadyChildController];
                
            }
                break;
            case 1:
            {
                //是导游
//                 [weakSelf initSubViews];
//                [weakSelf addAlreadyChildController];
                self.guidModel = [GuidModel mj_objectWithKeyValues:ReturnDataList[0]];
                [weakSelf initSubViews];
            }
                break;
            case 2:
            {
                //导游驳回travelCustomization
                 [weakSelf initSubViews];
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"导游被驳回,请重新填写"
                                                               delegate:nil
                                                      cancelButtonTitle:@"关闭"
                                                      otherButtonTitles:nil];
                 [alert show];
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
-(void)addAlreadyChildController{
    AlreadyApplyController * vc = [[AlreadyApplyController alloc]init];
    vc.view.frame = self.view.bounds;
    [self.view addSubview:vc.view];
    [self addChildViewController:vc];
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
    
    if (self.guidModel) {
        self.name.textfield.text = self.guidModel.name;
        self.sex.value = self.guidModel.sex;
        self.birthday.clickLabel.text = self.guidModel.birthdate;
        self.education.textfield.text = self.guidModel.education;
        self.licenceCode.textfield.text = self.guidModel.id_num;
//        NSLog(@"id_card_1===>%@",self.guidModel.id_card_1);
        if (self.guidModel.id_card_1.length && self.guidModel.id_card_2.length) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSURL *url1 = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,self.guidModel.id_card_1]];
                NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,self.guidModel.id_card_2]];
                NSData *data1 = [NSData dataWithContentsOfURL:url1];
                NSData *data2 = [NSData dataWithContentsOfURL:url2];
                UIImage * image1 = [UIImage imageWithData:data1];
                UIImage * image2 = [UIImage imageWithData:data2];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                      self.licencePic.imageArray = [@[image1,image2] mutableCopy];
                });
            });
          
        }
        if (self.guidModel.guide_card.length) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSURL *url1 = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,self.guidModel.guide_card]];
                NSData *data1 = [NSData dataWithContentsOfURL:url1];
                UIImage * image1 = [UIImage imageWithData:data1];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.guidPic1.imageArray = [@[image1] mutableCopy];
                });
            });
       
            
        }
        
        if (self.guidModel.education_card.length) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSURL *url1 = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,self.guidModel.education_card]];
                NSData *data1 = [NSData dataWithContentsOfURL:url1];
                UIImage * image1 = [UIImage imageWithData:data1];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.guidPic2.imageArray = [@[image1] mutableCopy];
                });
            });
        }
    }
    
}
#pragma mark - action
-(void)chooseBirthDay:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
    MJWeakSelf;
    [DatePickerView showDatePickerCallBack:^(NSDate * _Nonnull date) {
        GuiApplyClickChoiceView * birthday = (GuiApplyClickChoiceView*)[weakSelf.view viewWithTag:1];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *strDate = [dateFormatter stringFromDate:date];
        birthday.clickLabel.text = strDate;
    }];
    
}

//上传
-(void)upLoadGuidInfo{

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
    
    GuidModel * guidModel = [[GuidModel alloc]init];
    guidModel.age = 0;
    guidModel.memberid = UniqUserID;
    guidModel.membertype = MEMBERTYPE;
    guidModel.name = self.name.outPutTxt;
    guidModel.sex = self.sex.value;
    guidModel.birthdate = [self.birthday.clickLabel.text  isEqual: @"请选择生日"] ? @"":self.birthday.clickLabel.text;
    guidModel.education = self.education.outPutTxt;
    guidModel.id_type = @"身份证";
    guidModel.id_num = self.licenceCode.outPutTxt;
    UIImage  * image1 = self.licencePic.imageArray[0];
    UIImage  * image2 = self.licencePic.imageArray[1];
    guidModel.id_card_1 = [UIImageJPEGRepresentation(image1,0.1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    guidModel.id_card_2 = [UIImageJPEGRepresentation(image2,0.1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    UIImage  * image3 = self.guidPic1.imageArray[0];
    guidModel.guide_card = [UIImageJPEGRepresentation(image3,0.1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    if (self.guidPic2.imageArray.count>0) {
        UIImage  * image4 = self.guidPic2.imageArray[0];
        guidModel.education_card = [UIImageJPEGRepresentation(image4,0.1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
    }else
    {
        guidModel.education_card = @"";
    }
    NSDictionary * paramsDic = [guidModel mj_keyValuesWithIgnoredKeys:@[@"statu",@"applydate",@"auditdate",@"fansnums",@"likenums",@"focusnums",@"collectnums"]];
    NSDictionary * sysmodel = @{@"blresult":self.guidModel?@"true":@"false",@"para1":@"jpg",@"para2":@"jpg",@"para3":@"jpg",@"para4":@"jpg"};
    [SVProgressHUD showWithStatus:@"加载中"];
    NSString  * requestStr = GETRequestStr(@[paramsDic], sysmodel, nil, nil, nil);
    requestStr = [requestStr stringByReplacingOccurrencesOfString:@"rn" withString:@""];
    [DataProcess requestDataWithURL:Guide_ApplyGuide RequestStr: requestStr Result:^(id obj, id erro) {
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
-(NSString*)textStr{
   
    NSString * temp = [[NSBundle mainBundle] pathForResource:@"base64Test" ofType:@"txt"];
    NSString * re = [[NSString alloc]initWithContentsOfFile:temp encoding:NSUTF8StringEncoding error:nil];
    return re;
  
}
-(void)textCeatImage:(NSString*)base64{
        NSData *data = [[NSData alloc]initWithBase64EncodedString:base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage * image = [[UIImage alloc]initWithData:data];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        imageView.image = image;
        [self.view addSubview:imageView];
}
@end
