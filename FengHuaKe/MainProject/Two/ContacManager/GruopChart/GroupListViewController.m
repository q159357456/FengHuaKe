//
//  GroupListViewController.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/14.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "GroupListViewController.h"
#import "AddGruopChartVC.h"
#import "ContractManagerVC.h"
#import "GroupChartModel.h"
#import "ChatViewController.h"
#import "PopupView.h"
#import "JoinGroupChatVC.h"
@interface GroupListViewController ()
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation GroupListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的群组";
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    _dataSource=[NSMutableArray array];
    self.view.backgroundColor=[UIColor whiteColor];
    [self addRightButton];
    [self getMyselfGroup];
    //加入新的群聊
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(joinNewGroup) name:@"SDKdidJoinedGroup" object:nil];
    //所在的群聊被群主解散
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(joinNewGroup) name:@"groupHadDestroyed" object:nil];
    //被群主踢出群聊
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(joinNewGroup) name:@"BeRemovedFromGroup" object:nil];
    // Do any additional setup after loading the view.
}
-(void)joinNewGroup
{
     [self getMyselfGroup];
}
-(void)addRightButton
{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,15,15)];
    backButton.accessibilityIdentifier = @"ddFriends";
    [backButton setBackgroundImage:[UIImage imageNamed:@"addFriends"]  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(getGroups:) forControlEvents:UIControlEventTouchUpInside];
    UIView *leftCustomView = [[UIView alloc] initWithFrame: backButton.frame];
    [leftCustomView addSubview: backButton];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:leftCustomView];
    self.navigationItem.rightBarButtonItem=right;
}
#pragma mark action
-(void)getGroups:(UIButton*)butt
{
    DefineWeakSelf;
    [PopupView addCellWithIcon:nil text:@"新建群组" action:^{
        [weakSelf creatChatGroup];
      
    }];
    [PopupView addCellWithIcon:nil text:@"加入群组" action:^{
        
        [weakSelf JoinChatGroup];
    }];
    [PopupView popupViewInPosition:ShowRight];


}
//creatChatGroup
-(void)creatChatGroup
{
        AddGruopChartVC *vc=[[AddGruopChartVC alloc]init];
        DefineWeakSelf;
        vc.backBlock=^{
            [weakSelf getMyselfGroup];
        };
        [self.navigationController pushViewController:vc animated:YES];
}

//JoinChatGroup
-(void)JoinChatGroup
{
    JoinGroupChatVC *vc=[[JoinGroupChatVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 获取我的群组
-(void)getMyselfGroup
{
    //从环信获取群组成员列表
//    NSArray *rooms = [[EMClient sharedClient].groupManager get];
//    NSLog(@"环信群成员:%@",rooms);
    EMError *error = nil;
    NSArray *myGroups = [[EMClient sharedClient].groupManager getJoinedGroupsFromServerWithPage:1 pageSize:50 error:&error];
    if (!error) {
//        NSLog(@"环信群成员 -- %@",myGroups);
        for (EMGroup *model in myGroups) {
            NSLog(@"环信群成员:%@",model.groupId);
        }
    }

    //从mysever上读取自己的群组信息
    [self showHudInView:self.view hint:@""];
    DefineWeakSelf;
    [ContractManagerVC RegisterUserDetailForCharGroupSuccess:^(id responseData) {
        [self hideHud];
        NSDictionary *dic=responseData;
        if ([dic[@"sysmodel"][@"blresult"] intValue]) {
            NSString *jsonStr=dic[@"sysmodel"][@"strresult"];
            NSLog(@"jsonStr:%@",jsonStr);
           
            if (![jsonStr isEqual:[NSNull null]]) {
                NSData *data=[jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                NSObject *obj=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                NSArray *array=(NSArray*)obj;
                weakSelf.dataSource=[GroupChartModel getDatawitharray:array];
                [weakSelf.tableView reloadData];
            }
           
        }else
        {
            
            [self showHint:@"获取群组失败"];
        }
      
     
    } Fail:^(id erro) {
        
    }];
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
   return   [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"addFriend";
    EaseUserCell *cell = (EaseUserCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[EaseUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    GroupChartModel *model=self.dataSource[indexPath.row];
    cell.avatarView.image = [UIImage imageNamed:@"groupImage"];
    cell.titleLabel.text = model.groupname;;
    cell.avatarView.imageView.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GroupChartModel *model=self.dataSource[indexPath.row];
    UIViewController *chatController = nil;
#ifdef REDPACKET_AVALABLE
    chatController = [[RedPacketChatViewController alloc] initWithConversationChatter:group.groupId conversationType:EMConversationTypeGroupChat];
#else
    chatController = [[ChatViewController alloc] initWithConversationChatter:model.groupid conversationType:EMConversationTypeGroupChat];
#endif
    chatController.title =model.groupname;
    [self.navigationController pushViewController:chatController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

//获取我的所有群组列表
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
