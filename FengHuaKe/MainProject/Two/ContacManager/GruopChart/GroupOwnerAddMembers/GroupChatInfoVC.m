//
//  GroupChatInfoVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/20.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "GroupChatInfoVC.h"
#import "ContractSlectedVC.h"
#import <Hyphenate/Hyphenate.h>
#import "HeaderView.h"
#import "GroupMemberCell.h"
#import "GroupComonSetCell.h"
#import "GroupBoolSetCell.h"
#import "ContractManagerVC.h"
#import "GroupMember.h"
#import "MyfriendModel.h"
#import "UIViewController+HUD.h"
@interface GroupChatInfoVC ()<UITableViewDelegate,UITableViewDataSource,SlectDelegate>
{
    NSArray *_cellidentifyArray;
    NSArray *_titleArray;
    BOOL deletOrAdd;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)BOOL isowner;
@end

@implementation GroupChatInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    _dataArray=[NSMutableArray array];

    
    //环信获取群内所有成员
    EMError *error = nil;
    EMCursorResult* result = [[EMClient sharedClient].groupManager getGroupMemberListFromServerWithId:self.groupid cursor:@"" pageSize:50 error:&error];
    if (!error) {
       ;
        // result.list: 返回的成员列表，内部的值是成员的环信id。
        // result.cursor: 返回的cursor，如果要取下一页的列表，需要将这个cursor当参数传入到获取群组成员列表中。
        NSLog(@"返回的成员列表:%@",result.list);
        NSLog(@"返回的cursor:%@",result.cursor);
        
    }else
    {
        NSLog(@"error.errorDescription:%@",error.errorDescription);
        NSLog(@"error.code:%d",error.code);
    }
    //环信获取群详情
