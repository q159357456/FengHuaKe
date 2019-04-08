//
//  ContactListViewController.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/13.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ContactListViewController.h"
#import "AddFriendVC.h"
#import "ContractManagerVC.h"
#import "ApplyViewController.h"
#import "MyfriendModel.h"
#import "ApplyViewController.h"
#import "Masonry.h"
#import "MyfriendModel.h"
#import "MyGroupModel.h"
#import "FMDBUserTable.h"
#import "FMDBGroupTable.h"
#import "GruopManageVC.h"
#import "GroupPickerView.h"
#import "GroupListViewController.h"
#import "ChatViewController.h"
#import <Hyphenate/Hyphenate.h>
#import "ZWHPickView.h"
#import "UIButton+IndexPath.h"
#import "ContractDetailVC.h"
#import "ZWHPersonViewController.h"


@interface ContactListViewController ()<UITableViewDelegate,UITableViewDataSource,EaseUserCellDelegate>
@property (nonatomic) NSInteger unapplyCount;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *groupArray;
@property(nonatomic,strong) GroupPickerView *pickerview;
@end

@implementation ContactListViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self tableViewDidTriggerHeaderRefresh];
}

- (void)viewDidLoad {
    [super viewDidLoad];
      self.automaticallyAdjustsScrollViewInsets=NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.accessibilityIdentifier = @"table_view";
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(ZWHNavHeight);
    }];
    self.keyTableView = _tableView;
    self.dataArray=[NSMutableArray array];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    
   
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFriends)];
    self.navigationItem.rightBarButtonItem = btn;
}
-(UIView*)getHeaderViewWithTitle:(MyGroupModel*)title
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectZero];
    UIImageView *opImageView;
    if ([title.show isEqualToString:@"1"])
    {
        opImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"groupdown"]];
        
    }else
    {
        
       opImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"groupright"]];
    }
   
    UILabel *lable=[[UILabel alloc]init];
    lable.font=[UIFont systemFontOfSize:14];
    lable.textColor=[UIColor darkGrayColor];
    lable.text=title.groupname;
    [view addSubview:opImageView];
    [view addSubview:lable];
    [opImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left).offset(8);
        make.centerY.mas_equalTo(view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(12, 12));
        
    }];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(opImageView.mas_right).offset(10);
        make.centerY.mas_equalTo(view.mas_centerY);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gruopshow:)];
    view.userInteractionEnabled=YES;
    [view addGestureRecognizer:tap];
    
    UIView *butomLineZWH = [[UIView alloc]init];
    butomLineZWH.backgroundColor = LINECOLOR;
    [view addSubview:butomLineZWH]; \
    [butomLineZWH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(view);
        make.height.mas_equalTo(1);
    }];
    
    return view;
}
#pragma mark action
-(void)gruopshow:(UITapGestureRecognizer*)tap
{
    UIView *view=tap.view;
    NSArray *gruoArray=self.dataArray;
    MyGroupModel *model=gruoArray[view.tag-1];
    model.show=[model.show isEqualToString:@"0"]?@"1":@"0";
    [[FMDBGroupTable shareInstance] updateGroup:model];
    [self.tableView reloadData];
}
-(void)addFriends
{
    AddFriendVC *add=[[AddFriendVC alloc]init];
    add.title=@"添加好友";
    [self.navigationController pushViewController:add animated:YES];

}

