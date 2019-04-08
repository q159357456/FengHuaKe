//
//  FriendsShowTBVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/3.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "FriendsShowTBVC.h"
#import <IQKeyboardManager.h>
#import "FriendsShowModel.h"
#import "FriendsShowCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"
#import "LEETheme.h"
#import "FriendsShowVM.h"
#import "PublishShowVC.h"
#import "UIViewController+HUD.h"
#import "FriendShowHeader.h"
#import "SeverPhotoManagerVC.h"
#import "ZWHPushShowViewController.h"


#define kTimeLineTableViewCellId @"FriendsShowCell"
static CGFloat textFieldH = 40;
@interface FriendsShowTBVC ()<FriendsShowDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, assign) BOOL isReplayingComment;
@property (nonatomic, strong) NSIndexPath *currentEditingIndexthPath;
@property (nonatomic, copy) NSString *commentToUser;
@property(nonatomic,strong)FriendShowHeader *header;

@property(nonatomic,assign)NSInteger index;

@property(nonatomic,strong)UITableView *fritableview;

@end

@implementation FriendsShowTBVC
{
   
    CGFloat _lastScrollViewOffsetY;
    CGFloat _totalKeybordHeight;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[DataProcess barImage] forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBarButtonItemAction:)];
    self.titleStr = @"我型我秀";
//    rightBarButtonItem.lee_theme
//    .LeeAddCustomConfig(DAY , ^(UIBarButtonItem *item){
//
//        item.title = @ "夜间";
//
//    }).LeeAddCustomConfig(NIGHT , ^(UIBarButtonItem *item){
//
//        item.title = @"日间";
//    });
//
//    //为self.view 添加背景颜色设置
//
//    self.view.lee_theme
//    .LeeAddBackgroundColor(DAY , [UIColor whiteColor])
//    .LeeAddBackgroundColor(NIGHT , [UIColor blackColor]);
    
    self.navigationItem.rightBarButtonItem = _isSingle?nil:item;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.edgesForExtendedLayout = UIRectEdgeTop;
    
//     [self.dataArray addObjectsFromArray:[self creatModelsWithCount:10]];
    
    
    //添加分隔线颜色设置
    
    _fritableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-HEIGHT_PRO(50)) style:UITableViewStylePlain];
    [self.view addSubview:_fritableview];
    [_fritableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(ZWHNavHeight);
    }];
    _fritableview.delegate = self;
    _fritableview.dataSource = self;
    //_fritableview.separatorStyle = 0;
    _fritableview.backgroundColor = LINECOLOR;
    _fritableview.showsVerticalScrollIndicator = NO;
    [self.fritableview registerClass:[FriendsShowCell class] forCellReuseIdentifier:kTimeLineTableViewCellId];
    self.fritableview.tableFooterView=[[UIView alloc]init];
    self.fritableview.tableHeaderView= _isSingle?nil:self.header;
    self.fritableview.lee_theme
    .LeeAddSeparatorColor(DAY , [[UIColor lightGrayColor] colorWithAlphaComponent:0.5f])
    .LeeAddSeparatorColor(NIGHT , [[UIColor grayColor] colorWithAlphaComponent:0.5f]);
    self.keyTableView = _fritableview;
    
    /*self.tableView.lee_theme
    .LeeAddSeparatorColor(DAY , [[UIColor lightGrayColor] colorWithAlphaComponent:0.5f])
    .LeeAddSeparatorColor(NIGHT , [[UIColor grayColor] colorWithAlphaComponent:0.5f]);
    
    [self.tableView registerClass:[FriendsShowCell class] forCellReuseIdentifier:kTimeLineTableViewCellId];
    self.tableView.tableFooterView=[[UIView alloc]init];
    self.tableView.tableHeaderView= _isSingle?nil:self.header;
    self.keyTableView = self.tableView;*/
    
    [self setupTextField];
    
    //[self getFrienssShowData];
    [self setRefresh];
    NOTIFY_ADD(refreshFriendshow, NOTIF_SHOW);
}
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
    NOTIFY_REMOVE(UIKeyboardWillChangeFrameNotification);
    [_textField resignFirstResponder];
}

