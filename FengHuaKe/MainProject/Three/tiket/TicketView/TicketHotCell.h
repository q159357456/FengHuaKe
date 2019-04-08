//
//  TicketHotCell.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/20.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiketHotCollecCell.h"
@interface TicketHotCell : UITableViewCell <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *myCollectionView;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)void(^TickeHotBlock)(NSInteger index);
-(void)setUI;
@end