#pragma mark data
-(void)tableViewDidTriggerHeaderRefresh
{
    [self getAllGroups];
}
-(void)getGroupFriendsWithData:(NSMutableArray*)array
{
    [self.dataArray removeAllObjects];
    self.groupArray=[[FMDBGroupTable shareInstance]getGroupData];
    for (MyGroupModel *model in self.groupArray) {
        model.frenndsArray=[NSMutableArray array];
       
        for (MyfriendModel *fmodel in array) {
            
            if ([fmodel.mygroupid isEqualToString:model.mygroupid]) {
                [model.frenndsArray addObject:fmodel];
            }
        }
        [self.dataArray addObject:model];
    }
    
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1+self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0)
    {
        return 3;
    } else{
        MyGroupModel *model=self.dataArray[section-1];
        if ([model.show isEqualToString:@"1"]) {
            return model.frenndsArray.count;
        }else
        {
            return 0;
        }
        
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            //好友申请
            NSString *CellIdentifier = @"addFriend";
            EaseUserCell *cell = (EaseUserCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (cell == nil) {
                cell = [[EaseUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.avatarView.image = [UIImage imageNamed:@"groupImage"];
            cell.titleLabel.text = @"好友申请";
            cell.avatarView.badge = self.unapplyCount;
            cell.avatarView.imageView.backgroundColor = [UIColor clearColor];
            return cell;
            
        }else if(indexPath.row==1)
        {
            //群聊
            NSString *CellIdentifier = @"addFriend";
            EaseUserCell *cell = (EaseUserCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (cell == nil) {
                cell = [[EaseUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.avatarView.image = [UIImage imageNamed:@"groupImage"];
            cell.titleLabel.text = @"群聊";
//            cell.avatarView.badge = self.unapplyCount;
            cell.avatarView.imageView.backgroundColor = [UIColor clearColor];
            return cell;
            
        }else
        {
            //分组管理
            NSString *CellIdentifier = @"addFriend";
            EaseUserCell *cell = (EaseUserCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (cell == nil) {
                cell = [[EaseUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.avatarView.image = [UIImage imageNamed:@"fenzu"];
            cell.titleLabel.text = @"分组管理";
           cell.avatarView.imageView.backgroundColor = [UIColor clearColor];
            return cell;
            
        }
    }else
    {
        NSString *CellIdentifier = @"EaseUserCell";
        EaseUserCell *cell = (EaseUserCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[EaseUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        MyGroupModel *model=self.dataArray[indexPath.section-1];
        MyfriendModel *fmodel=model.frenndsArray[indexPath.row];
        [cell.avatarView.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,fmodel.loginurl]] placeholderImage:[UIImage imageNamed:@"EaseUIResource.bundle/user"]];
        cell.titleLabel.text = fmodel.friendnickname;
        cell.indexPath=indexPath;
        cell.delegate=self;
        cell.avatarView.imageView.backgroundColor = [UIColor clearColor];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        btn.syindexPath = indexPath;
        [cell.avatarView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(cell.avatarView);
        }];
        [btn addTarget:self action:@selector(iconBtnWith:) forControlEvents:UIControlEventTouchUpInside];

        
        
        return cell;
        
    }
 
}

#pragma mark - 点击头像
-(void)iconBtnWith:(UIButton *)btn{
    NSIndexPath *indx = btn.syindexPath;
    MyGroupModel *model=self.dataArray[indx.section-1];
    MyfriendModel *fmodel=model.frenndsArray[indx.row];
    ZWHPersonViewController *vc=[[ZWHPersonViewController alloc]init];
    vc.userid=fmodel.friendid;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section==0) {
       return 0.1;
        
    }else
    {
        return 40;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 10;
        
    }else
    {
        return 0.1;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section!=0) {
        MyGroupModel *model=self.dataArray[section-1];
        UIView *view=[self getHeaderViewWithTitle:model];
        view.tag=section;
        return view;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT_PRO(50);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        if (indexPath.row==0) {

             [self.navigationController pushViewController:[ApplyViewController shareController] animated:YES];
        }else if (indexPath.row==2)
        {
            GruopManageVC *gvc=[[GruopManageVC alloc]init];
            [self.navigationController pushViewController:gvc animated:YES];
        }else
        {
            GroupListViewController *list=[[GroupListViewController alloc]init];
            [self.navigationController pushViewController:list animated:YES];
        }
    }else
    {
        MyGroupModel *model=self.dataArray[indexPath.section-1];
        MyfriendModel *fmodel=model.frenndsArray[indexPath.row];
        UIViewController *chatController = nil;
#ifdef REDPACKET_AVALABLE
        chatController = [[RedPacketChatViewController alloc] initWithConversationChatter:model.buddy conversationType:EMConversationTypeChat];
#else
        chatController = [[ChatViewController alloc] initWithConversationChatter:fmodel.friendid conversationType:EMConversationTypeChat];
#endif
        chatController.title = fmodel.friendnickname;
        [self.navigationController pushViewController:chatController animated:YES];
    
    }
  
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}
#pragma mark --logpress
- (void)cellLongPressAtIndexPath:(NSIndexPath *)indexPath
{
    
//    NSArray *array=[[FMDBGroupTable shareInstance]getGroupData];
    MyGroupModel *model=self.dataArray[indexPath.section-1];
    MyfriendModel *fmodel=model.frenndsArray[indexPath.row];
    [self AlertControllerWithMessage:@"好友管理" Data:fmodel];
}


#pragma mark UIAlertController
-(void)AlertControllerWithMessage:(NSString*)message Data:(MyfriendModel*)model
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:message  preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"删除好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self emDeletUser:model.friendid];
    
        
        
    }];
    UIAlertAction *action2=[UIAlertAction actionWithTitle:@"添加到其他的分组" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self pickerWithModel:model];
        
    }];
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
    
}
-(void)pickerWithModel:(MyfriendModel*)model
{
    /*if (!_pickerview) {
        DefineWeakSelf;
        _pickerview=[[GroupPickerView alloc]initWithBlock:^(NSString *mygroupid) {
            NSLog(@"%@",mygroupid);
            [weakSelf changeGroupWithModel:model newid:mygroupid];
            
        }];
    }
 
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    [window addSubview:_pickerview];*/
    MJWeakSelf
    NSMutableArray *array = [NSMutableArray array];
    for (MyGroupModel *gourp in _dataArray) {
        [array addObject:gourp.groupname];
    }
    [ZWHPickView showZWHPickView:array with:^(NSString *value, NSInteger index) {
        MyGroupModel *gourpmodel = weakSelf.dataArray[index];
        [weakSelf changeGroupWithModel:model newid:gourpmodel.mygroupid];
    }];
    
}


#pragma mark private
//获取所有群租
-(void)getAllGroups
{
    if ([[FMDBGroupTable shareInstance]getGroupData].count==0) {
        DefineWeakSelf;
        [ContractManagerVC SystemCommonGroupWithMyid:UniqUserID Success:^(id responseData) {
            NSDictionary *dic=(NSDictionary*)responseData;
            NSLog(@"获取所有的分组%@",dic);
            for (MyGroupModel *model in [MyGroupModel getDatawithdic:dic]) {
                [[FMDBGroupTable shareInstance]insertGroup:model];
            }
            [weakSelf getNewAllFriends];
        } Fail:^(id erro) {
            
        }];
    }else
    {
         [self getNewAllFriends];
    }
 
}
//获取所有好友
-(void)getAllFriends
{
    if ([[FMDBUserTable shareInstance]getUserData].count==0) {
        [self showHudInView:self.view hint:@"加载中"];
        DefineWeakSelf;
        [ContractManagerVC  SystemCommonWithID:UniqUserID Success:^(id responseData) {
            [weakSelf hideHud];
            NSDictionary *dic=responseData;
            NSLog(@"我的好友:%@",dic);
            
            [weakSelf getGroupFriendsWithData:[MyfriendModel getDatawithdic:dic]];
            //插入数据库
            for (MyfriendModel *model in [MyfriendModel getDatawithdic:dic]) {
                [[FMDBUserTable shareInstance]insertUser:model];
            }
            
            
        } Fail:^(id erro) {
            
        }];
    }else
    {
        [self getGroupFriendsWithData:[[FMDBUserTable shareInstance]getUserData]];
    }
}

//修改后的的获取好友
-(void)getNewAllFriends{
    
    if ([[FMDBUserTable shareInstance]getUserData].count==0) {
        MJWeakSelf
        [ContractManagerVC RegisterGroupAndUserListWithSysmodel:UniqUserID Success:^(id responseData) {
            NSDictionary *obj=responseData;
            NSArray *arr = [MyfriendModel getNewDataWithDic:obj];
            [weakSelf getGroupFriendsWithData:[NSMutableArray arrayWithArray:arr]];
            //插入数据库
            for (MyfriendModel *model in arr) {
                [[FMDBUserTable shareInstance]insertUser:model];
            }
        } Fail:^(id erro) {
            NSLog(@"%@",erro);
        }];
    }else{
        [self getGroupFriendsWithData:[[FMDBUserTable shareInstance]getUserData]];
    }
    
}

//环信删除好友
-(void)emDeletUser:(NSString*)userid
{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error=[[EMClient sharedClient].contactManager deleteContact:userid isDeleteConversation:YES];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                //[self deletReationshipWithuserID:userid FriendType:@"M"];
            }
        });
    });

   
}
//好友更换分组
-(void)changeGroupWithModel:(MyfriendModel*)model newid:(NSString*)newid
{
    if ([model.mygroupid isEqualToString:newid])
    {
        return;
    }
    [self showHudInView:self.view hint:@""];
    DefineWeakSelf;
    NSArray *datalistArray=@[@{@"myid":UniqUserID,@"friendid":model.friendid,@"mygroupid":newid}];
    NSString *datalistStr=[DataProcess getJsonStrWithObj:datalistArray];
    [ContractManagerVC RegisterEditFriendGroupWithDatalist:datalistStr Success:^(id responseData) {
        [self hideHud];
        NSDictionary *dic=(NSDictionary*)responseData;
       
        if ([dic[@"sysmodel"][@"blresult"] intValue])
        {
            model.mygroupid=newid;
            [[FMDBUserTable shareInstance]updateUser:model];
            
            [weakSelf getGroupFriendsWithData:[[FMDBUserTable shareInstance] getUserData]];
        }
    } Fail:^(id erro) {
        
    }];
 
}
//将好友关系插入数据库
-(void)addFriendReationshipWithuserID:(NSString*)userid FriendType:(NSString*)freindType
{
    DefineWeakSelf;
    [ContractManagerVC RegisterFriendAddWithPara1:UniqUserID Para2:freindType Para3:userid Success:^(id responseData) {
        NSDictionary *dic=responseData;
        NSLog(@"添加好友到数据库结果:%@",dic);
        if ([dic[@"sysmodel"][@"blresult"] intValue])
        {
            //更新数据库
            MyfriendModel *model=[MyfriendModel getDatawithdic:dic][0];
            [[FMDBUserTable shareInstance]insertUser:model];
            [weakSelf getGroupFriendsWithData:[[FMDBUserTable shareInstance]getUserData]];
        }else
        {
            [self showHint:dic[@"sysmodel"][@"strresult"]];
        }
    } Fail:^(id erro) {
        
    }];
}
//删除好友后 mysever删除
-(void)deletReationshipWithuserID:(NSString*)userid FriendType:(NSString*)freindType
{
    NSArray *datalistArray=@[@{@"myid":UniqUserID,@"friendid":userid}];
    NSString *datalistStr=[DataProcess getJsonStrWithObj:datalistArray];
    DefineWeakSelf;
    [ContractManagerVC RegisterFriendDelWithDatalist:datalistStr Success:^(id responseData) {
        NSDictionary *dic=(NSDictionary*)responseData;
        NSLog(@"删除好友到数据库结果:%@",dic);
        if ([dic[@"sysmodel"][@"blresult"] intValue])
        {
            //更新数据库
//            MyfriendModel *model=[MyfriendModel getDatawithdic:dic][0];
            [[FMDBUserTable shareInstance]deleteTable:userid];
            [weakSelf getGroupFriendsWithData:[[FMDBUserTable shareInstance]getUserData]];
        }else
        {
            [self showHint:dic[@"sysmodel"][@"strresult"]];
        }
    } Fail:^(id erro) {
        
    }];
}
    
