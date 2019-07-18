//
//  ListChooseView.m
//  FengHuaKe
//
//  Created by 秦根 on 2019/7/18.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "ListChooseView.h"
@interface ListChooseView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * dataSource;
@end
@implementation ListChooseView
+(instancetype)showListChoose:(CGRect)frame DataSource:(NSArray*)dataSource
{
    ListChooseView * listV = [[ListChooseView alloc]init];
    listV.dataSource = dataSource;
    CGFloat height = dataSource.count * 44*MULPITLE;
    listV.tableView = [[UITableView alloc]initWithFrame:CGRectMake(frame.origin.x, CGRectGetMaxY(frame), frame.size.width, height) style:UITableViewStylePlain];
    listV.tableView.delegate = listV;
    listV.tableView.dataSource = listV;
    listV.tableView.showsVerticalScrollIndicator = NO;
    [listV.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    listV.tableView.tableFooterView = [UIView new];
    [listV addSubview:listV.tableView];
    [UIApplication.sharedApplication.keyWindow addSubview:listV];
    return listV;
}
-(instancetype)init
{
    if (self = [super init]) {
        self.frame = UIApplication.sharedApplication.keyWindow.bounds;
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@""];
    return cell;
}
@end
