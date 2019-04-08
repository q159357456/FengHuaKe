//
//  ChoosePhotoVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/12.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ChoosePhotoVC.h"

@interface ChoosePhotoVC ()

@end

@implementation ChoosePhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)rightItem
{
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,35,25)];
    [rightButton setTitle:@"取消" forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [rightButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    UIView *rightCustomView = [[UIView alloc] initWithFrame: rightButton.frame];
    [rightCustomView addSubview: rightButton];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightCustomView];
    self.navigationItem.rightBarButtonItem=rightItem;
}
-(void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PhtoManagerCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    PhotoManagerModel *model=self.dataArray[indexPath.row];
    if (self.backBlock) {
        self.backBlock(cell.imageview.image, cell.lable1.text,model.code);
    }
 
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
