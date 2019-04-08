//
//  JoinGroupChatVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/20.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "JoinGroupChatVC.h"
#import <Hyphenate/Hyphenate.h>
#import "UIViewController+HUD.h"
#import "ContractManagerVC.h"
#import "SearchFriendCell.h"
#import "GroupChartModel.h"
#import "FMDBUserTable.h"
#import "FMDBGroupTable.h"

@interface JoinGroupChatVC ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,strong)GroupChartModel *groupChartModel;

@end

@implementation JoinGroupChatVC


- (void)viewDidLoad {
    [super viewDidLoad];
    _searchTextField.returnKeyType=UIReturnKeyDone;
    _searchTextField.delegate=self;
    _tableview.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    self.title=@"搜索群组";
    // Do any additional setup after loading the view from its nib.
}
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
-(void)searchFriend
{
    [self showHudInView:self.view hint:@""];
    DefineWeakSelf;
    [ContractManagerVC SystemCommonGroupWithKeyWord:self.searchTextField.text Success:^(id responseData) {
        [self hideHud];
        NSDictionary *dic=responseData;
        NSLog(@"responseData---%@",dic);
        weakSelf.dataArray=[GroupChartModel getDatawithdic:dic];
        [weakSelf.tableview reloadData];
    } Fail:^(id erro) {
        
    }];
}
-(void)addFriendWithUserID:(NSString*)userid WithMasage:(NSString*)message
{
    [self showHudInView:self.view hint:@""];
    
    NSString *buddyName = userid;
    if (buddyName && buddyName.length > 0) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            BOOL isExit=NO;
            NSArray *buddyList = [[EMClient sharedClient].contactManager getContacts];
            for (NSString *budy in buddyList) {
                if ([buddyName isEqualToString:budy]) {
                    isExit=YES;
                    break;
                }
            }
            NSLog(@"申请好友id: %@\n %@",buddyName,buddyList);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!isExit) {
                    EMError *error = [[EMClient sharedClient].contactManager addContact:buddyName message:message];
                    if (error)
                    {
                        [self showHint:@"发送失败，稍后再试"];
                    }else
                    {
                        [self showHint:@"好友请求发送成功"];
                    }
                }else
                {
                    [self showHint:@"已存在好友列表中!"];
                }
                
                [self hideHud];
                
                
                
                
            });
        });
        
    }
    
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    [self searchFriend];
    return YES;
}
#pragma mark table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"SearchFriendCell";
    SearchFriendCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"SearchFriendCell" owner:nil options:nil][0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    GroupChartModel *model=self.dataArray[indexPath.row];
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"groupImage"]];
    cell.titleLable.text=model.groupname;
    cell.contentLable.text=model.groupid;
    [cell.agreeButt setTitle:@"加入群聊" forState:UIControlStateNormal];
    NSArray *groupArray = [[FMDBGroupTable shareInstance]getGroupData];
    for (MyGroupModel *groupModel in groupArray) {
        if ([groupModel.mygroupid isEqualToString:model.groupid]) {
            [cell.agreeButt setTitleColor:ZWHCOLOR(@"#828282") forState:0];
            [cell.agreeButt setTitle:@"已添加" forState:0];
            cell.agreeButt.enabled = NO;
        }
    }
    DefineWeakSelf;
    cell.addFriendsBlock=^{
        NSLog(@"加入聊天群");
//        if (weakSelf.group.setting.style == EMGroupStylePublicJoinNeedApproval) {
            weakSelf.groupChartModel=model;
            [self showMessageAlertView];
//        }
//        else if (self.group.setting.style == EMGroupStylePublicOpenJoin)
//        {
//            [self joinGroup:_groupId];
//        }

     
    };
    return cell;
 
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
#pragma mark private
- (void)showMessageAlertView
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"说些什么吧.." delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
}
- (void)applyJoinGroup:(NSString *)groupId withGroupname:(NSString *)groupName message:(NSString *)message
{
    [self showHudInView:self.view hint:@"正在发送群聊申请"];
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = nil;
      //message收不到
        [[EMClient sharedClient].groupManager applyJoinPublicGroup:groupId message:message error:&error];
      
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideHud];
            if (!error) {
                [weakSelf showHint:@"申请发送成功"];
            }
            else{
                [weakSelf showHint:error.errorDescription];
            }
        });
    });
    
}
#pragma mark - alertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView cancelButtonIndex] != buttonIndex) {
        UITextField *messageTextField = [alertView textFieldAtIndex:0];
        
        NSString *messageStr = @"";
        if (messageTextField.text.length > 0) {
            messageStr = messageTextField.text;
        }
        [self applyJoinGroup:self.groupChartModel.groupid withGroupname:self.groupChartModel.groupname message:messageStr];
    }
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
