//
//  GroupBaseCell.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/23.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^FunBlock)(id);
@interface GroupBaseCell : UITableViewCell
@property(nonatomic,copy)FunBlock funBlock;
-(void)updateCellWithData:(id)data;
-(void)getRowHeight;
@end
