/************************************************************
  *  * Hyphenate CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2016 Hyphenate Inc. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of Hyphenate Inc.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from Hyphenate Inc.
  */

#import "ApplyViewController.h"
#import <Hyphenate/Hyphenate.h>
#import "ApplyFriendCell.h"
#import "InvitationManager.h"
#import "EaseUI.h"
#import "GBNavigationController.h"
#import "ContractManagerVC.h"
#import "UserModel.h"
static ApplyViewController *controller = nil;

@interface ApplyViewController ()<ApplyFriendCellDelegate>
@property(nonatomic,strong)NSMutableArray *usermodelArray;
@end

@implementation ApplyViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _dataSource = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (instancetype)shareController
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controller = [[self alloc] initWithStyle:UITableViewStylePlain];

    });
    
    return controller;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"好友申请";
    // Uncomment the following line to preserve selection between presentations.
//    self.title = NSLocalizedString(@"title.apply", @"Application and notification");
 
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self loadDataSourceFromLocalDB];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getApllyFriendInfo];
            GBNavigationController *nav=(GBNavigationController*)controller.navigationController;
            DefineWeakSelf;
            nav.diffBack=^{
                [weakSelf rootback];
            };
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    GBNavigationController *nav=(GBNavigationController*)controller.navigationController;
    nav.diffBack=nil;
}
-(void)rootback
{

    [self back];
}


//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//
////    [self.tableView reloadData];
//}

#pragma mark - getter

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

- (NSString *)loginUsername
{
    //当前登录账号
    return [[EMClient sharedClient] currentUsername];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ApplyFriendCell";
    ApplyFriendCell *cell = (ApplyFriendCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[ApplyFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if(self.dataSource.count > indexPath.row)
    {
        ApplyEntity *entity = [self.dataSource objectAtIndex:indexPath.row];
        if (entity) {
            cell.indexPath = indexPath;
            ApplyStyle applyStyle = [entity.style intValue];
            if (applyStyle == ApplyStyleGroupInvitation) {
                cell.titleLabel.text = @"群聊邀请";
                cell.headerImageView.image = [UIImage imageNamed:@"groupPrivateHeader"];
            }
            else if (applyStyle == ApplyStyleJoinGroup)
            {
                cell.titleLabel.text = @"群聊申请";
                cell.headerImageView.image = [UIImage imageNamed:@"groupPrivateHeader"];
            }
            else if(applyStyle == ApplyStyleFriend){
//                cell.titleLabel.text = entity.applicantUsername;
                cell.titleLabel.text = @"好友请求";
                cell.headerImageView.image = [UIImage imageNamed:@"default_head"];
            }
            for (UserModel *model in self.usermodelArray) {
                if ([entity.applicantUsername isEqualToString:model.myid]) {
                    
                    break;
                    
                }
            }
            cell.contentLabel.text = entity.reason;
        }
    }
    
    return cell;
}
//获取好友申请的详细信息
-(void)getApllyFriendInfo
{
    
    NSMutableArray *datalistArray=[NSMutableArray array];
    for (ApplyEntity *entity in self.dataSource) {
        NSDictionary *dic=@{@"myid":entity.applicantUsername};
        [datalistArray addObject:dic];
    }
    
    NSString *dataList=[DataProcess getJsonStrWithObj:datalistArray];
    [ContractManagerVC RegisterUserInfoWithDatalist:dataList Success:^(id responseData) {
        NSDictionary *dic=(NSDictionary*)responseData;

        self.usermodelArray=[UserModel getDatawithdic:dic];
        [self.tableView reloadData];
    } Fail:^(id erro) {
        
    }];
    
}
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ApplyEntity *entity = [self.dataSource objectAtIndex:indexPath.row];
    return [ApplyFriendCell heightWithContent:entity.reason];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - ApplyFriendCellDelegate

- (void)applyCellAddFriendAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [self.dataSource count]) {
        [self showHudInView:self.view hint:NSLocalizedString(@"sendingApply", @"sending apply...")];
        
        ApplyEntity *entity = [self.dataSource objectAtIndex:indexPath.row];
        ApplyStyle applyStyle = [entity.style intValue];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            EMError *error;
            if (applyStyle == ApplyStyleGroupInvitation) {
                //群邀请
                [[EMClient sharedClient].groupManager acceptInvitationFromGroup:entity.groupId inviter:entity.applicantUsername error:&error];
            }
            else if (applyStyle == ApplyStyleJoinGroup)
            {
                //加入群，此群是公开群
                error = [[EMClient sharedClient].groupManager acceptJoinApplication:entity.groupId applicant:entity.applicantUsername];
        
                
            }
            else if(applyStyle == ApplyStyleFriend){
                
                
                error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:entity.applicantUsername];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideHud];
                if (!error) {
                    //插入mysever
                    if (applyStyle == ApplyStyleGroupInvitation) {
                        NSLog(@"同意群邀请.....");
                        //群邀请
                        [self agreenInvateWithGroupid:entity.groupId Applicant:nil ApplicaName:nil];
                    }
                    else if (applyStyle == ApplyStyleJoinGroup)
                    {
                        //加入群，此群是公开群
                        [self getNikeNmaeWithGroupid:entity.groupId Applicant:entity.applicantUsername];
                        
                    }  else if(applyStyle == ApplyStyleFriend){
                        
                        //好友邀请
                        NSLog(@"接收好友邀请...");
                        
                    }
                    
                    [self.dataSource removeObject:entity];
                    [[InvitationManager sharedInstance] removeInvitation:entity loginUser:UniqUserID];
                    [self.tableView reloadData];
                }
                else{
                    [self showHint:error.errorDescription];
                }
            });
        });
    }
    
}
    