//通知刷新朋友圈
-(void)refreshFriendshow{
    [self.fritableview.mj_header beginRefreshing];
}


- (void)dealloc
{
    NOTIFY_REMOVE(NOTIF_SHOW);
    [_textField removeFromSuperview];
}
- (void)setupTextField
{
    _textField = [UITextField new];
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.delegate = self;
    _textField.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8].CGColor;
    _textField.layer.borderWidth = 1;
    
    //为textfield添加背景颜色 字体颜色的设置 还有block设置 , 在block中改变它的键盘样式 (当然背景颜色和字体颜色也可以直接在block中写)
    
    _textField.lee_theme
    .LeeAddBackgroundColor(DAY , [UIColor whiteColor])
    .LeeAddBackgroundColor(NIGHT , [UIColor blackColor])
    .LeeAddTextColor(DAY , [UIColor grayColor])
    .LeeAddTextColor(NIGHT , [UIColor grayColor])
    .LeeAddCustomConfig(DAY , ^(UITextField *item){
        
        item.keyboardAppearance = UIKeyboardAppearanceDefault;
        if ([item isFirstResponder]) {
            [item resignFirstResponder];
            [item becomeFirstResponder];
        }
    }).LeeAddCustomConfig(NIGHT , ^(UITextField *item){
        
        item.keyboardAppearance = UIKeyboardAppearanceDark;
        if ([item isFirstResponder]) {
            [item resignFirstResponder];
            [item becomeFirstResponder];
        }
    });
    
    _textField.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.view.width_sd, textFieldH);
    [[UIApplication sharedApplication].keyWindow addSubview:_textField];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.textColor = [UIColor blackColor];
    
    [_textField becomeFirstResponder];
    [_textField resignFirstResponder];
}
// 右栏目按钮点击事件

- (void)rightBarButtonItemAction:(UIBarButtonItem *)sender{
    
    //PublishShowVC *vc=[[PublishShowVC alloc]init];
    ZWHPushShowViewController *vc = [[ZWHPushShowViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
//    if ([[LEETheme currentThemeTag] isEqualToString:DAY]) {
//
//        [LEETheme startTheme:NIGHT];
//
//    } else {
//        [LEETheme startTheme:DAY];
//    }
}
#pragma mark net
-(void)getFrienssShowData
{
    DefineWeakSelf;
    [FriendsShowVM DynamicGetFriendCirclePara1:UniqUserID Startindex:@"1" Endindex:@"10" Success:^(id responseData) {
        NSDictionary *dic=(NSDictionary*)responseData;
       
        self.dataArray=[FriendsShowModel getDatawithdic:dic];
        [weakSelf.fritableview reloadData];
    } Fail:^(id erro) {
        
    }];
}

-(void)getDataSource{
    NSNumber *startIndex = [NSNumber numberWithInteger:_index];
    MJWeakSelf
    if (_isSingle) {
        [HttpHandler getSingleDynamic:@{@"para1":_singleUserid} start:startIndex end:@10 querytype:@"0" Success:^(id obj) {
            NSLog(@"%@",obj);
            if (ReturnValue == 1) {
                NSArray *ary = obj[@"DataList"];
                if (ary.count == 0) {
                    [weakSelf.fritableview.mj_header endRefreshing];
                    weakSelf.fritableview.mj_footer.hidden = YES;
                }else{
                    [weakSelf.dataArray addObjectsFromArray: [FriendsShowModel getDatawithdic:obj]];
                    [weakSelf.fritableview.mj_header endRefreshing];
                    [weakSelf.fritableview.mj_footer endRefreshing];
                    weakSelf.fritableview.mj_footer.hidden = NO;
                }
                [weakSelf.fritableview reloadData];
            }
        } failed:^(id obj) {
            [weakSelf.fritableview.mj_header endRefreshing];
            [weakSelf.fritableview.mj_footer endRefreshing];
        }];
    }else{
        [HttpHandler getDynamicGetFriendCircle:@{@"para1":UniqUserID} start:startIndex end:@10 querytype:@"0" Success:^(id obj) {
            NSLog(@"%@",obj);
            if (ReturnValue == 1) {
                NSArray *ary = obj[@"DataList"];
                if (ary.count == 0) {
                    [weakSelf.fritableview.mj_header endRefreshing];
                    weakSelf.fritableview.mj_footer.hidden = YES;
                }else{
                    [weakSelf.dataArray addObjectsFromArray: [FriendsShowModel getDatawithdic:obj]];
                    [weakSelf.fritableview.mj_header endRefreshing];
                    [weakSelf.fritableview.mj_footer endRefreshing];
                    weakSelf.fritableview.mj_footer.hidden = NO;
                }
                [weakSelf.fritableview reloadData];
            }
        } failed:^(id obj) {
            [weakSelf.fritableview.mj_header endRefreshing];
            [weakSelf.fritableview.mj_footer endRefreshing];
        }];
    }
    
}

-(void)setRefresh{
    MJWeakSelf
    self.fritableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.dataArray = [NSMutableArray array];
        weakSelf.index = 1;
        [weakSelf getDataSource];
    }];
    self.fritableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        weakSelf.index ++ ;
        [weakSelf getDataSource];
    }];
    [self.fritableview.mj_header beginRefreshing];
}


