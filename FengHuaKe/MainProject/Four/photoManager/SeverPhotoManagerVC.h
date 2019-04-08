//
//  SeverPhotoManagerVC.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/10.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhtoManagerCell.h"
#import "PhotoManagerModel.h"
@interface SeverPhotoManagerVC : ZWHBaseViewController
@property(nonatomic,strong)NSMutableArray *dataArray;
-(void)rightItem;
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
