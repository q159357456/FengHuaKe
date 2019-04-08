//
//  ZWHAfterSaleViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/29.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHAfterSaleViewController.h"
#import "ZWHPictureManageView.h"
#import "ZWHOrderListTableViewCell.h"
#import "ZWHChooseBtnTableViewCell.h"
#import "ZWHResonTableViewCell.h"
#import "ZWHAdvertModel.h"

@interface ZWHAfterSaleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *detailTable;

//图片选择器
@property(nonatomic,strong)ZWHPictureManageView *pictureview;

//服务类型
@property(nonatomic,strong)QMUIButton *seleTypeBtn;
//原因
@property(nonatomic,assign)NSInteger resonIndex;
//退款方式
@property(nonatomic,assign)NSInteger backIndex;

@property(nonatomic,strong)NSString *resonStr;


//是否可编辑
@property(nonatomic,assign)BOOL isedit;

//展示图片
@property(nonatomic,strong)UIView *showPicturView;

@end

@implementation ZWHAfterSaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请申请售后";
    _resonIndex = 0;
    _backIndex = 0;
    _isedit = YES;
    if (_Aftermodel) {
        _isedit = NO;
        _resonIndex = [_Aftermodel.reason isEqualToString:@"质量问题"]?0:1;
        _backIndex = [_Aftermodel.refundway isEqualToString:@"原路返回"]?0:1;
        _resonStr = _Aftermodel.context;
    }
    [self setUI];
    [self setHeader];
}

-(void)setUI{
    
    _detailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-ZWHNavHeight-100) style:UITableViewStylePlain];
    [self.view addSubview:_detailTable];
    [_detailTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(ZWHNavHeight);
        make.bottom.equalTo(self.view).offset(-HEIGHT_PRO(60));
    }];
    _detailTable.delegate = self;
    _detailTable.dataSource = self;
    _detailTable.separatorStyle = 0;
    _detailTable.backgroundColor = [UIColor whiteColor];
    [_detailTable registerClass:[ZWHOrderListTableViewCell class] forCellReuseIdentifier:@"ZWHOrderListTableViewCell"];
    [_detailTable registerClass:[ZWHChooseBtnTableViewCell class] forCellReuseIdentifier:@"ZWHChooseBtnTableViewCell"];
    [_detailTable registerClass:[ZWHResonTableViewCell class] forCellReuseIdentifier:@"ZWHResonTableViewCell"];
    self.keyTableView = _detailTable;
    
    self.detailTable.tableFooterView = self.pictureview;
    MJWeakSelf;
    _pictureview.changeBclok = ^(CGFloat height) {
        weakSelf.detailTable.tableFooterView = weakSelf.pictureview;
    };
    
    
    QMUIButton *btn = [[QMUIButton alloc]init];
    [btn setTitle:@"提交申请" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.backgroundColor = MAINCOLOR;
    btn.layer.cornerRadius = 6;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(applyBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-HEIGHT_PRO(15));
        make.width.mas_equalTo(WIDTH_PRO(220));
        make.height.mas_equalTo(HEIGHT_PRO(40));
        make.centerX.equalTo(self.view);
    }];
    
    
    if (_Aftermodel) {
        [_detailTable mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(ZWHNavHeight);
            make.bottom.equalTo(self.view);
        }];
        btn.hidden = YES;
        //判断是否有图片
        if (_Aftermodel.PicList.count >0) {
            NSMutableArray *urlArr = [NSMutableArray array];
            for (ZWHAdvertModel *admodel in _Aftermodel.PicList) {
                [urlArr addObject:[NSString stringWithFormat:@"%@%@",SERVER_IMG,admodel.url]];
            }
            _pictureview.pictureURLArr = urlArr;
        }else{
            self.detailTable.tableFooterView = nil;
        }
    }
}

-(void)setHeader{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(70))];
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = LINECOLOR;
    [headerView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(headerView);
        make.height.mas_equalTo(HEIGHT_PRO(10));
    }];
    
    QMUILabel *title = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:[UIColor blackColor]];
    title.text = @"服务类型";
    [headerView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(headerView).offset(WIDTH_PRO(8));
    }];
    NSArray *titleArr = @[@"维修",@"退货",@"换货"];
    for(NSInteger i=0;i<titleArr.count;i++){
        QMUIButton *btn = [[QMUIButton alloc]init];
        btn.tag = i;
        btn.tintColorAdjustsTitleAndImage = i==0?MAINCOLOR:ZWHCOLOR(@"AAAAAA");
        [btn addTarget:self action:@selector(chooseTypeWith:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:titleArr[i] forState:0];
        btn.layer.borderColor = ZWHCOLOR(@"AAAAAA").CGColor;
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        btn.contentEdgeInsets = UIEdgeInsetsMake(6, 20, 6, 20);
        if (i==0) {
            btn.layer.borderColor = MAINCOLOR.CGColor;
            _seleTypeBtn = btn;
        }
        //判断是否是展示状态
        if (_Aftermodel) {
            btn.userInteractionEnabled = _isedit;
            if ([btn.titleLabel.text isEqualToString:_Aftermodel.classify]) {
                btn.tintColorAdjustsTitleAndImage = MAINCOLOR;
                btn.layer.borderColor = MAINCOLOR.CGColor;
            }else{
                btn.tintColorAdjustsTitleAndImage = ZWHCOLOR(@"AAAAAA");
                btn.layer.borderColor = ZWHCOLOR(@"AAAAAA").CGColor;
            }
        }
        
        
        [headerView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WIDTH_PRO(8)*(i+1)+WIDTH_PRO(70)*i);
            make.width.mas_equalTo(WIDTH_PRO(70));
            make.height.mas_equalTo(HEIGHT_PRO(25));
            make.top.equalTo(title.mas_bottom).offset(HEIGHT_PRO(6));
        }];
    }
    
    
    self.detailTable.tableHeaderView = headerView;
}