#pragma mark --pubic
//好友请求变化时，更新好友请求未处理的个数
- (void)reloadApplyView
{
    NSInteger count = [[[ApplyViewController shareController] dataSource] count];
    self.unapplyCount = count;
    [self.tableView reloadData];
}

//群组变化时，更新群组页面
- (void)reloadGroupView;
{
    [self reloadApplyView];
   
    
//    if (_groupController) {
//        [_groupController tableViewDidTriggerHeaderRefresh];
//    }
    
}

//好友个数变化时，重新获取数据
- (void)reloadDataSource
{
    NSLog(@"好友关系形成，插入数据库，前端更新数据");
    
//    [self.dataArray removeAllObjects];
//
//
//    NSArray *buddyList = [[EMClient sharedClient].contactManager getContacts];
//
//    for (NSString *buddy in buddyList) {
//        [self.dataArray addObject:buddy];
//    }
//
//
//    [self.tableView reloadData];
}

//添加好友的操作被触发
- (void)addFriendAction
{
//    NSInteger count = [[[ApplyViewController shareController] dataSource] count];
//    self.unapplyCount = count;
//    [self.tableView reloadData];
}
//旋转
-(void)transWith:(UIView*)view  Angle:(CGFloat)angle
{

     view.transform = CGAffineTransformMakeRotation(angle);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
