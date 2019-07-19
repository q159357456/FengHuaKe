//
//  ListChooseView.m
//  FengHuaKe
//
//  Created by 秦根 on 2019/7/18.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "ListChooseView.h"
#import "ZWHClassifyModel.h"
@interface ListChooseView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * dataSource;
@property(nonatomic,copy)NSString * identifier;
@end
@implementation ListChooseView
+(instancetype)showListChoose:(CGRect)frame DataSource:(NSArray*)dataSource Identifier:(NSString*)identifier
{
    ListChooseView * listV = [[ListChooseView alloc]init];
    listV.identifier = identifier;
    listV.dataSource = dataSource;
    CGFloat height = dataSource.count * 44*MULPITLE;
    listV.tableView = [[UITableView alloc]initWithFrame:CGRectMake(frame.origin.x, CGRectGetMaxY(frame), frame.size.width, height) style:UITableViewStylePlain];
    listV.tableView.delegate = listV;
    listV.tableView.dataSource = listV;
    listV.tableView.showsVerticalScrollIndicator = NO;
    [listV.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    listV.tableView.tableFooterView = [UIView new];
    [listV addSubview:listV.tableView];
    listV.tableView.rowHeight = 44.0f*MULPITLE;
    [UIApplication.sharedApplication.keyWindow addSubview:listV];
    return listV;
}
-(instancetype)init
{
    if (self = [super init]) {
        self.frame = UIApplication.sharedApplication.keyWindow.bounds;
        self.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.8];
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if ([self.identifier isEqualToString:NSStringFromClass([ZWHClassifyModel class])]) {
        ZWHClassifyModel * model = self.dataSource[indexPath.row];
        cell.textLabel.text = model.name;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.identifier isEqualToString:NSStringFromClass([ZWHClassifyModel class])]) {
        ZWHClassifyModel * model = self.dataSource[indexPath.row];
        if (self.delegate && [self.delegate respondsToSelector:@selector(ListChooseViewCallBack:Obj:)]) {
            [self.delegate ListChooseViewCallBack:self.identifier Obj:model];
        }
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}
@end