#pragma mark - 选择服务类型
-(void)chooseTypeWith:(QMUIButton *)btn{
    _seleTypeBtn.tintColorAdjustsTitleAndImage = ZWHCOLOR(@"AAAAAA");
    _seleTypeBtn.layer.borderColor = ZWHCOLOR(@"AAAAAA").CGColor;
    
    btn.tintColorAdjustsTitleAndImage = MAINCOLOR;
    btn.layer.borderColor = MAINCOLOR.CGColor;
    
    _seleTypeBtn = btn;
}



#pragma mark - uitbaleviewdelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section==0?3:1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            ZWHOrderListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHOrderListTableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = 0;
            cell.model = _model?_model:_Aftermodel;
            return cell;
        }else if(indexPath.row==1){
            ZWHChooseBtnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHChooseBtnTableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = 0 ;
            cell.title.text = @"申请原因";
            cell.titleArr = @[@"质量问题",@"其他"];
            cell.seleIndex = _resonIndex;
            cell.userInteractionEnabled = _isedit;
            cell.returnIndex = ^(NSInteger index) {
                _resonIndex = index;
            };
            return cell;
        }else{
            ZWHChooseBtnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHChooseBtnTableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = 0 ;
            cell.title.text = @"退款方式";
            cell.titleArr = @[@"原路返回",@"余额账户"];
            cell.seleIndex = _backIndex;
            cell.userInteractionEnabled = _isedit;
            cell.returnIndex = ^(NSInteger index) {
                _backIndex = index;
            };
            return cell;
        }
    }else{
        ZWHResonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHResonTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        cell.title.text = @"问题描述";
        cell.textView.placeholder = @"请在此描述此问题(不超过200个字)";
        cell.textView.maximumTextLength = 200;
        cell.textView.text = _resonStr;
        cell.textView.editable = _isedit;
        [cell didEndInput:^(NSString *input) {
            _resonStr = input;
        }];
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return indexPath.row==0?HEIGHT_PRO(80):HEIGHT_PRO(60);
    }
    return HEIGHT_PRO(160);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}


#pragma mark - 提交申请
-(void)applyBtnMethod:(QMUIButton *)btn{
    NSLog(@"%ld------%ld-----%@",_resonIndex,_backIndex,_resonStr);
    [self.view endEditing:YES];
    if (!(_resonStr.length>0)) {
        [self showHint:@"请填写问题描述"];
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:_model.shopid forKey:@"shopid"];
    [dict setValue:_model.billno forKey:@"billno"];
    [dict setValue:_model.productno forKey:@"productno"];
    [dict setValue:_model.proname forKey:@"proname"];
    [dict setValue:_model.spec forKey:@"spec"];
    [dict setValue:_model.color forKey:@"color"];
    [dict setValue:_model.modelnum forKey:@"modelnum"];
    [dict setValue:_model.firstclassify forKey:@"firstclassify"];
    [dict setValue:_model.secondclassify forKey:@"secondclassify"];
    [dict setValue:_model.num forKey:@"num"];
    [dict setValue:_model.price forKey:@"price"];
    [dict setValue:_model.discount forKey:@"discount"];
    [dict setValue:[_model.POdiscount integerValue]==0?@"false":@"true" forKey:@"POdiscount"];
    [dict setValue:_model.amount forKey:@"amount"];
    [dict setValue:UniqUserID forKey:@"memberid"];
    [dict setValue:userType forKey:@"membertype"];
    [dict setValue:_resonIndex==0?@"质量问题":@"其他" forKey:@"reason"];
    [dict setValue:_resonStr forKey:@"context"];
    
    [dict setValue:_backIndex==0?@"原路返回":@"余额账户" forKey:@"refundway"];
    [dict setValue:@"true" forKey:@"express"];
    [dict setValue:@"快递" forKey:@"returnway"];
    
    switch (_seleTypeBtn.tag) {
        case 0:
            {
                [dict setValue:@"维修" forKey:@"classify"];
            }
            break;
        case 1:
        {
            [dict setValue:@"退货" forKey:@"classify"];
        }
            break;
        case 2:
        {
            [dict setValue:@"其他" forKey:@"classify"];
        }
            break;
        default:
            break;
    }
    
    [self showEmptyViewWithLoading];
    [HttpHandler getPOServiceApply:@{} dataList:@[dict] image:_pictureview.pictureDataArr start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        [self hideEmptyView];
        if (ReturnValue==1) {
            [self showHint:@"申请成功"];
            NOTIFY_POST(NOTIF_AFTER);
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
        }
    } failed:^(id obj) {
        
    }];
    
    if (_pictureview.pictureDataArr.count>0) {
        
    }else{
        
    }
}



#pragma mark - getter

-(ZWHPictureManageView *)pictureview{
    if (!_pictureview) {
        _pictureview = [[ZWHPictureManageView alloc]initWithNum:6 withRowNum:4];
    }
    return _pictureview;
}



@end
