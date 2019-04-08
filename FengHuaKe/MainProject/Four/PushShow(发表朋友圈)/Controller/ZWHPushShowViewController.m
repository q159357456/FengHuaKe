//
//  ZWHPushShowViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/9/11.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHPushShowViewController.h"
#import "ZWHPictureManageView.h"

@interface ZWHPushShowViewController ()

@property(nonatomic,strong)UITableView *pushTable;

@property(nonatomic,strong)QMUITextView *context;
//图片选择器
@property(nonatomic,strong)ZWHPictureManageView *pictureview;

@end

@implementation ZWHPushShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"内容";
    [self setUI];
}

-(void)setUI{
    
    _pushTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-ZWHNavHeight-100) style:UITableViewStyleGrouped];
    [self.view addSubview:_pushTable];
    [_pushTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(ZWHNavHeight);
    }];
    _pushTable.separatorStyle = 0;
    _pushTable.backgroundColor = [UIColor whiteColor];
    
    self.keyTableView = _pushTable;
    
    QMUIButton *btn = [[QMUIButton alloc]qmui_initWithImage:nil title:@"发表"];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    [btn addTarget:self action:@selector(sendFriendShow) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    
    self.pushTable.tableHeaderView = self.context;
    _context.placeholder = @"这一刻的想法...";
    self.pushTable.tableFooterView = self.pictureview;
    MJWeakSelf;
    _pictureview.changeBclok = ^(CGFloat height) {
        weakSelf.pushTable.tableFooterView = weakSelf.pictureview;
    };
}


#pragma mark - 发表
-(void)sendFriendShow{
    
    [self.view endEditing:YES];
    
    if (!(_context.text.length>0)) {
        [self showHint:@"说点什么吧"];
        return;
    }
    
    if (_pictureview.pictureDataArr.count>0) {
        //NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":UniqUserID,@"para2":_textView.text,@"para3":@"0",@"para4":@"0",@"para5":@"",@"blresult":@"true"}];
        //}];
        MJWeakSelf;
        [self showEmptyViewWithLoading];
        [HttpHandler getDynamicPublishDynamicImages:@{@"para1":UniqUserID,@"para2":_context.text,@"para3":@"0",@"para4":@"0",@"para5":@"",@"blresult":@"true"} dataList:@[] image:_pictureview.pictureDataArr start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
            [weakSelf hideEmptyView];
            if (ReturnValue == 1) {
                //[QMUITips showSucceed:@"发表成功"];
                NOTIFY_POST(NOTIF_SHOW);
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                
            }
        } failed:^(id obj) {
        }];
    }else{
        MJWeakSelf
        [self showEmptyViewWithLoading];
        [HttpHandler getDynamicPublishDynamic:@{@"para1":UniqUserID,@"para2":_context.text,@"para3":@"0",@"para4":@"0",@"para5":@"",@"blresult":@"true"} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
            [weakSelf hideEmptyView];
            if (ReturnValue == 1) {
                //[QMUITips showSucceed:@"发表成功"];
                NOTIFY_POST(NOTIF_SHOW);
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                
            }
        } failed:^(id obj) {
            
        }];
    }
}

#pragma mark - getter

-(ZWHPictureManageView *)pictureview{
    if (!_pictureview) {
        _pictureview = [[ZWHPictureManageView alloc]initWithNum:9 withRowNum:3];
    }
    return _pictureview;
}

-(QMUITextView *)context{
    if (!_context) {
        _context = [[QMUITextView alloc]init];
        _context.frame = CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(200));
        _context.font = HTFont(28);
    }
    return _context;
}


@end
