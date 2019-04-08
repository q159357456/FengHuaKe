//
//  AddGruopChartVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "AddGruopChartVC.h"
#import "UITextView+PlaceHolder.h"
#import "UIViewController+HUD.h"
#import "ContractManagerVC.h"
#import <Hyphenate/Hyphenate.h>
#define memberCount 200
@interface AddGruopChartVC ()
@property (weak, nonatomic) IBOutlet UIImageView *groupChartImage;
@property (weak, nonatomic) IBOutlet UITextField *groupChartName;
@property (weak, nonatomic) IBOutlet UITextView *groupDescrib;
@property(nonatomic,strong)NSMutableArray *invitArray;
@property (weak, nonatomic) IBOutlet UISwitch *publicSwich;
@property (weak, nonatomic) IBOutlet UISwitch *memberOnly;

@end

@implementation AddGruopChartVC

- (void)viewDidLoad {
    [super viewDidLoad];

    //默认非公开
    _publicSwich.on=NO;
    _memberOnly.on=YES;
    [self.groupDescrib border:1 color:[UIColor lightGrayColor]];
    self.groupChartName.placeholder=@"请填写群名(2-10个字)";
    [self.groupDescrib addPlaceHolder:@"输入群描述"];
    [self rightButon];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)swichChoose:(UISwitch *)sender {
    sender.on=!sender.on;

}
- (IBAction)memberOnly:(UISwitch *)sender {
    sender.on=!sender.on;
}
-(void)rightButon
{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,40,15)];
    backButton.accessibilityIdentifier = @"ddFriends";
    [backButton setTitle:@"完成"  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    UIView *leftCustomView = [[UIView alloc] initWithFrame: backButton.frame];
    [leftCustomView addSubview: backButton];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:leftCustomView];
    self.navigationItem.rightBarButtonItem=right;
}
#pragma mark action
-(void)done
{
    NSLog(@"完成");
    [self creatGroupChart];
}
#pragma mark 创建聊天群
-(void)creatGroupChart
{
    //先调环信sdk创建群组，在将群组插入数据库

    EMGroupOptions *setting = [[EMGroupOptions alloc] init];
    if (_publicSwich.on) {
        //公开群
//        if (_memberOnly.on)
//        {
//
//             setting.style=EMGroupStylePublicJoinNeedApproval;
//
//        }else
//        {
//
             setting.style=EMGroupStylePublicJoinNeedApproval;
//        }
    }else
    {
        //私有群
        if (_memberOnly.on)
        {
             //允许群成员添加
             setting.style=EMGroupStylePrivateMemberCanInvite;
            
        }else
        {
            setting.style=EMGroupStylePrivateOnlyOwnerInvite;
            
        }
        
    }
    setting.maxUsersCount = memberCount;
   //邀请群成员时，是否需要发送邀请通知.若NO，被邀请的人自动加入群组
    setting.IsInviteNeedConfirm=NO;
    [self showHudInView:self.view hint:@"正在创建群组"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        DefineWeakSelf;
        EMError *error = nil;
        EMGroup *group = [[EMClient sharedClient].groupManager createGroupWithSubject:self.groupChartName.text description:self.groupDescrib.text invitees:self.invitArray message:[NSString stringWithFormat:@"%@邀请你加入%@",UniqUserID,self.groupChartName.text] setting:setting error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
        
            if (group && !error) {

                [weakSelf addChatGroupdataToMyseverGroupid:group.groupId];

            }
            else{
                [weakSelf showHint:@"创建失败"];
            }
        });
    });

}
//
-(void)addChatGroupdataToMyseverGroupid:(NSString*)groupid
{
    NSString *publicif=_publicSwich.on?@"1":@"0";
    NSString*members_only=_memberOnly.on?@"1":@"0";
    NSArray *dataArray=@[@{@"groupname":_groupChartName.text,@"desc":_groupDescrib.text,@"owner":UniqUserID,@"groupid":groupid,@"owner_nickname":userNickNmae,@"publicif":publicif,@"members_only":members_only,@"maxusers":[NSString stringWithFormat:@"%ld",(long)memberCount]}];
    NSString *datalistJson=[DataProcess getJsonStrWithObj:dataArray];
    [ContractManagerVC RegisterChatGroupAddWithDtalist:datalistJson Success:^(id responseData) {
        NSDictionary *dic=responseData;
        [self hideHud];
        NSLog(@"%@",dic);
        if ([dic[@"sysmodel"][@"blresult"] intValue])
        {
      
            [self showHint:@"创建成功"];
            self.backBlock();
           [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            [self showHint:@"创建失败"];
        }
        
    } Fail:^(id erro) {
        
        
    }];
    
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
