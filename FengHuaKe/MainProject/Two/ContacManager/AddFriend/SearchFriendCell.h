//
//  SearchFriendCell.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^AddFriendsBlock) ();
@interface SearchFriendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIButton *agreeButt;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@property(nonatomic,copy)AddFriendsBlock  addFriendsBlock;
@end