//通过id获取昵称
-(void)getNikeNmaeWithGroupid:(NSString*)groupid Applicant:(NSString*)applicant
{
    DefineWeakSelf;
    [ContractManagerVC SystemCommonGroupWithuserid:applicant Success:^(id responseData) {
        NSDictionary *dic=responseData;
        NSString *nickName=dic[@"DataList"][0][@"nickname"];
        [weakSelf agreenInvateWithGroupid:groupid Applicant:applicant ApplicaName:nickName];
    } Fail:^(id erro) {
        
    }];
    
  
}
 //同意群聊邀请后将数据插入到数据库
-(void)agreenInvateWithGroupid:(NSString*)groupid Applicant:(NSString*)applicant ApplicaName:(NSString*)Appliname
{
    NSArray *datalistArray;
    if (applicant) {
        datalistArray=@[@{@"memberid":applicant,@"menickname":Appliname,@"groupid":groupid}];
    }else{
        datalistArray=@[@{@"memberid":UniqUserID,@"menickname":userNickNmae,@"groupid":groupid}];
    }
    
    NSString *datalistStr=[DataProcess getJsonStrWithObj:datalistArray];
    [ContractManagerVC RegisterChatGroupAddMember:datalistStr Success:^(id responseData) {
        NSDictionary *dic=responseData;
        if ([dic[@"sysmodel"][@"blresult"] intValue])
        {
            [self showHint:@"成功加入群"];
            [[NSNotificationCenter defaultCenter]postNotificationName:AgreeGroupInvate object:nil userInfo:nil];
          
        }else
        {
            [self showHint:dic[@"sysmodel"][@"strresult"]];
        }

    } Fail:^(id erro) {
        
    }];
    
}
- (void)applyCellRefuseFriendAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [self.dataSource count]) {
        [self showHudInView:self.view hint:NSLocalizedString(@"sendingApply", @"sending apply...")];
        ApplyEntity *entity = [self.dataSource objectAtIndex:indexPath.row];
        ApplyStyle applyStyle = [entity.style intValue];
        EMError *error;
        
        if (applyStyle == ApplyStyleGroupInvitation) {
            error = [[EMClient sharedClient].groupManager declineInvitationFromGroup:entity.groupId inviter:entity.applicantUsername reason:nil];
        }
        else if (applyStyle == ApplyStyleJoinGroup)
        {
            error = [[EMClient sharedClient].groupManager declineJoinApplication:entity.groupId applicant:entity.applicantUsername reason:nil];
        }
        else if(applyStyle == ApplyStyleFriend){
            [[EMClient sharedClient].contactManager declineInvitationForUsername:entity.applicantUsername];
        }
        
        [self hideHud];
        if (!error) {
            [self.dataSource removeObject:entity];
            NSString *loginUsername = [[EMClient sharedClient] currentUsername];
            [[InvitationManager sharedInstance] removeInvitation:entity loginUser:loginUsername];
            
            [self.tableView reloadData];
        }
        else{
            [self showHint:NSLocalizedString(@"rejectFail", @"reject failure")];
            [self.dataSource removeObject:entity];
            NSString *loginUsername = [[EMClient sharedClient] currentUsername];
            [[InvitationManager sharedInstance] removeInvitation:entity loginUser:loginUsername];
            
            [self.tableView reloadData];

        }
    }
}

