//
//  GruopManageVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/17.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "GruopManageVC.h"
#import "MyGroupModel.h"
#import "FMDBGroupTable.h"
#import "FMDBUserTable.h"
#import "GroupManagerCell.h"
#import "UIViewController+HUD.h"
#import "ContractManagerVC.h"
#import "MyfriendModel.h"
@interface GruopManageVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation GruopManageVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self.navigationController.navigationItem setHidesBackButton:YES animated:NO];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview.rowHeight=40;
    self.tableview.tableFooterView=[[UIView alloc]init];
    self.tableview.editing=YES;
    self.title=@"分组管理";
    [self rightButon];
    [self getAllGroups];
    // Do any additional setup after loading the view from its nib.
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
    //self.navigationItem.rightBarButtonItem=right;
}
-(void)done
{
//    for (MyfriendModel *model in [[FMDBUserTable shareInstance] getUserData]) {
//        if ([model.mygroupid isEqualToString:@"000002"]) {
//            model.mygroupid=@"000000";
//            [[FMDBUserTable shareInstance]updateUser:model];
//            break;
//        }
//    }
    
}
#pragma mark 懒加载
-(NSMutableArray *)dataArray
{

    if (!_dataArray) {
        self.dataArray=[NSMutableArray arrayWithArray:[[FMDBGroupTable shareInstance]getGroupData]];

    }
    return _dataArray;
}
//mysever增加分组
-(void)myseverinserGroup:(MyGroupModel*)model
{
    DefineWeakSelf;
     [self showHudInView:self.view hint:@""];
    [ContractManagerVC RegisterGroupAdd:model.groupname Success:^(id responseData) {
        [self hideHud];
        NSDictionary *dic=(NSDictionary*)responseData;
        NSLog(@"增加分组%@",dic);
      if ([dic[@"sysmodel"][@"blresult"] intValue])
      {
          [weakSelf inserGroup:model];
//           [weakSelf showHint:@"增加分组"];
//          [weakSelf getAllGroups];
      }
    } Fail:^(id erro) {
        
    }];
}
//mysever删除分组
-(void)myseverdeletGroup:(MyGroupModel*)model
{
     DefineWeakSelf;
    [self showHudInView:self.view hint:@""];
    [ContractManagerVC RegisterGroupDel:model.mygroupid Success:^(id responseData) {
        NSDictionary *dic=(NSDictionary*)responseData;
        [self hideHud];
        NSLog(@"删除分组%@",dic);
        if ([dic[@"sysmodel"][@"blresult"] intValue])
        {
            //更新好友
            NSArray *updtaArray=[MyfriendModel getDatawithdic:dic];
            for (MyfriendModel *model in updtaArray) {
                [[FMDBUserTable shareInstance]updateUser:model];
            }
            [weakSelf deletGroup:model];
      
        }
    } Fail:^(id erro) {
        
    }];
}
//mysever更新分组
-(void)myseverupdateGroup:(MyGroupModel*)model
{
    DefineWeakSelf;
    NSMutableArray *datalistArray=[NSMutableArray array];

        NSDictionary *dic=@{@"myid":UniqUserID,@"mygroupid":model.mygroupid,@"groupname":model.groupname};
        [datalistArray addObject:dic];
  
    [self showHudInView:self.view hint:@""];
    NSString *datalistStr=[DataProcess getJsonStrWithObj:datalistArray];
    [ContractManagerVC RegisterGroupEditWithDatalist:datalistStr Success:^(id responseData) {
        [self hideHud];
        NSDictionary *dic=(NSDictionary*)responseData;
        NSLog(@"更新分组%@",dic);
        if ([dic[@"sysmodel"][@"blresult"] intValue])
        {
            [weakSelf updateGroup:model];
        }
    } Fail:^(id erro) {
        
    }];
    
}
//sever获取所有的分组
-(void)getAllGroups
{
    DefineWeakSelf;
    [ContractManagerVC SystemCommonGroupWithMyid:UniqUserID Success:^(id responseData) {
        NSDictionary *dic=(NSDictionary*)responseData;
        NSLog(@"获取所有的分组%@",dic);
       
//        weakSelf.dataArray=[MyGroupModel getDatawithdic:dic];
//
//        [weakSelf.tableview reloadData];
    } Fail:^(id erro) {
        
    }];
}
//fmdb增加分组
-(void)inserGroup:(MyGroupModel*)model
{
    [[FMDBGroupTable shareInstance]insertGroup:model];
     self.dataArray=[NSMutableArray arrayWithArray:[[FMDBGroupTable shareInstance]getGroupData]];
    [self.tableview reloadData];
}
//fmdb 删除分组
-(void)deletGroup:(MyGroupModel*)model
{
    [[FMDBGroupTable shareInstance]deleteTable:model];
     self.dataArray=[NSMutableArray arrayWithArray:[[FMDBGroupTable shareInstance]getGroupData]];
    [self.tableview reloadData];
}
//fmdb分组改名字
-(void)updateGroup:(MyGroupModel*)model
{
    
    [[FMDBGroupTable shareInstance]updateGroup:model];
        self.dataArray=[NSMutableArray arrayWithArray:[[FMDBGroupTable shareInstance]getGroupData]];
    [self.tableview reloadData];
}

#pragma mark --table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return  self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"GroupManagerCell";
    GroupManagerCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"GroupManagerCell" owner:nil options:nil][0];
    }
    MyGroupModel *model=self.dataArray[indexPath.row];
    cell.gruopTextfield.text=model.groupname;
    cell.gruopTextfield.returnKeyType= UIReturnKeyDone;
    cell.gruopTextfield.delegate=self;
    cell.gruopTextfield.tag=indexPath.row+1;
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        [self showHint:@"默认分组不能被删除!"];
        return;
    }
    MyGroupModel *model=self.dataArray[indexPath.row];
    [self AlertControllerWithMessage:@"删除分组后,此分组的好友不会删除,会被分配到默认分组" Data:model];
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
#pragma mark textfield
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    MyGroupModel *model=self.dataArray[textField.tag-1];
    if ([model.groupname isEqualToString:textField.text]) {
        return;
    }else
        model.groupname=textField.text;
    [self myseverupdateGroup:model];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

#pragma mark UIAlertController
-(void)AlertControllerWithMessage:(NSString*)message Data:(MyGroupModel*)model
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:message  preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self myseverdeletGroup:model];
        
    }];
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)deletAlertView
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入群组名称" preferredStyle:UIAlertControllerStyleAlert];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取第1个输入框；
        UITextField *userNameTextField = alertController.textFields.firstObject;
        
        //获取第2个输入框；
//        UITextField *passwordTextField = alertController.textFields.lastObject;
        if (userNameTextField.text.length>0) {
         
            NSInteger k=[[FMDBGroupTable shareInstance]getGroupData].count+1;
            MyGroupModel *model=[[MyGroupModel alloc]init];
            model.mygroupid=[NSString stringWithFormat:@"00000%ld",(long)k];
            model.groupname=userNameTextField.text;
            [self myseverinserGroup:model];
        }else
        {
            [self showHint:@"群组名字为空!"];
            
        }
 
    }]];
    
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    
    //定义第一个输入框；
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入群组名称";
    }];
   
 
    
    [self presentViewController:alertController animated:true completion:nil];
    
}

#pragma mark action

- (IBAction)addGroup:(UIButton *)sender {
    [self deletAlertView];
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
