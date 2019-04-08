//
//  TicketHotCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/20.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "TicketHotCell.h"
#import "Masonry.h"
@interface TicketHotCell()

@end
@implementation TicketHotCell

- (void)awakeFromNib {
    [super awakeFromNib];

    // Initialization code
}
-(void)setDataArray:(NSArray *)dataArray
{
    _dataArray=dataArray;
    [self.myCollectionView reloadData];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}
-(void)setUI{
   
    UILabel *label=[[UILabel alloc]init];
    label.text=@"热门景点";
    label.font=[UIFont boldSystemFontOfSize:13];
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(8);
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    CGFloat w=(ScreenWidth-50)/4;
    layout.itemSize=CGSizeMake(w, w*18/10);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.myCollectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.myCollectionView.backgroundColor=[UIColor whiteColor];
     [self.contentView addSubview:self.myCollectionView];
    [self.myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).offset(4);
        make.left.mas_equalTo(self.contentView.left);
        make.right.mas_equalTo(self.contentView.right);
        make.height.mas_equalTo(w*18/10);

    }];
    self.myCollectionView.delegate=self;
    self.myCollectionView.dataSource=self;
    self.myCollectionView.showsVerticalScrollIndicator=NO;
    self.myCollectionView.showsHorizontalScrollIndicator=NO;
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"TiketHotCollecCell" bundle:nil] forCellWithReuseIdentifier:@"TiketHotCollecCell"];
   
    
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TiketHotCollecCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"TiketHotCollecCell" forIndexPath:indexPath];

    TravelListModel *model=self.dataArray[indexPath.row];
    cell.model=model;
    return cell;
}
//设置section的上左下右边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //上  左   下  右
    
    
    return UIEdgeInsetsMake(0,10,0,10);
    
    
}

//两个cell
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
//两行
//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 1;
//}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.TickeHotBlock) {
        self.TickeHotBlock(indexPath.row);
    }
    
}

@end
