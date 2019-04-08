//
//  ConversationListController.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/13.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ConversationListController.h"
#import "ChatViewController.h"
#import "FMDBUserTable.h"
#import "MyfriendModel.h"
#define kHaveUnreadAtMessage    @"kHaveAtMessage"
#define kAtYouMessage           1
#define kAtAllMessage           2
@interface ConversationListController ()<EaseConversationListViewControllerDelegate, EaseConversationListViewControllerDataSource>
@property (nonatomic, strong) UIView *networkStateView;
@end

@implementation ConversationListController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.delegate=self;
    self.dataSource=self;
    [self networkStateView];
    [self tableViewDidTriggerHeaderRefresh];
    [self removeEmptyConversationsFromDB];
    self.showRefreshHeader = YES;
    //首次进入加载数据
    [self tableViewDidTriggerHeaderRefresh];

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refresh];
    //self.navigationController.navigationBarHidden = NO;
}

- (void)removeEmptyConversationsFromDB
{
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSMutableArray *needRemoveConversations;
    for (EMConversation *conversation in conversations) {
        if (!conversation.latestMessage || (conversation.type == EMConversationTypeChatRoom)) {
            if (!needRemoveConversations) {
                needRemoveConversations = [[NSMutableArray alloc] initWithCapacity:0];
            }
            
            [needRemoveConversations addObject:conversation];
        }
    }
    
    if (needRemoveConversations && needRemoveConversations.count > 0) {
        [[EMClient sharedClient].chatManager deleteConversations:needRemoveConversations isDeleteMessages:YES completion:nil];
    }
}
#pragma mark - getter
- (UIView *)networkStateView
{
    if (_networkStateView == nil) {
        _networkStateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44)];
        _networkStateView.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:199 / 255.0 blue:199 / 255.0 alpha:0.5];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (_networkStateView.frame.size.height - 20) / 2, 20, 20)];
        imageView.image = [UIImage imageNamed:@"messageSendFail"];
        [_networkStateView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, 0, _networkStateView.frame.size.width - (CGRectGetMaxX(imageView.frame) + 15), _networkStateView.frame.size.height)];
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = [UIColor grayColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"network.disconnection", @"Network disconnection");
        [_networkStateView addSubview:label];
    }
    
    return _networkStateView;
}
#pragma mark - EaseConversationListViewControllerDelegate

- (void)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
            didSelectConversationModel:(id<IConversationModel>)conversationModel
{
   
    if (conversationModel) {
        EMConversation *conversation = conversationModel.conversation;
        if (conversation) {
//            if ([[RobotManager sharedInstance] isRobotWithUsername:conversation.conversationId]) {
//                RobotChatViewController *chatController = [[RobotChatViewController alloc] initWithConversationChatter:conversation.conversationId conversationType:conversation.type];
//                chatController.title = [[RobotManager sharedInstance] getRobotNickWithUsername:conversation.conversationId];
//                [self.navigationController pushViewController:chatController animated:YES];
//            } else {
                UIViewController *chatController = nil;
#ifdef REDPACKET_AVALABLE
//                chatController = [[RedPacketChatViewController alloc] initWithConversationChatter:conversation.conversationId conversationType:conversation.type];
#else
                chatController = [[ChatViewController alloc] initWithConversationChatter:conversation.conversationId conversationType:conversation.type];
#endif
                chatController.title = conversationModel.title;
                [self.navigationController pushViewController:chatController animated:YES];
//            }
        }

        [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUnreadMessageCount" object:nil];
        [self.tableView reloadData];
    }
}
//通过好友id获得好友昵称
-(NSString*)getnikeNameWithid:(NSString*)userid
{
    NSArray *array=[[FMDBUserTable shareInstance]getUserData];
    for (MyfriendModel *model in array) {
        if ([model.friendid isEqualToString:userid]) {
            return model.friendnickname;
        }
    }
    return nil;
}

//通过好友id获得好友头像
-(NSString*)getImgUrlWithid:(NSString*)userid
{
    NSArray *array=[[FMDBUserTable shareInstance]getUserData];
    for (MyfriendModel *model in array) {
        if ([model.friendid isEqualToString:userid]) {
            return model.loginurl;
        }
    }
    return nil;
}

#pragma mark - EaseConversationListViewControllerDataSource
//构建实现协议IConversationModel的model
- (id<IConversationModel>)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
                                    modelForConversation:(EMConversation *)conversation
{
    EaseConversationModel *model = [[EaseConversationModel alloc] initWithConversation:conversation];
    if (model.conversation.type == EMConversationTypeChat)
    {
        NSLog(@"profileEntity.imageUrl1");
        model.avatarImage=[UIImage imageNamed:@"EaseUIResource.bundle/user"];
        model.avatarURLPath = [NSString stringWithFormat:@"%@%@",SERVER_IMG,[self getImgUrlWithid:model.conversation.conversationId]];
        NSString *nikename=[self getnikeNameWithid:model.conversation.conversationId];
        model.title=nikename;
        
    } else if (model.conversation.type == EMConversationTypeGroupChat) {
        NSString *imageName = @"groupImage";
        if (![conversation.ext objectForKey:@"subject"])
        {
            NSArray *groupArray = [[EMClient sharedClient].groupManager getJoinedGroups];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:conversation.conversationId]) {
                    NSMutableDictionary *ext = [NSMutableDictionary dictionaryWithDictionary:conversation.ext];
                    [ext setObject:group.subject forKey:@"subject"];
                    [ext setObject:[NSNumber numberWithBool:group.isPublic] forKey:@"isPublic"];
                    conversation.ext = ext;
                    break;
                }
            }
        }
        NSDictionary *ext = conversation.ext;
        model.title = [ext objectForKey:@"subject"];
//        imageName = [[ext objectForKey:@"isPublic"] boolValue] ? @"groupPublicHeader" : @"groupPrivateHeader";
        model.avatarImage = [UIImage imageNamed:imageName];
    }
    return model;
}




#pragma mark - public
-(void)refresh
{
    
    [self refreshAndSortView];
}
-(void)refreshDataSource
{
    [self tableViewDidTriggerHeaderRefresh];
}
- (void)isConnect:(BOOL)isConnect{
    if (!isConnect) {
        self.tableView.tableHeaderView = _networkStateView;
    }
    else{
        self.tableView.tableHeaderView = nil;
    }
    
}
- (void)networkChanged:(EMConnectionState)connectionState
{     //如果没有网络连接
    if (connectionState == EMConnectionDisconnected) {
        self.tableView.tableHeaderView = _networkStateView;
    }
    else{
        self.tableView.tableHeaderView = nil;
    }
}
-(void)addFriendAction
{
    NSLog(@"添加好友");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