//      EMGroup *group = [[EMClient sharedClient].groupManager getGroupSpecificationFromServerWithId:self.groupid error:&error];
//    NSLog(@"群主:%@",group.owner);
    [self setUI];
    [self getAllMembers];
    //邀请的好友同意入群
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(memberAgree) name:AgreeGroupInvate object:nil];
    //有用户加入群组
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(memberJoin) name:@"UpdateGroupDetail" object:nil];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark private
-(void)addFunImage
{
    self.isowner=[self isOwener];
    if (self.isowner) {
        UIImage *image1=[UIImage imageNamed:@"add"];
        [self.dataArray addObject:image1];
        UIImage *image2=[UIImage imageNamed:@"mince"];
        [self.dataArray addObject:image2];
    }else
    {
        UIImage *image1=[UIImage imageNamed:@"add"];
        [self.dataArray addObject:image1];
    }
   
    [self.tableview reloadData];
}
-(BOOL)isOwener
{
    for (NSObject *obj in self.dataArray) {
        if ([obj isKindOfClass:[GroupMember class]]) {
            GroupMember *model=(GroupMember*)obj;
            if ([[NSString stringWithFormat:@"%@",model.ownerif] isEqualToString:@"1"]) {
                if ([model.memberid isEqualToString:UniqUserID]) {
                    return YES;
                    
                }
            }
        }
     
    }
    return NO;
}
//删除群成员(被剔除)
-(void)deletMemberFromGroup:(NSArray*)userArray
{
    NSMutableArray *dataListArray=[NSMutableArray array];
    for (GroupMember *model in userArray) {
        NSDictionary *dic=@{@"groupid":self.groupid,@"memberid":model.memberid,@"state":@"1"};
        [dataListArray addObject:dic];
    }
    DefineWeakSelf;
    NSString *datalistStr=[DataProcess getJsonStrWithObj:dataListArray];
    [ContractManagerVC RegisterChatGroupDelMember:datalistStr Success:^(id responseData) {
        NSDictionary *dic=responseData;
        NSLog(@"删除群成员:%@",dic);
        if ([dic[@"sysmodel"][@"blresult"] intValue])
        {
            [self showHint:@"mysever删除成功"];
            [weakSelf getAllMembers];
            
        }else
        {
            [self showHint:dic[@"sysmodel"][@"strresult"]];
        }
    } Fail:^(id erro) {
        
    }];
    
}
//退出群聊
-(void)leveGroup
{
    NSArray *datalistarray=@[@{@"groupid":self.groupid,@"memberid":UniqUserID,@"state":@"2"}];
    
    NSString *datalistStr=[DataProcess getJsonStrWithObj:datalistarray];
    [ContractManagerVC RegisterChatGroupDelMember:datalistStr Success:^(id responseData) {
        NSDictionary *dic=responseData;
        if ([dic[@"sysmodel"][@"blresult"] intValue])
        {
            [self showHint:@"sever离开成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }else
        {
            [self showHint:dic[@"sysmodel"][@"strresult"]];
        }
    } Fail:^(id erro) {
        
    }];
}
//添加群成员
-(void)addMemberToGroup:(NSArray *)userArray
{
    NSMutableArray *dataListArray=[NSMutableArray array];
    for (MyfriendModel *model in userArray) {
        NSDictionary *dic=@{@"memberid":model.friendid,@"menickname":model.friendnickname,@"groupid":self.groupid};
        [dataListArray addObject:dic];
    }
    NSString *datalistStr=[DataProcess getJsonStrWithObj:dataListArray];
    [ContractManagerVC RegisterChatGroupAddMember:datalistStr Success:^(id responseData) {
        NSDictionary *dic=responseData;
        NSLog(@"添加成员:%@",dic);
        if ([dic[@"sysmodel"][@"blresult"] intValue])
        {
            [self showHint:@"mysever邀请成功"];
            
        }else
        {
            [self showHint:dic[@"sysmodel"][@"strresult"]];
        }
        
    } Fail:^(id erro) {
        
    }];
}
//群主解散群
-(void)ownerDeletGroup
{
    DefineWeakSelf;
    [ContractManagerVC RegisterChatGroupDelWithOwner:UniqUserID Groupid:self.groupid Success:^(id responseData) {
        NSDictionary *dic=(NSDictionary*)responseData;
        if ([dic[@"sysmodel"][@"blresult"] intValue])
        {
            [self showHint:@"mysever删除群成功"];
            
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            
        }else
        {
            [self showHint:dic[@"sysmodel"][@"strresult"]];
        }
    } Fail:^(id erro) {
        
    }];
}
//环信
-(void)addEMWithUserArray:(NSArray*)userArray
{
    NSMutableArray *groupidArray=[NSMutableArray array];
    for (MyfriendModel *model in userArray) {
        [groupidArray addObject:model.friendid];
    }
    EMError *error = nil;
    DefineWeakSelf;
    [[EMClient sharedClient].groupManager addOccupants:groupidArray toGroup:self.groupid welcomeMessage:@"欢迎加入群聊" error:&error];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideHud];
        if (!error) {
            
            [weakSelf showHint:@"群聊邀请已发送"];
            [weakSelf addMemberToGroup:userArray];
        }
        else {
            [weakSelf showHint:error.errorDescription];
        }
        
    });
    
}
-(void)deletEMWithUserArray:(NSArray*)userArray
{
    NSMutableArray *groupidArray=[NSMutableArray array];
    for (GroupMember *model in userArray) {
        [groupidArray addObject:model.memberid];
    }
    DefineWeakSelf;
    [[EMClient sharedClient].groupManager removeMembers:groupidArray fromGroup:self.groupid completion:^(EMGroup *aGroup, EMError *aError) {
        if (!aError) {
            [weakSelf deletMemberFromGroup:userArray];
        }else
        {
            [self showHint:aError.errorDescription];
        }
    }];
    
}

