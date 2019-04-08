//
//  GroupMemberCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/22.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "GroupMemberCell.h"
#import "GroupMemberCollectionCell.h"
#import "GroupMember.h"
@interface GroupMemberCell()
@end
@implementation GroupMemberCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    NSLog(@"awake");
 

    // Initialization code
}
-(void)setCollectionView:(UICollectionView *)collectionView
{
    NSLog(@"set coll");

    _collectionView=collectionView;
    [_collectionView registerNib:[UINib nibWithNibName:@"GroupMemberCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"GroupMemberCollectionCell"];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
 
}
//-(void)setDataArray:(NSMutableArray *)dataArray
//{
//    _dataArray=dataArray;
//    
//     NSLog(@"setDataArray：%ld",self.dataArray.count);
//    [self.collectionView reloadData];
//    
//}
-(void)updateCellWithData:(id)data
{
   
    self.dataArray=(NSMutableArray*)data;
   
    [self.collectionView reloadData];
    

}
#pragma mark collection
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
}
- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GroupMemberCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"GroupMemberCollectionCell" forIndexPath:indexPath];
    id obj=self.dataArray[indexPath.row];
    if ([obj isKindOfClass:[GroupMember class]])
    {
        GroupMember *model=(GroupMember*)obj;
        cell.userImage.image=[UIImage imageNamed:@"default_head"];
        cell.userNmae.text=model.menickname;
    }else
    {
        cell.userImage.image=self.dataArray[indexPath.row];
    }
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat w=(ScreenWidth-35)/6;
    return CGSizeMake(w,w*63/50);
}
//设置边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //上  左   下  右
    
    
    return UIEdgeInsetsMake(5,5,5,5);
    
    
}
// 两个cell之间的最小间距，是由API自动计算的，只有当间距小于该值时，cell会进行换行
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 1;
    
}
// 两行之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    
    return 1;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id obj=self.dataArray[indexPath.row];
    if ([obj isKindOfClass:[GroupMember class]])
    {
        NSLog(@"个人操纵");
    }else
    {
        NSInteger k=self.dataArray.count-2;
        if ([self.dataArray[k] isKindOfClass:[UIImage class]]) {
            if (indexPath.row==self.dataArray.count-1)
            {
               
                self.funBlock(0);
            }else
            {
                
                 self.funBlock(@1);
            }
        }else
        {
          
            self.funBlock(@1);
        }
     
        
    }
//    if (self.delegate) {
//
//        [self.delegate clickItemIndex:indexPath.row];
//    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
