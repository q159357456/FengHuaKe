//
//  ZWHMeFootViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2019/2/15.
//  Copyright © 2019年 gongbo. All rights reserved.
//

#import "ZWHMeFootViewController.h"
#import "ZWHFootListViewController.h"
#import "FootPrintTableViewCell.h"
#import "IQKeyboardManager.h"
#import "GBSegmentView.h"
#import "UIViewController+GBSearchBar.h"
@interface ZWHMeFootViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *CatagryData;
@property(nonatomic,strong)NSMutableArray * dataSource;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy)NSString * gloablCategry;
@end

@implementation ZWHMeFootViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"企业会员足迹";
    [self setsearchbar];
    self.searchBar.delegate = self;
    [self.view addSubview:self.tableView];
    NSDictionary *dic = @{@"para1":@"C001"};
    DefineWeakSelf;
    [DataProcess requestDataWithURL:Case_Class RequestStr:GETRequestStr(nil, dic, nil, nil, nil) Result:^(id obj, id erro) {
//        NSLog(@"obj===>%@",obj);
        weakSelf.CatagryData = [FootPtintModel transformToModelList:ReturnDataList];
        if (weakSelf.CatagryData) {
            FootPtintModel *model = weakSelf.CatagryData[0];
            weakSelf.gloablCategry = model.code;
        }
        
        [weakSelf setUI];
        
    }];

}
-(UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,NavigationContentTop+2 * HEIGHT_PRO(40), self.view.width, self.view.height - 2 * HEIGHT_PRO(40)-NavigationContentTop) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 80;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerNib:[UINib nibWithNibName:@"FootPrintTableViewCell" bundle:nil] forCellReuseIdentifier:@"FootPrintTableViewCell"];
    }
    return _tableView;
}

-(void)setUI{
    UIView *classView = [[UIView alloc]initWithFrame:CGRectMake(0, ZWHNavHeight, SCREEN_WIDTH, HEIGHT_PRO(40))];
    classView.qmui_borderColor = LINECOLOR;
    classView.qmui_borderWidth = 1;
    classView.qmui_borderPosition = QMUIViewBorderPositionBottom;
    [self.view addSubview:classView];
    
    UILabel *label1 = [[UILabel alloc]init];
    UILabel *label2 = [[UILabel alloc]init];
    label1.text = @"行业分类";
    label2.text = @"按实际排序";
//    label1.textAlignment = NSTextAlignmentLeft;
    label2.textAlignment = NSTextAlignmentRight;
    label1.font = ZWHFont(13);
    label2.font = ZWHFont(13);
    [classView addSubview:label1];
    [classView addSubview:label2];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(classView.mas_left).offset(8);
        make.height.top.mas_equalTo(classView);
        make.width.mas_equalTo(100*MULPITLE);
    }];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(classView.mas_right).offset(-8);
        make.height.top.mas_equalTo(classView);
        make.width.mas_equalTo(100*MULPITLE);
    }];
    
    NSMutableArray *tittleArray = [NSMutableArray array];
    for (FootPtintModel *model in self.CatagryData) {
        NSString *temp = model.name.length?model.name:@"错误";
        [tittleArray addObject:temp];
        
    }
    DefineWeakSelf;
    GBSegmentView *segment = [GBSegmentView initialSegmentViewFrame:CGRectMake(0, classView.bottom, SCREEN_WIDTH, HEIGHT_PRO(40)) DataSource:tittleArray CallBack:^(NSInteger index) {
        FootPtintModel *model = weakSelf.CatagryData[index];
        weakSelf.gloablCategry = model.code;
        [weakSelf RequestData];
        
    }];
    [self.view addSubview:segment];
    
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    [self RequestData];
    return YES;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FootPrintTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FootPrintTableViewCell"];
    FootPtintSearchModel *model = self.dataSource[indexPath.row];
    cell.model = model;
    return cell;
}


-(void)RequestData{
    if (self.searchBar.text.length==0) {
        return;
    }
    NSString * pa = self.gloablCategry?self.gloablCategry:@"";
    NSString *keyw = self.searchBar.text ?self.searchBar.text:@"";
    NSDictionary *dic = @{@"para1":pa,@"para2":@"",@"para3":keyw,@"intresult":@"0",@"para4":@""};
//    NSLog(@"dic===>%@",dic);
    DefineWeakSelf;
    [DataProcess requestDataWithURL:Enterprise_List RequestStr:GETRequestStr(nil, dic, @1, @100, nil) Result:^(id obj, id erro) {
//        NSLog(@"obj===>%@",obj);
//        NSLog(@"erro===>%@",erro);
        weakSelf.dataSource = [NSMutableArray arrayWithArray:[FootPtintSearchModel transformToModelList:ReturnDataList]];
        [weakSelf.tableView reloadData];
        
    }];
}
@end
