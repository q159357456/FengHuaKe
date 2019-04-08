//
//  RegistrViewController.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "RegistrViewController.h"
#import "LoginManagerVM.h"
@interface RegistrViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nikeNameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNoField;
@property (weak, nonatomic) IBOutlet UITextField *passField;
@property (weak, nonatomic) IBOutlet UITextField *verityField;
@property(nonatomic,copy)NSString *vertiyCode;
@end

@implementation RegistrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)getcode:(UIButton *)sender {
    if (_phoneNoField.text>0)
    {
        DefineWeakSelf;
        [LoginManagerVM SendMobileCodeWithPara1:@"M" Para2:_phoneNoField.text Success:^(id responseData) {
            NSLog(@"%@",responseData);
            NSString *str=(NSString*)responseData;
            //NSArray *strArray=[str componentsSeparatedByString:@","];
            if ([str isEqualToString:@"OK"]) {
                weakSelf.vertiyCode=str;
                NSLog(@"%@",weakSelf.vertiyCode);
            } else
            {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"获取验证码失败"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        } Fail:^(id erro) {
            NSLog(@"eero--%@",erro);
            
        }];
    }else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"手机号码不能为空"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }

    
}
- (IBAction)register:(UIButton *)sender {
    
    if(_passField.text.length>0&&_nikeNameField.text.length>0&&_phoneNoField.text.length>0&&self.vertiyCode.length>0)
    {
        NSArray *dataList=@[@{@"MS004":_passField.text,@"MS002":_nikeNameField.text,@"MS008":_phoneNoField.text}];
        [LoginManagerVM RegisterMemberRegWithPara1:_verityField.text DataList:dataList Success:^(id responseData) {
            NSDictionary *dic=responseData;
            NSLog(@"注册:%@",dic);
            if([dic[@"sysmodel"][@"blresult"] intValue])
            {
                //注册成功
                [self.navigationController popViewControllerAnimated:YES];
        
            }else
            {
                //注册失败
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                                message:dic[@"sysmodel"][@" strresult"]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                
            }
                
        } Fail:^(id erro) {
            
        }];
    
    }else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"必填资料不能为空"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
