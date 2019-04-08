//
//  GroupMemberCell.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/22.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupBaseCell.h"
@interface GroupMemberCell : GroupBaseCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UILabel *personCount;

@end
