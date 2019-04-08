//
//  ClassifyProductCollectionView.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/22.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ClassifyProductCollectionView.h"
#import "NextClassifyCollectionView.h"
#import "ClassifyModel.h"
#define RMB @"¥"
@interface ClassifyProductCollectionView()
@end
@implementation ClassifyProductCollectionView

-(instancetype)initWithFrame:(CGRect)frame Data:(NSArray *)data
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    self=[super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.dataArray=[NSMutableArray arrayWithArray:data];
        self.delegate=self;
        self.dataSource=self;
        [self registerNib:[UINib nibWithNibName:@"NextClassifyCollectionView" bundle:nil] forCellWithReuseIdentifier:@"NextClassifyCollectionView"];
        
    }
    return self;
}
-(void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray=dataArray;
    [self reloadData];
    
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NextClassifyCollectionView *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"NextClassifyCollectionView" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    ClassifyModel *model=self.dataArray[indexPath.row];

    cell.lable1.text=[NSString stringWithFormat:@"%@",model.name];
    return cell;
}

#pragma mark -UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth*0.75-30)/3, (ScreenWidth*0.75-30)/3);
}
//设置section的上左下右边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //上  左   下  右
    
    
    return UIEdgeInsetsMake(10,10,10,10);
    
    
}
// 两个cell之间的最小间距，是由API自动计算的，只有当间距小于该值时，cell会进行换行
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 1;
    
}
// 两行之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    
    return 10;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.productCollectionDeledate &&[self.productCollectionDeledate respondsToSelector:@selector(didItem:Index:)]) {
        [self.productCollectionDeledate didItem:self Index:indexPath.item];
    }
}
@end
