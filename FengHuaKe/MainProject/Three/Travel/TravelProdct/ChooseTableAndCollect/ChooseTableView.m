//
//  ChooseTableView.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/22.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ChooseTableView.h"
#import "ClassifyModel.h"
@interface ChooseTableView()

@property(nonatomic,strong)UIView *selectView;
@end
@implementation ChooseTableView

-(instancetype)initWithFrame:(CGRect)frame Data:(NSArray *)data
{
    self=[super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        self.dataArray=[NSMutableArray arrayWithArray:data];
        self.delegate=self;
        self.dataSource=self;
        if (self.dataArray.count) {
            NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:0];
            [self tableView:self didSelectRowAtIndexPath:path];
        }
       
        
    }
    return self;
}

-(void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray=dataArray;
    [self reloadData];
    if (self.dataArray.count) {
        NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:0];
        [self tableView:self didSelectRowAtIndexPath:path];
    }
    
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString*cellid=@"choosecellid";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    cell.textLabel.numberOfLines=2;
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    ClassifyModel *model=self.dataArray[indexPath.row];
    cell.textLabel.text=model.name;
    if (model.selected)
    {
        UIView *selectView=[[UIView alloc]initWithFrame:cell.frame];
        selectView.backgroundColor=[UIColor lightGrayColor];
        [cell setBackgroundView:selectView];
    }else
    {
         [cell setBackgroundView:nil];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassifyModel *model=self.dataArray[indexPath.row];
    for (ClassifyModel *cmodel in self.dataArray) {
        if ([cmodel.code isEqualToString:model.code])
        {
            if (cmodel.selected) {
                return;
            }else
            {
                cmodel.selected=YES;
            }
            
        }else
        {
            cmodel.selected=NO;
        }
    }
 
    [self reloadData];
    if (self.chooseTableDeledate&&[self.chooseTableDeledate respondsToSelector:@selector(didRow:Index:)]) {
        
        [self.chooseTableDeledate didRow:self Index:indexPath.row];
        
    }
    
}

#pragma mark - selectView
-(UIView *)selectView
{
    if (!_selectView) {
        _selectView=[[UIView alloc]init];
        _selectView.backgroundColor=[UIColor lightGrayColor];
    }
    return _selectView;
}
@end
