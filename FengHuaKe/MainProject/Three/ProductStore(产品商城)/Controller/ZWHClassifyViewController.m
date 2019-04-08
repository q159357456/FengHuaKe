//
//  ZWHClassifyViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/11.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHClassifyViewController.h"
#import "ZWHProductListViewController.h"
#import "ClassifyModel.h"
#import "ZWHClassifyListLeftTableViewCell.h"
#import "ZWHProductPagingViewController.h"

@interface ZWHClassifyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *classifyTable;
@property(nonatomic,strong)NSMutableArray *dataArray;

//分类数组
@property(nonatomic,strong)NSArray *arr;

//品牌数组
@property(nonatomic,strong)NSArray *brandarr;

//存放分类
@property(nonatomic,strong)QMUIFloatLayoutView *layView;

//存放品牌
@property(nonatomic,strong)QMUIFloatLayoutView *brandView;

//用于存放热门品牌和分类的uitableview
@property(nonatomic,strong)UITableView *brandTableView;

@end

@implementation ZWHClassifyViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //[self setInViewWillDisappear];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部分类";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
    [self getDataSource];
    
    
}

-(void)getDataSource{
    MJWeakSelf;
    [HttpHandler getClassifyList:@{@"para1":_code,@"intresult":@"0"} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        if (ReturnValue==1) {
            weakSelf.dataArray = [ClassifyModel mj_objectArrayWithKeyValuesArray:obj[@"DataList"]];
            [weakSelf.classifyTable reloadData];
            if (weakSelf.dataArray.count>0) {
                [weakSelf.classifyTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:0];
                [weakSelf.classifyTable.delegate tableView:weakSelf.classifyTable didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            }else{
                [weakSelf showEmptyViewWithImage:[UIImage imageNamed:@"nodata"] text:@"" detailText:@"" buttonTitle:@"" buttonAction:nil];
                weakSelf.emptyView.backgroundColor = [UIColor whiteColor];
            }
        }
    } failed:^(id obj) {
        
    }];
}

-(void)setUI{
    
    _dataArray = [NSMutableArray array];
    
    
    _classifyTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:_classifyTable];
    [_classifyTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.view);
        make.width.mas_equalTo(WIDTH_PRO(130));
    }];
    _classifyTable.delegate = self;
    _classifyTable.dataSource = self;
    _classifyTable.separatorStyle = 0;
    _classifyTable.backgroundColor = LINECOLOR;
    _classifyTable.showsVerticalScrollIndicator = NO;
    [_classifyTable registerClass:[ZWHClassifyListLeftTableViewCell class] forCellReuseIdentifier:@"ZWHClassifyListLeftTableViewCell"];
    
    _brandTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:_brandTableView];
    [_brandTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.view);
        make.left.equalTo(self.classifyTable.mas_right);
    }];
    _brandTableView.separatorStyle = 0;
    _brandTableView.backgroundColor = [UIColor whiteColor];
    _brandTableView.showsVerticalScrollIndicator = NO;
}


