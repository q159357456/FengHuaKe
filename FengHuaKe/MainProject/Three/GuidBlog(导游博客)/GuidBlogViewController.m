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
//#import "GuidModel.h"
@interface GuidBlogViewController ()
//@property(nonatomic,strong)GuidModel * guidModel;
@end

@implementation GuidBlogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
    //判断是不是已经是导游
//    NSDictionary *dic = @{@"para1":UniqUserID,@"para2":MEMBERTYPE};
    //    NSLog(@"dic===>%@",dic);
//    DefineWeakSelf;
//    [DataProcess requestDataWithURL:Guide_Verify RequestStr:GETRequestStr(nil, dic, nil, nil, nil) Result:^(id obj, id erro) {
//                NSLog(@"obj===>%@",obj);
//                NSLog(@"erro===>%@",erro);
//        weakSelf.dataSource = [NSMutableArray arrayWithArray:[FootPtintSearchModel transformToModelList:ReturnDataList]];
//        [weakSelf.tableView reloadData];
        
//    }];
    
    //拉取导游信息
    
    //上传导导游信息
    // Do any additional setup after loading the view.
}
-(void)initSubViews{
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView *scro = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scro];
    //姓名
    GuidApplyTxtInputView * name = [[GuidApplyTxtInputView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40))];
    name.label.text = @"姓名";
    //性别
    GuidApplyBoolChoiceView * sex = [[GuidApplyBoolChoiceView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(name.frame), ScreenWidth, WIDTH_PRO(40))];
    sex.label.text = @"性别";
    //出生年月
    GuiApplyClickChoiceView * birthday = [[GuiApplyClickChoiceView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(sex.frame) , ScreenWidth, WIDTH_PRO(40))];
    birthday.label.text = @"出生年月";
    birthday.tag = 1;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseBirthDay:)];
    birthday.clickLabel.userInteractionEnabled = YES;
    [birthday addGestureRecognizer:tap];
    //学历
    GuidApplyTxtInputView * education = [[GuidApplyTxtInputView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(birthday.frame), ScreenWidth, WIDTH_PRO(40))];
     education.label.text = @"学历";
    //身份证号码
     GuidApplyTxtInputView * licenceCode = [[GuidApplyTxtInputView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(education.frame), ScreenWidth, WIDTH_PRO(40))];
    licenceCode.label.text = @"身份证号码";
    //身份证正反面
    GuidApplyAddPicView * licencePic = [[GuidApplyAddPicView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(licenceCode.frame), ScreenWidth, WIDTH_PRO(80)) Num:2];
    licencePic.label.text = @"身份证正反面";
//    //导游证正面
    GuidApplyAddPicView * guidPic1 = [[GuidApplyAddPicView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(licencePic.frame), ScreenWidth, WIDTH_PRO(80)) Num:1];
    guidPic1.label.text = @"导游证正面";
//    //毕业证
     GuidApplyAddPicView * guidPic2 = [[GuidApplyAddPicView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(guidPic1.frame), ScreenWidth, WIDTH_PRO(100)) Num:1];
    guidPic2.label.text = @"毕业证";
    

    [scro addSubview:name];
    [scro addSubview:sex];
    [scro addSubview:birthday];
    [scro addSubview:education];
    [scro addSubview:licenceCode];
    [scro addSubview:licencePic];
    [scro addSubview:guidPic1];
    [scro addSubview:guidPic2];
    
    [scro setContentSize:CGSizeMake(ScreenWidth, CGRectGetMaxY(guidPic2.frame))];
    
}
#pragma mark - action
-(void)chooseBirthDay:(UITapGestureRecognizer*)tap{
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
