//
//  ContractSlectedVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/23.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ContractSlectedVC.h"
#import "BaseTableViewCell.h"
#import "FMDBUserTable.h"
#import "MyfriendModel.h"
#import "GroupMember.h"
@interface ContractSlectedVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *seletArray;
@end

@implementation ContractSlectedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray=[NSMutableArray array];
    _seletArray=[NSMutableArray array];
    self.tableview.editing=YES;
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [addButton setTitle:@"完成" forState:UIControlStateNormal];
        addButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [addButton addTarget:self action:@selector(addMember) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
        self.navigationItem.rightBarButtonItem=addItem;
    

    if (self.deletOrAdd)
    {
        NSLog(@"添加成员");
        NSMutableArray *myfriends=[NSMutableArray arrayWithArray:[[FMDBUserTable shareInstance]getUserData]];
        
        NSMutableArray *idarray=[NSMutableArray array];
        for (NSObject *obj in self.exitArray) {
            if ([obj isKindOfClass:[GroupMember class]]) {
                GroupMember *model=(GroupMember*)obj;
                [idarray addObject:model.memberid];
            }
            
        }
        [myfriends enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MyfriendModel *model=(MyfriendModel*)obj;
            if ([idarray containsObject:model.friendid]) {
                [myfriends removeObject:model];
            }
            
        }];
        self.dataArray=myfriends;
    }else
    {
        NSLog(@"删除成员");
        NSMutableArray *array=[NSMutableArray array];
        for (NSObject *obj in _exitArray) {
            if ([obj isKindOfClass:[GroupMember class]]) {
                [array addObject:obj];
            }
        }
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                 GroupMember *model=(GroupMember*)obj;
                if ([model.memberid isEqualToString:UniqUserID]) {
                    [array removeObject:model];
                }
                
          
          
        }];
        self.dataArray =array;
//        NSLog(@"self.dataArray:%@",self.dataArray);
    }
  
    // Do any additional setup after loading the view from its nib.
}
#pragma mark action
-(void)addMember
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(selectArray:)]) {
        [self.delegate selectArray:self.seletArray];
        [self.navigationController popViewControllerAnimated:NO];
    }
}
#pragma mark -table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ContactListCell";
    BaseTableViewCell *cell = (BaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (_deletOrAdd) {
        MyfriendModel *model=self.dataArray[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:@"default_head"];
        cell.textLabel.text = model.friendnickname;
    }else
    {
        GroupMember *model=self.dataArray[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:@"default_head"];
        cell.textLabel.text = model.menickname;
    }
  
//    cell.username = username;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //选中数据
//    [self.selectorPatnArray addObject:self.array[indexPath.row]];
  
          [self.seletArray addObject:self.dataArray[indexPath.row]];

   
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    //从选中中取消
//    if (self.selectorPatnArray.count > 0) {
//
//        [self.selectorPatnArray removeObject:self.array[indexPath.row]];

        if (self.seletArray.count>0) {
            [self.seletArray removeObject:self.dataArray[indexPath.row]];
             
        }

  
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
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
