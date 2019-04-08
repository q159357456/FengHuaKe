//
//  AddFriendVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "AddFriendVC.h"
#import "ContractManagerVC.h"
#import "UIViewController+HUD.h"
#import "SearchFriendCell.h"
#import "AddFriendModel.h"
#import "FMDBUserTable.h"
#import "FMDBGroupTable.h"
#import <Hyphenate/Hyphenate.h>
#import "ZWHNorSearchViewController.h"


@interface AddFriendVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableview;




@property(nonatomic,strong)NSString *searchStr;


@end

@implementation AddFriendVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-ZWHNavHeight-100) style:UITableViewStylePlain];
    [self.view addSubview:_tableview];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(ZWHNavHeight);
    }];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle = 0;
    _tableview.backgroundColor = [UIColor whiteColor];
    self.keyTableView = _tableview;
    
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(60))];
    headview.backgroundColor = [UIColor qmui_colorWithHexString:@"F8F8F8"];
    
    UIImage *img = [UIImage imageNamed:@"search"];
    QMUIButton *btn = [[QMUIButton alloc]qmui_initWithImage:img title:@"好友名字,ID"];
    btn.tintColorAdjustsTitleAndImage = [UIColor qmui_colorWithHexString:@"BBBBBB"];
    btn.layer.cornerRadius = 6;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = [UIColor whiteColor];
    btn.imagePosition = QMUIButtonImagePositionLeft;
    btn.spacingBetweenImageAndTitle = WIDTH_PRO(8);
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, WIDTH_PRO(15), 0, 0);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.layer.borderColor = [UIColor qmui_colorWithHexString:@"BBBBBB"].CGColor;
    btn.layer.borderWidth = 1;
    btn.titleLabel.font = HTFont(28);
    [headview addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(headview);
        make.width.mas_equalTo(WIDTH_PRO(275));
        make.height.mas_equalTo(HEIGHT_PRO(40));
    }];
    [btn addTarget:self action:@selector(toSearchController) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.tableview.tableHeaderView = headview;
    _tableview.bounces = NO;
}

#pragma mark - 跳转搜索
-(void)toSearchController{
    ZWHNorSearchViewController *vc = [[ZWHNorSearchViewController alloc]init];
    vc.state = 3;
    MJWeakSelf
    vc.contextBlock = ^(NSString *context) {
        NSLog(@"%@",context);
        weakSelf.searchStr = context;
        [weakSelf searchFriend];
    };
    [self.navigationController pushViewController:vc animated:NO];
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
    [ContractManagerVC UserListWithPara:_searchStr Success:^(id responseData) {
        [weakSelf hideHud];
        NSDictionary *dic=responseData;
        NSLog(@"searchFriend--%@",dic);
        weakSelf.dataArray=[AddFriendModel getDatawithdic:dic];
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
                        [self showHint:error.errorDescription];
                        NSLog(@"error.code:%u",error.code);
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
    AddFriendModel *model=self.dataArray[indexPath.row];
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,model.headurl]] placeholderImage:[UIImage imageNamed:ICONPL]];
    cell.titleLable.text=model.nickname;
    //cell.contentLable.text=model.myid;
    //判断是否已添加
    NSArray *friArray = [[FMDBUserTable shareInstance]getUserData];
    for (MyfriendModel *friModel in friArray) {
        if ([friModel.friendid isEqualToString:model.myid]) {
            [cell.agreeButt setTitleColor:ZWHCOLOR(@"#828282") forState:0];
            [cell.agreeButt setTitle:@"已添加" forState:0];
            cell.agreeButt.enabled = NO;
        }
    }
    DefineWeakSelf;
    cell.addFriendsBlock=^{
        [weakSelf addFriendWithUserID:model.myid WithMasage:[NSString stringWithFormat:@"%@请求添加为好友",userNickNmae]];
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
