//
//  ZWHPersonViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/9/20.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHPersonViewController.h"
#import "ZWHMyHeaderView.h"
#import "ZWHPersonTableViewCell.h"
#import "UserModel.h"
#import "FriendsShowTBVC.h"

@interface ZWHPersonViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *personTable;

@property(nonatomic,strong)NSArray *titleArr;

@property(nonatomic,strong)ZWHMyHeaderView *ZWHheaderView;

@property(nonatomic,strong)UserModel *model;

@end

@implementation ZWHPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArr = @[@"标签",@"分组",@"备注",@"地区",@"里程",@"相册",@"签名"];
    [self getDataSource];
}

-(UIImage *)navigationBarBackgroundImage{
    return [UIImage new];
}


-(void)getDataSource{
    MJWeakSelf;
    [self showEmptyViewWithLoading];
    [HttpHandler getFriendDetail:@{@"para1":UniqUserID,@"para2":_userid} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        [self hideEmptyView];
        if (ReturnValue==1) {
            NSDictionary *dict = [HttpTool getArrayWithData:obj[@"sysmodel"][@"strresult"]][0];
            NSLog(@"%@",dict);
            weakSelf.model = [UserModel mj_objectWithKeyValues:dict];
            [self setUI];
        }else{
            [weakSelf showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(getDataSource)];
        }
    } failed:^(id obj) {
        [weakSelf hideEmptyView];
        [weakSelf showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(getDataSource)];
    }];
}

-(void)setUI{
    
    _personTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-HEIGHT_PRO(50)) style:UITableViewStylePlain];
    [self.view addSubview:_personTable];
    [_personTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    _personTable.delegate = self;
    _personTable.dataSource = self;
    _personTable.separatorStyle = 0;
    _personTable.backgroundColor = [UIColor whiteColor];
    _personTable.showsVerticalScrollIndicator = NO;
    [_personTable registerClass:[ZWHPersonTableViewCell class] forCellReuseIdentifier:@"ZWHPersonTableViewCell"];
    self.keyTableView = _personTable;
    
    _personTable.tableHeaderView = self.ZWHheaderView;
}

#pragma mark - <uitableviewdelegate>

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        ZWHPersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHPersonTableViewCell" forIndexPath:indexPath];
        cell.title.text = _titleArr[indexPath.row];
        cell.selectionStyle = 0;
        
        switch (indexPath.row) {
            case 0:
                cell.detail.text = self.model.label?self.model.label:@"";
                break;
            case 1:
                cell.detail.text = self.model.groupname;
                break;
            case 2:
                cell.detail.text = self.model.nickname?self.model.nickname:@"";
                break;
            case 3:
                cell.detail.text = self.model.area?self.model.area:@"";
                break;
            case 4:
                cell.detail.text = self.model.mileage?self.model.mileage:@"0里程";
                break;
            case 5:
                {
                    cell.imageArr = [self.model.piclist componentsSeparatedByString:@";"];
                }
                break;
            case 6:
                cell.detail.text = self.model.signature?self.model.signature:@"";
                break;
            default:
                break;
        }
        
        return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row==5?HEIGHT_PRO(80):HEIGHT_PRO(50);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 5) {
        //我型我秀
        FriendsShowTBVC *vc=[[FriendsShowTBVC alloc]init];
        vc.isSingle = YES;
        vc.singleUserid = _userid;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - getter

-(ZWHMyHeaderView *)ZWHheaderView{
    if (!_ZWHheaderView) {
        _ZWHheaderView = [[ZWHMyHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(200))];
        [_ZWHheaderView.img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,_model.logonurl]] placeholderImage:[UIImage imageNamed:@"default_head"]];
        _ZWHheaderView.name.text=_model.nickname;
        _ZWHheaderView.num.text=_model.myid;
        _ZWHheaderView.quit.hidden = YES;
    }
    return _ZWHheaderView;
}



@end
