//
//  InsuranceSingleVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/23.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "InsuranceSingleVC.h"
#import "InsuranceVM.h"
#import "InsuranceModel.h"
#import "InsuranceSingleCell.h"
#import "SingleHeaderCell.h"
#import "InsuranceBillVC.h"
@interface InsuranceSingleVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)InsuranceModel *model;
@property(nonatomic,strong)UITableView *tableview;
@end

@implementation InsuranceSingleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"保险详情";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-HEIGHT_PRO(50));
    }];
    [self InsureSingle];
    [self addBottom];
}
-(void)addBottom{
    
    UIView *bottomview = [[UIView alloc]init];
    [self.view addSubview:bottomview];
    [bottomview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(HEIGHT_PRO(50));
    }];
    
    UIButton *button1=[[UIButton alloc]initWithFrame:CGRectMake(0,self.view.height-64-50, ScreenWidth*0.4, 50)];
    [button1 setTitle:@"咨询" forState:0];
    [button1 setTitleColor:[UIColor blackColor] forState:0];
    button1.backgroundColor=[UIColor whiteColor];
    [bottomview addSubview:button1];
    
    UIButton *button2=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth*0.4,self.view.height-64-50, ScreenWidth*0.6, 50)];
    [button2 setTitle:@"立即购买" forState:0];
    button2.backgroundColor=MainColor;
     [bottomview addSubview:button2];
    
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(bottomview);
        make.width.mas_equalTo(SCREEN_WIDTH*0.4);
    }];
    
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(bottomview);
        make.width.mas_equalTo(SCREEN_WIDTH*0.6);
    }];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line.backgroundColor = LINECOLOR;
    [bottomview addSubview:line];
    
    [button2 addTarget:self action:@selector(bill) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)bill{
    
    InsuranceBillVC *vc=[[InsuranceBillVC alloc]init];
    vc.code=self.code;
    vc.model = _model;
    vc.isTravel = _isTravel;
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark - 懒加载
-(UITableView *)tableview
{
    if (!_tableview) {
        
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, self.view.height-64) style:UITableViewStylePlain];
        _tableview.tableFooterView=[UIView new];
        _tableview.rowHeight=UITableViewAutomaticDimension;
        [_tableview registerNib:[UINib nibWithNibName:@"InsuranceSingleCell" bundle:nil] forCellReuseIdentifier:@"InsuranceSingleCell"];
        [_tableview registerNib:[UINib nibWithNibName:@"SingleHeaderCell" bundle:nil] forCellReuseIdentifier:@"SingleHeaderCell"];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        
        
    }
    return _tableview;
}
#pragma mark - Data
-(void)InsureSingle
{
    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":self.code}];
    NSLog(@"%@",sysmodel);
    DefineWeakSelf;
    [InsuranceVM InsureSingleSysmodel:sysmodel Success:^(id responseData) {
        NSArray *array=[InsuranceModel getDatawithdic:responseData];
        weakSelf.model=array[0];
        NSLog(@" -- %@",responseData);
        [weakSelf.tableview reloadData];
    } Fail:^(id erro) {
        
    }];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return 1;
        }
            break;
        case 2:
        {
            return 1;
        }
            break;
            
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            
           SingleHeaderCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SingleHeaderCell"];
            cell.lable1.text=self.model.codename;
            cell.lable3.text=[NSString stringWithFormat:@"¥%@",self.model.minPrice];
            cell.lable2.text=self.model.tips;
            cell.selectionStyle = 0;
            return cell;
        }
            break;
        case 1:
        {
            InsuranceSingleCell *cell=[tableView dequeueReusableCellWithIdentifier:@"InsuranceSingleCell"];
            if (self.model) {
                NSMutableAttributedString *attrtStr=[[NSMutableAttributedString alloc]initWithData:[self.model.descr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
                [attrtStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, attrtStr.length)];
                cell.lable1.attributedText=attrtStr;
            }
            cell.selectionStyle = 0;
            
            return cell;
        }
            break;
        case 2:
        {
           
        }
            break;
            
    }
    
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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


@end
