//
//  ClassifyProductCollectionView.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/22.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ClassifyProductCollectionView;
@protocol ProductCollectionDeledate <NSObject>
@optional
-(void)didItem:(ClassifyProductCollectionView*)classiCollectionView Index:(NSInteger)index;
@end
@interface ClassifyProductCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)id<ProductCollectionDeledate>productCollectionDeledate;
-(instancetype)initWithFrame:(CGRect)frame Data:(NSArray*)data;
@end
