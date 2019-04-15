//
//  AllCityTableView.m
//  ZHONGHUILAOWU
//
//  Created by 秦根 on 2018/7/15.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "AllCityTableView.h"
#import "AreaModel.h"
@interface AllCityTableView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *data;
@end
@implementation AllCityTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self=[super initWithFrame:frame style:style];
    if (self) {
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        self.delegate=self;
        self.dataSource=self;
        self.tableHeaderView =[self head];
        [self getAllProvinceData];
    }
    return self;
}
-(UIView*)head{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 25)];
    lable.font =[UIFont systemFontOfSize:14];
    lable.textColor =MAINCOLOR;
    lable.text=@"全部地区";
    lable.textAlignment =NSTextAlignmentCenter;
    return lable;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    AreaModel *model = self.data[indexPath.row];
    cell.textLabel.text=model.name;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AreaModel *model = self.data[indexPath.row];
  
    [self FunEventName:@"chooseprovince" Para:model];
}
//
-(void)getAllProvinceData{
    DefineWeakSelf;
    [DataProcess requestDataWithURL:Address_Province RequestStr:GETRequestStr(nil,nil, nil, nil, nil) Result:^(id obj,id erro) {
        if (!erro) {
            
            NSArray *array = [HttpTool getArrayWithData:ReturnResult];
            weakSelf.data = [AreaModel getDatawithdic:array];
            [weakSelf reloadData];
        }
    }];
}
@end
