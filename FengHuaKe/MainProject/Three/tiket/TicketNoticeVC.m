//
//  TicketNoticeVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/21.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "TicketNoticeVC.h"
#import "NoticeTableViewCell.h"
#import "NoticeSecodTableCell.h"
@interface TicketNoticeVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView *alphView;
@property(nonatomic,strong)UIView *whiteView;
@property(nonatomic,strong)UITableView *tableview;
@end

@implementation TicketNoticeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor=[UIColor colorWithWhite:0.2 alpha:0.2];
    
    [self.view addSubview:self.alphView];
    [self.view addSubview:self.whiteView];
    [self.whiteView addSubview:self.tableview];
    NSLog(@"%@",self.model.spec);
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - 懒加载
-(UITableView *)tableview
{
    if (!_tableview) {
        
        _tableview=[[UITableView alloc]initWithFrame:self.whiteView.bounds style:UITableViewStylePlain];
        _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        [_tableview registerNib:[UINib nibWithNibName:@"NoticeTableViewCell" bundle:nil] forCellReuseIdentifier:@"NoticeTableViewCell"];
        [_tableview registerNib:[UINib nibWithNibName:@"NoticeSecodTableCell" bundle:nil] forCellReuseIdentifier:@"NoticeSecodTableCell"];
        _tableview.tableFooterView=[UIView new];
        _tableview.rowHeight=UITableViewAutomaticDimension;
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.showsHorizontalScrollIndicator = NO;
    }
    return _tableview;
}
-(UIView *)alphView
{
    if (!_alphView) {
        _alphView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*0.6)];
        _alphView.backgroundColor=[UIColor clearColor];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
        _alphView.userInteractionEnabled=YES;
        [_alphView addGestureRecognizer:tap];
        
    }
    return _alphView;
    
}
-(UIView *)whiteView
{
    if (!_whiteView) {
        _whiteView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.alphView.frame), ScreenWidth, ScreenHeight-ScreenWidth*0.6)];
        _whiteView.backgroundColor=[UIColor whiteColor];
        
    }
    return _whiteView;
    
}
#pragma mark - UITableViewDelegate,UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return 4;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
        {
            NoticeSecodTableCell *cell=[tableView dequeueReusableCellWithIdentifier:@"NoticeSecodTableCell"];
            cell.lable1.text=@"预定说明";
            cell.lable4.text=@"预定时间: ";
            cell.lable5.text=@"适用人群:";
            cell.lable2.text=[NSString stringWithFormat:@"%@",self.model.property];
            cell.lable3.text=@"单一公园成人票，年卡成人票，使用日期在2018.6.1-2018.6.30期间，每张成人票可免费携带1名1.5米(不含)一下儿童入园(马戏，餐饮除外)";
            cell.selectionStyle = 0;
            return cell;
        }
            break;
        case 1:
        {
            NoticeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"NoticeTableViewCell"];
            cell.lable1.text=@"费用说明";
            cell.lable2.text=[NSString stringWithFormat:@"费用包含: %@",self.model.spec];
            cell.selectionStyle = 0;
            return cell;
        }
            break;
        case 2:
        {
            NoticeSecodTableCell *cell=[tableView dequeueReusableCellWithIdentifier:@"NoticeSecodTableCell"];
            cell.lable1.text=@"使用说明";
            cell.lable4.text=@"使用说明: ";
            cell.lable5.text=@"换票时间: ";
            NSMutableAttributedString *attrtStr=[[NSMutableAttributedString alloc]initWithData:[self.model.descr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
            [attrtStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, attrtStr.length)];
            cell.lable2.attributedText=attrtStr;
            cell.lable3.text=@"09:00-21:00";
            cell.selectionStyle = 0;
            return cell;
        }
            break;
        case 3:
        {
            NoticeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"NoticeTableViewCell"];
            cell.lable1.text=@"退款规则";
            cell.lable2.text=[NSString stringWithFormat:@"退款规则: %@",self.model.modelnum];
            cell.selectionStyle = 0;
            return cell;
        }
            break;
            
    }
    
    return nil;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 10;
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

-(void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
