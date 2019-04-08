//
//  InsuranceTopListCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/23.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "InsuranceTopListCell.h"
#import "Masonry.h"
#import "InsuranceTopListCollCell.h"
@implementation InsuranceTopListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setUI{
    UILabel *label=[[UILabel alloc]init];
    label.text=@"旅游首选";
    label.font=[UIFont boldSystemFontOfSize:13];
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(8);
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    CGFloat w=(ScreenWidth-40)/3;
    layout.itemSize=CGSizeMake(w, w/2+60);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.myCollectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.myCollectionView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:self.myCollectionView];
    [self.myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).offset(4);
        make.left.mas_equalTo(self.contentView.left);
        make.right.mas_equalTo(self.contentView.right);
        make.height.mas_equalTo(w/2+60);
        
    }];
    self.myCollectionView.delegate=self;
    self.myCollectionView.dataSource=self;
    self.myCollectionView.showsVerticalScrollIndicator=NO;
    self.myCollectionView.showsHorizontalScrollIndicator=NO;
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"InsuranceTopListCollCell" bundle:nil] forCellWithReuseIdentifier:@"InsuranceTopListCollCell"];
    
}

-(__kindof UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    InsuranceTopListCollCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"InsuranceTopListCollCell" forIndexPath:indexPath];
    InsuranceModel *model=self.dataArray[indexPath.row];
    cell.model=model;
    return cell;
    
}


@end