#pragma mark myseverFun
-(void)getAllMembers
{
    DefineWeakSelf;
    [ContractManagerVC RegisterChatGroupUserListWithGroupid:self.groupid Success:^(id responseData) {
//        [self.dataArray removeAllObjects];
        weakSelf.dataArray=[GroupMember getDatawithdic:responseData];
        [weakSelf addFunImage];
        weakSelf.tableview.tableHeaderView=[self headView];
        weakSelf.tableview.tableFooterView=[self footView];
    } Fail:^(id erro) {
        
    }];
}
#pragma mark Ui
-(void)setUI
{
 _cellidentifyArray=@[@[@"GroupMemberCell"],@[@"GroupComonSetCell",@"GroupComonSetCell",@"GroupComonSetCell",@"GroupComonSetCell",@"GroupComonSetCell"]];
      _titleArray=@[@[@"群成员"],@[@"群id",@"群共享设置",@"群消息设置",@"清空聊天记录",@"更换群主"]];
    

    
    
}
-(UIView*)footView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 60, ScreenWidth-40, 40)];
    addButton.backgroundColor = UIColorFromRGB(0x4BA4FF);
    [addButton rounded:3];
    if ([self isOwener]) {
         [addButton setTitle:@"解散群租" forState:UIControlStateNormal];
    }else
    {
         [addButton setTitle:@"离开群租" forState:UIControlStateNormal];
    }
   
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:addButton];
    return footView;
}
-(UIView*)headView
{
    HeaderView *head=[[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:nil options:nil][0];
    EMError *error = nil;
    EMGroup *group = [[EMClient sharedClient].groupManager getGroupSpecificationFromServerWithId:self.groupid error:&error];
    head.GroupTitle.text=group.subject;
    head.frame=CGRectMake(0, 0, ScreenWidth, ScreenWidth/3);
    return head;
}


#pragma mark action
//解散群
-(void)buttonClick
{
    if ([self isOwener])
    {
        NSLog(@"解散群租");
        //解散群租
        DefineWeakSelf;
        [self showHudInView:self.view hint:NSLocalizedString(@"group.destroy", @"dissolution of the group")];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(){
            EMError *error = [[EMClient sharedClient].groupManager destroyGroup:weakSelf.groupid];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf hideHud];
                if (error) {
                    [weakSelf showHint:NSLocalizedString(@"group.destroyFail", @"dissolution of group failure")];
                }
                else{
                    [weakSelf ownerDeletGroup];
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"ExitChat" object:nil];
                }
            });
        });
        
        
    }
    else{
        //离开群租
         NSLog(@"离开群租");
        DefineWeakSelf;
        [self showHudInView:self.view hint:NSLocalizedString(@"group.leave", @"quit the group")];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(){
                    EMError *error = nil;
                    [[EMClient sharedClient].groupManager leaveGroup:self.groupid error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf hideHud];
                        if (error) {
                            [weakSelf showHint:NSLocalizedString(@"group.leaveFail", @"exit the group failure")];
                        }
                        else{
                            [self leveGroup];
//                            [[NSNotificationCenter defaultCenter] postNotificationName:@"ExitChat" object:nil];
                        }
                    });
                });
            }
    

    

}
//群组添加成员
-(void)addMemberAction
{
  
    ContractSlectedVC *vc=[[ContractSlectedVC alloc]init];
    vc.deletOrAdd=deletOrAdd;
    vc.exitArray=self.dataArray;
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}
//邀请被同意
-(void)memberJoin
{
    NSLog(@"群成员有变化");
    [self getAllMembers];
}

#pragma mark- tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _titleArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array=_titleArray[section];
    return array.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    NSString *cellid=_cellidentifyArray[indexPath.section][indexPath.row];
    GroupBaseCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell=[[NSBundle mainBundle]loadNibNamed:cellid owner:nil options:nil][0];
    }
    if ([cellid isEqualToString:@"GroupComonSetCell"]) {
        [cell updateCellWithData:_titleArray[indexPath.section][indexPath.row]];
    }else
    {
        GroupMemberCell *gcell=(GroupMemberCell*)cell;
        if (self.isowner)
        {
            gcell.personCount.text=[NSString stringWithFormat:@"共%ld人",self.dataArray.count-2];
        }else
        {
              gcell.personCount.text=[NSString stringWithFormat:@"共%ld人",self.dataArray.count-1];
        }
        
        if (self.dataArray.count) {
            
            [cell updateCellWithData:self.dataArray];
            
            DefineWeakSelf;
            cell.funBlock=^(id index){
                switch ([index intValue])
                {
                    case 0:
                        {
                            NSLog(@"删除");
                            deletOrAdd=NO;
                            [weakSelf addMemberAction];
                        }
                        break;
                        
                    case 1:
                    {
                            NSLog(@"添加");
                         deletOrAdd=YES;
                        [weakSelf addMemberAction];
                    }
                        break;
                }
            };
        }
     
    }
   
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }else
    {
        return 20;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
       
        CGFloat w=(ScreenWidth-35)/6;
        CGFloat k;
;
        k=(CGFloat)self.dataArray.count/6;
        NSInteger end=ceilf(k);

        return end*(w*63/50)+50;
        
    }else
    {
        return 45;
    }
}
#pragma mark mysever





#pragma mark slectdelegate
-(void )selectArray:(NSMutableArray *)array
{
  
    if (deletOrAdd) {
        
        NSLog(@"selectArray添加成员");
          [self addEMWithUserArray:array];
    }else
    {
        NSLog(@"selectArray删除成员");
         [self deletEMWithUserArray:array];
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