#pragma mark -table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendsShowCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimeLineTableViewCellId];
    cell.indexPath = indexPath;
    __weak typeof(self) weakSelf = self;
    if (!cell.moreButtonClickedBlock) {
        [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
            FriendsShowModel *model = weakSelf.dataArray[indexPath.row];
            model.isOpening = !model.isOpening;
            [weakSelf.fritableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
        
        [cell setDidClickCommentLabelBlock:^(NSString *commentId, CGRect rectInWindow, NSIndexPath *indexPath) {
            weakSelf.textField.placeholder = [NSString stringWithFormat:@"  回复：%@", commentId];
            weakSelf.currentEditingIndexthPath = indexPath;
            [weakSelf.textField becomeFirstResponder];
            weakSelf.isReplayingComment = YES;
            weakSelf.commentToUser = commentId;
            [weakSelf adjustTableViewToFitKeyboardWithRect:rectInWindow];
        }];
        
        cell.delegate = self;
    }
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    ///////////////////////////////////////////////////////////////////////
  
    cell.model = self.dataArray[indexPath.row];
  
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    id model = self.dataArray[indexPath.row];
    return [self.fritableview cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[FriendsShowCell class] contentViewWidth:[self cellContentViewWith]];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_textField resignFirstResponder];
    _textField.placeholder = nil;
}



- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}