#pragma mark - public

- (void)addNewApply:(NSDictionary *)dictionary
{
    if (dictionary && [dictionary count] > 0) {
        NSString *applyUsername = [dictionary objectForKey:@"username"];
        ApplyStyle style = [[dictionary objectForKey:@"applyStyle"] intValue];
        
        if (applyUsername && applyUsername.length > 0) {
            for (int i = ((int)[_dataSource count] - 1); i >= 0; i--) {
                ApplyEntity *oldEntity = [_dataSource objectAtIndex:i];
                ApplyStyle oldStyle = [oldEntity.style intValue];
                if (oldStyle == style && [applyUsername isEqualToString:oldEntity.applicantUsername]) {
                    if(style != ApplyStyleFriend)
                    {
                        NSString *newGroupid = [dictionary objectForKey:@"groupname"];
                        if (newGroupid || [newGroupid length] > 0 || [newGroupid isEqualToString:oldEntity.groupId]) {
                            break;
                        }
                    }
                    
                    oldEntity.reason = [dictionary objectForKey:@"applyMessage"];
                    [_dataSource removeObject:oldEntity];
                    [_dataSource insertObject:oldEntity atIndex:0];
                    [self.tableView reloadData];
                    
                    return;
                }
            }
            
            //new apply
            ApplyEntity *newEntity= [[ApplyEntity alloc] init];
            newEntity.applicantUsername = [dictionary objectForKey:@"username"];
            newEntity.style = [dictionary objectForKey:@"applyStyle"];
            newEntity.reason = [dictionary objectForKey:@"applyMessage"];
            
            NSString *loginName = [[EMClient sharedClient] currentUsername];
            newEntity.receiverUsername = loginName;
            
            NSString *groupId = [dictionary objectForKey:@"groupId"];
            newEntity.groupId = (groupId && groupId.length > 0) ? groupId : @"";
            
            NSString *groupSubject = [dictionary objectForKey:@"groupname"];
            newEntity.groupSubject = (groupSubject && groupSubject.length > 0) ? groupSubject : @"";
            
            NSString *loginUsername = [[EMClient sharedClient] currentUsername];
            [[InvitationManager sharedInstance] addInvitation:newEntity loginUser:loginUsername];
            
            [_dataSource insertObject:newEntity atIndex:0];
            [self.tableView reloadData];

        }
    }
}

- (void)removeApply:(NSString *)aTarget
{
    if ([aTarget length] == 0) {
        return ;
    }
    
    for (ApplyEntity *entity in self.dataSource) {
        if ([entity.applicantUsername isEqualToString:aTarget] || [entity.groupId isEqualToString:aTarget]) {
            NSString *loginUsername = [[EMClient sharedClient] currentUsername];
            [[InvitationManager sharedInstance] removeInvitation:entity loginUser:loginUsername];
            [self.dataSource removeObject:entity];
            [self.tableView reloadData];
            break;
        }
    }
}

- (void)loadDataSourceFromLocalDB
{
    [_dataSource removeAllObjects];
    NSString *loginName = [self loginUsername];
    if(loginName && [loginName length] > 0)
    {
        NSArray * applyArray = [[InvitationManager sharedInstance] applyEmtitiesWithloginUser:loginName];
        [self.dataSource addObjectsFromArray:applyArray];
        
        [self.tableView reloadData];
    }
}

- (void)back
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUntreatedApplyCount" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)clear
{
    [_dataSource removeAllObjects];
    [self.tableView reloadData];
}

@end