#pragma mark - uitableviewdelegate



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableView==_classifyTable?_dataArray.count:0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView==_classifyTable?HEIGHT_PRO(40):HEIGHT_PRO(0);
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWHClassifyListLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHClassifyListLeftTableViewCell" forIndexPath:indexPath];
    ClassifyModel *model = _dataArray[indexPath.row];
    cell.textLabel.text = model.name;
    cell.selectionStyle = 0;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _brandarr = [NSArray array];
    _arr = [NSArray array];
    ClassifyModel *model = _dataArray[indexPath.row];
    
    MJWeakSelf;
    [HttpHandler getBrandList:@{@"para1":model.code} start:@(1) end:@(6) querytype:@"0" Success:^(id obj) {
        if (ReturnValue == 1) {
            NSArray *arr = obj[@"DataList"];
            if (arr.count>0) {
                _brandarr = [ClassifyModel mj_objectArrayWithKeyValuesArray:obj[@"DataList"]];
                
                [weakSelf.brandView removeFromSuperview];
                weakSelf.brandView = [[QMUIFloatLayoutView alloc]init];
                weakSelf.brandView.padding = UIEdgeInsetsMake(12, 12, 12, 12);
                weakSelf.brandView.itemMargins = UIEdgeInsetsMake(0, 0, 10, 10);
                weakSelf.brandView.layer.borderColor = LINECOLOR.CGColor;
                //weakSelf.brandView.layer.borderWidth = 1;
                weakSelf.brandView.backgroundColor = [UIColor whiteColor];
                
                for (NSInteger i=0; i<_brandarr.count; i++) {
                    ClassifyModel *model = _brandarr[i];
                    QMUIGhostButton *button = [[QMUIGhostButton alloc] init];
                    button.ghostColor = MAINCOLOR;
                    [button setTitle:model.name forState:UIControlStateNormal];
                    button.titleLabel.font = UIFontMake(14);
                    button.contentEdgeInsets = UIEdgeInsetsMake(6, 20, 6, 20);
                    [weakSelf.brandView addSubview:button];
                    button.tag = i;
                    [button addTarget:self action:@selector(brandWith:) forControlEvents:UIControlEventTouchUpInside];
                }
                
                CGSize floatLayoutViewSize = [weakSelf.brandView sizeThatFits:CGSizeMake(SCREEN_WIDTH-HEIGHT_PRO(130+30), CGFLOAT_MAX)];
                weakSelf.brandView.frame = CGRectMake(0, HEIGHT_PRO(30), SCREEN_WIDTH-HEIGHT_PRO(130+30), floatLayoutViewSize.height);
                
                UIView *topview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-HEIGHT_PRO(130), floatLayoutViewSize.height + HEIGHT_PRO(40))];
                QMUILabel *lab = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:[UIColor blackColor]];
                lab.text = @"品牌";
                [topview addSubview:lab];
                [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(topview).offset(WIDTH_PRO(8));
                    make.top.equalTo(topview).offset(WIDTH_PRO(8));
                }];
                [topview addSubview:weakSelf.brandView];
                
                weakSelf.brandTableView.tableHeaderView = topview;
            }else{
                weakSelf.brandTableView.tableHeaderView = nil;
            }
        }else{
            
        }
    } failed:^(id obj) {
        
    }];
    
    
    [HttpHandler getClassifyList:@{@"para1":_code,@"para2":model.code} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        if (ReturnValue==1) {
            _arr = [ClassifyModel mj_objectArrayWithKeyValuesArray:obj[@"DataList"]];
            
            [weakSelf.layView removeFromSuperview];
            weakSelf.layView = [[QMUIFloatLayoutView alloc]init];
            weakSelf.layView.padding = UIEdgeInsetsMake(12, 12, 12, 12);
            weakSelf.layView.itemMargins = UIEdgeInsetsMake(0, 0, 10, 10);
            weakSelf.layView.layer.borderColor = LINECOLOR.CGColor;
            //weakSelf.layView.layer.borderWidth = 1;
            weakSelf.layView.backgroundColor = [UIColor whiteColor];
            
            for (NSInteger i=0; i<_arr.count; i++) {
                ClassifyModel *model = _arr[i];
                QMUIGhostButton *button = [[QMUIGhostButton alloc] init];
                button.ghostColor = MAINCOLOR;
                [button setTitle:model.name forState:UIControlStateNormal];
                button.titleLabel.font = UIFontMake(14);
                button.contentEdgeInsets = UIEdgeInsetsMake(6, 20, 6, 20);
                [weakSelf.layView addSubview:button];
                button.tag = i;
                [button addTarget:self action:@selector(classifyWith:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            CGSize floatLayoutViewSize = [weakSelf.layView sizeThatFits:CGSizeMake(SCREEN_WIDTH-HEIGHT_PRO(130+15), CGFLOAT_MAX)];
            weakSelf.layView.frame = CGRectMake(0, HEIGHT_PRO(30), SCREEN_WIDTH-HEIGHT_PRO(130+15), floatLayoutViewSize.height);
            
            UIView *topview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-HEIGHT_PRO(130), floatLayoutViewSize.height + HEIGHT_PRO(40))];
            QMUILabel *lab = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:[UIColor blackColor]];
            lab.text = @"分类";
            [topview addSubview:lab];
            [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(topview).offset(WIDTH_PRO(8));
                make.top.equalTo(topview).offset(WIDTH_PRO(8));
            }];
            [topview addSubview:weakSelf.layView];
            weakSelf.brandTableView.tableFooterView = topview;
            
            if (_arr.count==0) {
                [weakSelf.layView removeFromSuperview];
                [weakSelf showEmptyViewWithImage:[UIImage imageNamed:@"nodata"] text:@"" detailText:@"" buttonTitle:@"" buttonAction:nil];
                weakSelf.emptyView.imageViewInsets = UIEdgeInsetsMake(0, WIDTH_PRO(130)/2, 26, 0);
                weakSelf.emptyView.userInteractionEnabled = NO;
                weakSelf.brandTableView.hidden = YES;
            }else{
                [weakSelf hideEmptyView];
                weakSelf.brandTableView.hidden = NO;
            }
        }
    } failed:^(id obj) {
        
    }];
}


-(void)brandWith:(QMUIGhostButton *)btn{
    ClassifyModel *model = _brandarr[btn.tag];
    
    [self showEmptyViewWithLoading];
    MJWeakSelf;
    [HttpHandler getClassifyList:@{@"para1":_code,@"para2":model.code} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        [weakSelf hideEmptyView];
        if (ReturnValue==1) {
            NSArray *arr = obj[@"DataList"];
            if (arr.count > 0) {
                NSArray *claArr = [ClassifyModel mj_objectArrayWithKeyValuesArray:arr];
                ZWHProductPagingViewController *vc = [[ZWHProductPagingViewController alloc]init];
                vc.code = weakSelf.code;
                vc.classArr = claArr;
                vc.title = model.name;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else{
                ZWHProductListViewController *vc = [[ZWHProductListViewController alloc]init];
                vc.code = weakSelf.code;
                vc.secode = model.code;
                vc.title = model.name;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
        }else{
        }
    } failed:^(id obj) {
        [weakSelf hideEmptyView];
    }];
    
    
}


-(void)classifyWith:(QMUIGhostButton *)btn{
    ClassifyModel *model = _arr[btn.tag];
    
    [self showEmptyViewWithLoading];
    MJWeakSelf;
    [HttpHandler getClassifyList:@{@"para1":_code,@"para2":model.code} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        [weakSelf hideEmptyView];
        if (ReturnValue==1) {
            NSArray *arr = obj[@"DataList"];
            if (arr.count > 0) {
                NSArray *claArr = [ClassifyModel mj_objectArrayWithKeyValuesArray:arr];
                ZWHProductPagingViewController *vc = [[ZWHProductPagingViewController alloc]init];
                vc.code = weakSelf.code;
                vc.classArr = claArr;
                vc.title = model.name;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else{
                ZWHProductListViewController *vc = [[ZWHProductListViewController alloc]init];
                vc.code = weakSelf.code;
                vc.secode = model.code;
                vc.title = model.name;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
        }else{
        }
    } failed:^(id obj) {
        [weakSelf hideEmptyView];
    }];
    
    
}


@end
