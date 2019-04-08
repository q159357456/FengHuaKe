//
//  SeverPhotoManagerVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/10.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "SeverPhotoManagerVC.h"
#import "FriendsShowVM.h"
#import "SeverPictureManagerVC.h"
#import "AlertView.h"
#import "UIViewController+HUD.h"
#import "UpLoadPicToPhotoVC.h"
#import "ZWHUploadPictureViewController.h"

@interface SeverPhotoManagerVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)AlertView *alertView;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,assign)NSInteger index;


@end

@implementation SeverPhotoManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的相册";
    _dataArray=[NSMutableArray array];
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-ZWHNavHeight-100) style:UITableViewStylePlain];
    [self.view addSubview:_tableview];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(ZWHNavHeight);
        make.bottom.equalTo(self.view).offset(-HEIGHT_PRO(50));
    }];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle = 0;
    _tableview.backgroundColor = [UIColor whiteColor];
    [_tableview registerNib:[UINib nibWithNibName:@"PhtoManagerCell" bundle:nil] forCellReuseIdentifier:@"PhtoManagerCell"];
    self.keyTableView = _tableview;
    
    [self setRefresh];
    
    UIButton *creatButton=[UIButton new];
    [creatButton setTitle:@"创建相册" forState:UIControlStateNormal];
    creatButton.backgroundColor=MainColor;
    [creatButton addTarget:self action:@selector(creat) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:creatButton];
    [creatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(HEIGHT_PRO(50));
    }];
    [self rightItem];
    NOTIFY_ADD(zwhRefreshPhoto, NOTIF_PHOTO);
}
#pragma mark - 通知刷新
-(void)zwhRefreshPhoto{
    [self.tableview.mj_header beginRefreshing];
}

-(void)dealloc{
    NOTIFY_REMOVEALL;
}

-(void)rightItem
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(uploadPic)];
    self.navigationItem.rightBarButtonItem=item;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
}
#pragma maek - action
-(void)creat
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.alertView];
}
-(void)uploadPic
{
    ZWHUploadPictureViewController *vc=[[ZWHUploadPictureViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - set/get
-(AlertView *)alertView
{
    if (!_alertView) {
        DefineWeakSelf;
        _alertView=[[AlertView alloc]initAltetViewWithBlock:^(NSString *name, NSString *des, NSInteger publish) {
            if (name.length==0) {
                  [self showHint:@"名称不能为空!"];
                return ;
            }
            if (des.length==0) {
                des=@"";
            }
            [weakSelf creatPhotoWithName:name Des:des Publish:publish];
            
            
        }];
    }
    return _alertView;
}

#pragma mark - net

-(void)getDataSource{
    NSNumber *startIndex = [NSNumber numberWithInteger:_index];
    MJWeakSelf
    [HttpHandler getDynamicPhotos:@{@"para1":UniqUserID,@"para2":UniqUserID} start:startIndex end:@10 querytype:@"0" Success:^(id obj) {
        NSLog(@"%@",obj);
        if (ReturnValue == 1) {
            NSArray *ary = obj[@"DataList"];
            if (ary.count == 0) {
                [weakSelf.tableview.mj_header endRefreshing];
                weakSelf.tableview.mj_footer.hidden = YES;
            }else{
                [weakSelf.dataArray addObjectsFromArray: [PhotoManagerModel mj_objectArrayWithKeyValuesArray:ary]];
                [weakSelf.tableview.mj_header endRefreshing];
                [weakSelf.tableview.mj_footer endRefreshing];
                weakSelf.tableview.mj_footer.hidden = NO;
            }
            [weakSelf.tableview reloadData];
            if (weakSelf.dataArray.count==0) {
                [weakSelf showEmptyViewWithImage:[UIImage imageNamed:@"nodata"] text:@"" detailText:@"" buttonTitle:@"" buttonAction:nil];
            }else{
                [weakSelf hideEmptyView];
            }
        }
    } failed:^(id obj) {
        [weakSelf.tableview.mj_header endRefreshing];
        [weakSelf.tableview.mj_footer endRefreshing];
    }];
}

-(void)setRefresh{
    MJWeakSelf
    _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.dataArray = [NSMutableArray array];
        weakSelf.index = 1;
        [weakSelf getDataSource];
    }];
    _tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        weakSelf.index ++ ;
        [weakSelf getDataSource];
    }];
    [_tableview.mj_header beginRefreshing];
}


//创建相册
-(void)creatPhotoWithName:(NSString*)name Des:(NSString*)des Publish:(NSInteger)publish
{
    /**
     相册添加、返回当前相册
     DataList.memberid：相册所属人，DataList.name：相册名称  remark描述  publicif是否公开
     */
    NSString *datalist=[DataProcess getJsonStrWithObj:@[@{@"memberid":UniqUserID,@"name":name,@"remark":des,@"publicif":[NSString stringWithFormat:@"%ld",publish]}]];
    DefineWeakSelf;
    [FriendsShowVM DynamicPhotosAddDataList:datalist Success:^(id responseData) {
        NSLog(@"responseData:%@",responseData);
        NSDictionary *dic=(NSDictionary*)responseData;
        if ([dic[@"sysmodel"][@"blresult"] intValue]) {
            
            [weakSelf showHint:@"创建成功!"];
            [weakSelf.tableview.mj_header beginRefreshing];
            
        }else
        {
            [weakSelf showHint:dic[@"sysmodel"][@"msg"]];
            
        }
    } Fail:^(id erro) {
        
    }];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    PhtoManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhtoManagerCell" forIndexPath:indexPath];
    PhotoManagerModel *model=self.dataArray[indexPath.row];
    cell.lable1.text=model.name;
    cell.lable2.text=model.remark;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [cell.imageview sd_setImageWithURL:[NSURL URLWithString:[DataProcess PicAdress:model.photos_logo_url]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PhotoManagerModel *model=self.dataArray[indexPath.row];
    SeverPictureManagerVC *vc=[[SeverPictureManagerVC alloc]init];
    vc.code=model.code;
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
    
}
//侧滑允许编辑cell
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//执行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    PhotoManagerModel *model=self.dataArray[indexPath.row];
    //[self deletPhotoWithPhotoModel:model];
    NSString *datalist=[DataProcess getJsonStrWithObj:@[@{@"code":model.code,@"memberid":UniqUserID}]];
    DefineWeakSelf;
    [FriendsShowVM DynamicPhotosDelDataList:datalist Success:^(id responseData) {
        NSLog(@"responseData:%@",responseData);
        NSDictionary *dic=(NSDictionary*)responseData;
        if ([dic[@"sysmodel"][@"blresult"] intValue]) {
            
            [weakSelf showHint:@"删除成功!"];
            [weakSelf.dataArray removeObject:model];
            [weakSelf.tableview deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }else
        {
            [self showHint:dic[@"sysmodel"][@"msg"]];
            
        }
    } Fail:^(id erro) {
        
    }];
    
}
//侧滑出现的文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}



@end
