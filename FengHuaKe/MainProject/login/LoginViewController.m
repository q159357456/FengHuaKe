//
//  LoginViewController.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/10.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "LoginViewController.h"
#import <Hyphenate/Hyphenate.h>
#import "EaseUI.h"
#import "RegistrViewController.h"
#import "LoginManagerVM.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *passField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"登录/注册";
    _loginButton.backgroundColor=MainColor;
    [_loginButton rounded:4];
    [_registerButton rounded:4 width:1 color:[UIColor lightGrayColor]];

    _passField.secureTextEntry = YES;
    
}
- (IBAction)registrUser:(UIButton *)sender {
    RegistrViewController *regi=[[RegistrViewController alloc]init];
    regi.title=@"注册";
    [self.navigationController pushViewController:regi animated:YES];
    
}

//判断账号密码
-(BOOL)isEmpety
{
    NSString *username = _userField.text;
    NSString *password = _passField.text;
    if (username.length == 0 || password.length == 0) {
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"登陆信息" message:@"账号密码为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alert show];
        [SVProgressHUD showErrorWithStatus:@"账号或密码为空"];
        return NO;
    }else
    {
        return YES;
    }
    
}
- (IBAction)login:(UIButton *)sender {
    //先登录自己服务器的接口，通过后再加载环信登录接口
    if (![self isEmpety]) {
        return;
    }
    [self.view endEditing:YES];
    
    [self myseverLoginWithUsername:_userField.text password:_passField.text];
    
}
//自己服务器登录
-(void)myseverLoginWithUsername:(NSString *)username password:(NSString *)password
{
    [self showHudInView:self.view hint:@"正在登录..."];
    DefineWeakSelf;
    [LoginManagerVM LoginMemberWithPara1:username Para2:password Success:^(id responseData) {
        //储存token值
        NSDictionary *dic=responseData;
//        NSLog(@"储存token值==>%@",dic);
//        NSLog(@"token:%@",dic[@"DataList"][0][@"token"]);
        if ([dic[@"sysmodel"][@"blresult"] intValue]) {
            [self hideHud];
            NSArray * temp = dic[@"DataList"];
            if (temp.count) {
                NSDictionary *userdict = dic[@"DataList"][0][@"shopinfo"];
                NSMutableDictionary *iconDict = [HttpTool takeOffNullWithDict:userdict];\
                NSString * token = dic[@"DataList"][0][@"token"]? dic[@"DataList"][0][@"token"]:@"0";
                [userDefault setObject:token forKey:@"token"];
                [userDefault setObject:iconDict[@"MS001"] forKey:@"uniqUserID"];
                [userDefault setObject:iconDict[@"MS002"] forKey:@"usernikeName"];
                [userDefault setObject:iconDict[@"UDF06"] forKey:@"userIcon"];
                [userDefault synchronize];
                NSString *md5Pass=[DataProcess getMD5TextWithStr:password];
                [weakSelf loginWithUsername:iconDict[@"MS001"] password:md5Pass];
            }else
            {
                [self showHint:@"登录信息错误"];
            }
           
        }else
        {
            [self hideHud];
            [self showHint:dic[@"sysmodel"][@"strresult"]];
        }

       
    } Fail:^(id erro) {
        [self hideHud];
        [self showHint:@"Your network is unstable"];
    }];
}
//环信登录
- (void)loginWithUsername:(NSString *)username password:(NSString *)password
{
//    [self showHudInView:self.view hint:NSLocalizedString(@"login.ongoing", @"Is Login...")];
    //异步登陆账号
    __weak typeof(self) weakself = self;
    [self showHudInView:self.view hint:@"正在登录通讯功能..."];
    [[EMClient sharedClient]loginWithUsername:username password:password completion:^(NSString *aUsername, EMError *aError) {
        [weakself hideHud];
        if (!aError) {
            //设置是否自动登录
            [[EMClient sharedClient].options setIsAutoLogin:YES];
            //保存最近一次登录用户名
            [weakself saveLastLoginUsername];
            //发送自动登陆状态通知
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:[NSNumber numberWithBool:YES]];

        } else {
            switch (aError.code)
            {
                case EMErrorUserNotFound:
                    TTAlertNoTitle(NSLocalizedString(@"error.usernotExist", @"User not exist!"));
                    break;
                case EMErrorNetworkUnavailable:
                    TTAlertNoTitle(NSLocalizedString(@"error.connectNetworkFail", @"No network connection!"));
                    break;
                case EMErrorServerNotReachable:
                    TTAlertNoTitle(NSLocalizedString(@"error.connectServerFail", @"Connect to the server failed!"));
                    break;
                case EMErrorUserAuthenticationFailed:
                    TTAlertNoTitle(aError.errorDescription);
                    break;
                case EMErrorServerTimeout:
                    TTAlertNoTitle(NSLocalizedString(@"error.connectServerTimeout", @"Connect to the server timed out!"));
                    break;
                case EMErrorServerServingForbidden:
                    TTAlertNoTitle(NSLocalizedString(@"servingIsBanned", @"Serving is banned"));
                    break;
                case EMErrorUserLoginTooManyDevices:
                    TTAlertNoTitle(NSLocalizedString(@"alert.multi.tooManyDevices", @"Login too many devices"));
                    break;
                default:
                    TTAlertNoTitle(NSLocalizedString(@"login.fail", @"Login failure"));
                    break;
            }
        }

    }];
    
    /*dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] loginWithUsername:username password:password];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself hideHud];
            if (!error) {
                //设置是否自动登录
                [[EMClient sharedClient].options setIsAutoLogin:YES];
                
                //保存最近一次登录用户名
                [weakself saveLastLoginUsername];
                //发送自动登陆状态通知
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:[NSNumber numberWithBool:YES]];
                
            } else {
                switch (error.code)
                {
                    case EMErrorUserNotFound:
                        TTAlertNoTitle(NSLocalizedString(@"error.usernotExist", @"User not exist!"));
                        break;
                    case EMErrorNetworkUnavailable:
                        TTAlertNoTitle(NSLocalizedString(@"error.connectNetworkFail", @"No network connection!"));
                        break;
                    case EMErrorServerNotReachable:
                        TTAlertNoTitle(NSLocalizedString(@"error.connectServerFail", @"Connect to the server failed!"));
                        break;
                    case EMErrorUserAuthenticationFailed:
                        TTAlertNoTitle(error.errorDescription);
                        break;
                    case EMErrorServerTimeout:
                        TTAlertNoTitle(NSLocalizedString(@"error.connectServerTimeout", @"Connect to the server timed out!"));
                        break;
                    case EMErrorServerServingForbidden:
                        TTAlertNoTitle(NSLocalizedString(@"servingIsBanned", @"Serving is banned"));
                        break;
                    case EMErrorUserLoginTooManyDevices:
                        TTAlertNoTitle(NSLocalizedString(@"alert.multi.tooManyDevices", @"Login too many devices"));
                        break;
                    default:
                        TTAlertNoTitle(NSLocalizedString(@"login.fail", @"Login failure"));
                        break;
                }
            }
        });
    });*/
}
#pragma  mark - private

- (void)saveLastLoginUsername
{
    NSString *username = [[EMClient sharedClient] currentUsername];
    if (username && username.length > 0) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:username forKey:[NSString stringWithFormat:@"em_lastLogin_username"]];
        [ud synchronize];
    }
}
void TTAlertNoTitle(NSString* message) {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
