//
//  ZWHUploadPictureViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/9/11.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHUploadPictureViewController.h"
#import "ZWHPictureManageView.h"
#import "ZWHChoosePhotoTableViewCell.h"
#import "ChoosePhotoVC.h"
#import "ZWHBaseNavigationViewController.h"

@interface ZWHUploadPictureViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *pushTable;

@property(nonatomic,strong)QMUITextView *context;
//图片选择器
@property(nonatomic,strong)ZWHPictureManageView *pictureview;



@end

@implementation ZWHUploadPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上传照片";
    [self setUI];
}

-(void)setUI{
    
    _pushTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-ZWHNavHeight-100) style:UITableViewStylePlain];
    [self.view addSubview:_pushTable];
    [_pushTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(ZWHNavHeight);
    }];
    _pushTable.separatorStyle = 0;
    _pushTable.backgroundColor = [UIColor whiteColor];
    _pushTable.delegate = self;
    _pushTable.dataSource = self;
    [_pushTable registerClass:[ZWHChoosePhotoTableViewCell class] forCellReuseIdentifier:@"ZWHChoosePhotoTableViewCell"];
    self.keyTableView = _pushTable;
    
    QMUIButton *btn = [[QMUIButton alloc]qmui_initWithImage:nil title:@"确认"];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    [btn addTarget:self action:@selector(ZWHUploadPicture) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    
    self.pushTable.tableHeaderView = self.context;
    _context.placeholder = @"这一刻的想法...";
    self.pushTable.tableFooterView = self.pictureview;
    MJWeakSelf;
    _pictureview.changeBclok = ^(CGFloat height) {
        weakSelf.pushTable.tableFooterView = weakSelf.pictureview;
    };
}
#pragma mark - <uitableviewdelegate>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_PRO(40);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWHChoosePhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHChoosePhotoTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = 0;
    if (_model) {
        [cell.img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,_model.photos_logo_url]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
        cell.title.text = _model.name;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWHChoosePhotoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (_model) {
        return;
    }
    
    ChoosePhotoVC *vc=[[ChoosePhotoVC alloc]init];
    MJWeakSelf;
    vc.backBlock=^(UIImage *coverImage, NSString *name,NSString *photoCode){
        cell.img.image = coverImage;
        cell.title.text=name;
        weakSelf.code=photoCode;
    };
    ZWHBaseNavigationViewController *nav=[[ZWHBaseNavigationViewController alloc]initWithRootViewController:vc];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
    //[self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 上传
-(void)ZWHUploadPicture{
    
    [self.view endEditing:YES];
    
    if (!(_code.length>0)) {
        [self showHint:@"请选择相册"];
        return;
    }
    
    if (_pictureview.pictureDataArr.count==0) {
        [self showHint:@"请选择至少一张图片"];
        return;
    }
    MJWeakSelf;
    [self showEmptyViewWithLoading];
    [HttpHandler getDynamicPictureAdd:@{@"para1":self.code,@"para2":UniqUserID,@"para3":@"0",@"para4":@"0",@"para5":@"",@"para6":_context.text,@"blresult":@"true"} dataList:@[] image:_pictureview.pictureDataArr start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        [weakSelf hideEmptyView];
        if (ReturnValue==1) {
            NOTIFY_POST(weakSelf.model?NOTIF_PICTURE:NOTIF_PHOTO);
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [self showHint:@"添加失败，请重试"];
        }
    } failed:^(id obj) {
        
    }];
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
        _context.frame = CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(150));
        _context.font = HTFont(28);
        _context.qmui_borderColor = LINECOLOR;
        _context.qmui_borderWidth = 1;
        _context.qmui_borderPosition = QMUIViewBorderPositionBottom;
    }
    return _context;
}



@end