#pragma mark -set/get
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
-(FriendShowHeader *)header
{
    if (!_header) {
        _header=[[FriendShowHeader alloc]init];
        _header.frame=CGRectMake(0, 0, ScreenWidth, 60);
        DefineWeakSelf;
        _header.funBlock=^(NSInteger index){
            switch (index) {
                case 1:
                {
                    
                }
                    break;
                case 2:
                {
                    SeverPhotoManagerVC *vc=[[SeverPhotoManagerVC alloc]init];
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 3:
                {
                    
                }
                    break;
         
            }
        };
    }
    return _header;
}
#pragma mark - SDTimeLineCellDelegate

- (void)didClickcCommentButtonInCell:(UITableViewCell *)cell
{
    [_textField becomeFirstResponder];
    _currentEditingIndexthPath = [self.fritableview indexPathForCell:cell];
    
    [self adjustTableViewToFitKeyboard];
  
    
}

- (void)didClickLikeButtonInCell:(UITableViewCell *)cell
{
    [self NetlikeInCell:cell];
}

-(void)deletComentComment:(CommentItemModel *)model InCell:(UITableViewCell *)cell
{
    [self alertShowInCell:cell Comment:model];
    
   
}
-(void)deletCellWithModel:(FriendsShowModel *)model
{
    if (model) {
        [self NetdeletStatuesWithFriendsModel:model];
    }
}
#pragma mark -ui(点赞/取消，评论/删除评论，删除该动态)
-(void)LikeInCell:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.fritableview indexPathForCell:cell];
    FriendsShowModel *model = self.dataArray[index.row];
    NSMutableArray *temp = [NSMutableArray arrayWithArray:model.LikeList];
    
    if ([model.melike boolValue]) {
        LikeItemMode *likeModel = [LikeItemMode new];
        likeModel.nickname = userNickNmae;
        likeModel.memberid = UniqUserID;
        [temp addObject:likeModel];
        model.liked = YES;
    } else {
        LikeItemMode *tempLikeModel = nil;
        for (LikeItemMode *likeModel in model.LikeList) {
            if ([likeModel.memberid isEqualToString:UniqUserID]) {
                tempLikeModel = likeModel;
                break;
            }
        }
        [temp removeObject:tempLikeModel];
        model.liked = NO;
    }
    model.LikeList = [temp copy];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.fritableview reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
    });
}
- (void)CommentInCell:(FriendsShowModel *)model Text:(NSString*)text
{
    NSMutableArray *temp = [NSMutableArray new];
    [temp addObjectsFromArray:model.CommentList];
    CommentItemModel *commentItemModel = [CommentItemModel new];
    
    if (self.isReplayingComment) {
        commentItemModel.nickname = userNickNmae;
        commentItemModel.memberid = UniqUserID;
        commentItemModel.secondUserName = self.commentToUser;
        commentItemModel.secondUserId = self.commentToUser;
        commentItemModel.details = text;
        
        self.isReplayingComment = NO;
    } else {
        commentItemModel.nickname= userNickNmae;
        commentItemModel.details = text;
        commentItemModel.memberid = UniqUserID;
    }
    [temp addObject:commentItemModel];
    model.CommentList = [temp copy];
    [self.fritableview reloadRowsAtIndexPaths:@[_currentEditingIndexthPath] withRowAnimation:UITableViewRowAnimationNone];
    
}
//删除评论
-(void)DeletCommentInCell:(UITableViewCell *)cell Comment:(CommentItemModel*)mdel
{
    NSIndexPath *path=[self.fritableview indexPathForCell:cell];
    FriendsShowModel *fmodel=self.dataArray[path.row];
    NSMutableArray *temp = [NSMutableArray new];
    [temp addObjectsFromArray:fmodel.CommentList];
    [temp removeObject:mdel];
    fmodel.CommentList=[temp copy];
        [self.fritableview reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
    
}

#pragma mark - net(点赞/取消，评论/删除评论，删除该动态)
-(void)NetlikeInCell:(UITableViewCell *)cell
{
    /**
     点赞
     sysmodel.para1:会员ID，sysmodel.para2:被点赞动态的code；intresult:【1、朋友圈；2、评论；3、照片】；sysmodel.blresult：是否为取消点赞
     */
    NSIndexPath *index = [self.fritableview indexPathForCell:cell];
    FriendsShowModel *model = self.dataArray[index.row];
    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":UniqUserID,@"para2":model.code,@"intresult":@"1",@"blresult":model.melike/*[model.melike boolValue]?@"false":@"true"*/}];
    DefineWeakSelf;
    [FriendsShowVM DynamicLikeSysmodel:sysmodel Success:^(id responseData) {
        NSDictionary *dic=(NSDictionary*)responseData;
        NSLog(@"%@",dic);
        if ([dic[@"sysmodel"][@"blresult"] intValue]) {
            //更改点赞状态
            if (model.melike.boolValue) {
                model.melike=@"false";
            }else
            {
                model.melike=@"true";
            }
            [weakSelf LikeInCell:cell];
        
//            [weakSelf.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:NO];
        }else
        {
            [self showHint:dic[@"sysmodel"][@" strresult"]];
        }
    
    } Fail:^(id erro) {
        
    }];
}
-(void)NetcommentInCell:(FriendsShowModel *)model Text:(NSString*)text
{
    /**
     评论 parenttype：类型【W:我行我素；P:照片；C:评论；S:商品】；parentid：上级序号；memberid：【用户编号】；details：【内容】
     */
  
    NSString *datalsit=[DataProcess getJsonStrWithObj:@[@{@"parenttype":@"W",@"parentid":model.code,@"memberid":UniqUserID,@"details":text}]];
    DefineWeakSelf;
    [FriendsShowVM DynamicCommentAddDataList:datalsit Success:^(id responseData) {
         NSDictionary *dic=(NSDictionary*)responseData;
        NSLog(@"comment%@",dic);
        if ([dic[@"sysmodel"][@"blresult"] intValue]) {
            [weakSelf CommentInCell:model Text:text];
        }else
        {
            [self showHint:dic[@"sysmodel"][@"strresult"]];
        }
    } Fail:^(id erro) {
        
    }];
}
//删除评论
-(void)NetDeletCommentInCell:(UITableViewCell *)cell Comment:(CommentItemModel*)mdel
{
    /**
     评论删除
     sysmodel.para1：评论ID，sysmodel.para2：上级动态ID，sysmodel.para3：评论类型（W:我行我素；P:照片；C:评论；S:商品），sysmodel.para4：操作人ID
     */
    DefineWeakSelf;
    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":mdel.code,@"para2":mdel.parentid,@"para3":@"W",@"para4":UniqUserID}];
    [FriendsShowVM DynamicCommentDelSysmodel:sysmodel Success:^(id responseData) {
        NSDictionary *dic=(NSDictionary*)responseData;
        NSLog(@"comment%@",dic);
        if ([dic[@"sysmodel"][@"blresult"] intValue]) {
            [weakSelf DeletCommentInCell:cell Comment:mdel];
        }else
        {
            [self showHint:dic[@"sysmodel"][@"strresult"]];
        }
    } Fail:^(id erro) {
        
    }];
}
//删除说说
-(void)NetdeletStatuesWithFriendsModel:(FriendsShowModel*)model
{
    // sysmodel.para1：动态ID，sysmodel.para2：操作人ID
    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":model.code,@"para2":UniqUserID}];
    DefineWeakSelf;
    [FriendsShowVM DynamicDynamicDelSysmodel:sysmodel Success:^(id responseData) {
        NSDictionary *dic=(NSDictionary*)responseData;
        NSLog(@"comment%@",dic);
        if ([dic[@"sysmodel"][@"blresult"] intValue]) {
            [weakSelf.dataArray removeObject:model];
            [weakSelf.fritableview reloadData];
            [self showHint:@"删除成功!"];
        }else
        {
            [self showHint:dic[@"sysmodel"][@"strresult"]];
        }
    } Fail:^(id erro) {
        
    }];
}


#pragma mark - alert
-(void)alertShowInCell:(UITableViewCell *)cell Comment:(CommentItemModel*)mdel
{
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"是否删除该评论?" message:mdel.details preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self NetDeletCommentInCell:cell Comment:mdel];
        
    }];
    [alert addAction:action1];
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
#pragma mark - private
- (void)adjustTableViewToFitKeyboard
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UITableViewCell *cell = [self.fritableview cellForRowAtIndexPath:_currentEditingIndexthPath];
    CGRect rect = [cell.superview convertRect:cell.frame toView:window];
    [self adjustTableViewToFitKeyboardWithRect:rect];
}

- (void)adjustTableViewToFitKeyboardWithRect:(CGRect)rect
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGFloat delta = CGRectGetMaxY(rect) - (window.bounds.size.height - _totalKeybordHeight);
    
    CGPoint offset = self.fritableview.contentOffset;
    offset.y += delta;
    if (offset.y < 0) {
        offset.y = 0;
    }
    
    [self.fritableview setContentOffset:offset animated:YES];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length) {
        [_textField resignFirstResponder];
        
        FriendsShowModel *model = self.dataArray[_currentEditingIndexthPath.row];
        [self NetcommentInCell:model Text:_textField.text];
        
        _textField.text = @"";
        _textField.placeholder = nil;
        
        return YES;
    }
    return NO;
}



- (void)keyboardNotification:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    CGRect rect = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    
    
    CGRect textFieldRect = CGRectMake(0, rect.origin.y - textFieldH, rect.size.width, textFieldH);
    if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
        textFieldRect = rect;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        _textField.frame = textFieldRect;
    }];
    
    CGFloat h = rect.size.height + textFieldH;
    if (_totalKeybordHeight != h) {
        _totalKeybordHeight = h;
        [self adjustTableViewToFitKeyboard];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
