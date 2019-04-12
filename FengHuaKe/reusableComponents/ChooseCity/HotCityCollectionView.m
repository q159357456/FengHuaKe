//
//  HotCityCollectionView.m
//  ZHONGHUILAOWU
//
//  Created by 秦根 on 2018/7/15.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "HotCityCollectionView.h"
#import "HotCityCollectionCell.h"
#import "AreaModel.h"
//#import "RedPacketVM.h"
//#import "Laowu.h"
@interface HotCityCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@end
@implementation HotCityCollectionView
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
   
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self registerNib:[UINib nibWithNibName:@"HotCityCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"HotCityCollectionCell"];
        UICollectionViewFlowLayout * flow = (UICollectionViewFlowLayout*)layout;
        flow.itemSize=CGSizeMake((self.frame.size.width -30) /2, 50);
        self.delegate=self;
        self.dataSource=self;
        self.backgroundColor=defaultColor1;
        [self addSubview:[self head]];
        
        AreaModel *defaultm = [[AreaModel alloc]init];
        defaultm.name = defaultCityName;
        defaultm.code = defaultCityCode;
        self.data = [NSMutableArray arrayWithObject:defaultm];
    }
    return self;
}
-(UIView*)head{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.frame.size.width, 25)];
    lable.font =[UIFont systemFontOfSize:14];
//    lable.textColor =defaultColor2;
    lable.text=@"默认城市";
//    lable.textAlignment =NSTextAlignmentCenter;
    self.headLable =lable;
    return lable;
    
}
-(void)setData:(NSMutableArray *)data
{
    _data=data;
    [self reloadData];
}
-(void)getCityDataWithProcode:(NSString *)proCode{
    DefineWeakSelf;
    [DataProcess requestDataWithURL:Address_City RequestStr:GETRequestStr(@{@"para1":proCode}, nil, nil, nil) Result:^(id obj, id erro) {
        if (!erro) {
            NSArray *array = [HttpTool getArrayWithData:ReturnResult];
            weakSelf.data = [AreaModel getDatawithdic:array];
            [weakSelf reloadData];
            
        }
        
    }];
}
//-(void)hotCity{
//    DefineWeakSelf;
//    [RedPacketVM HotTopCitySuccess:^(id responseData)
//    {
//
//        weakSelf.data=[RegionModel getHotCityDic:responseData];
//        [weakSelf reloadData];
//
//     } Fail:^(id erro) {
//
//     }];
//
//}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self registerNib:[UINib nibWithNibName:@"HotCityCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"HotCityCollectionCell"];
        UICollectionViewFlowLayout *layoutout=[[UICollectionViewFlowLayout alloc]init] ;
        [self setCollectionViewLayout:layoutout];
        layoutout.itemSize=CGSizeMake((frame.size.width -30)/2, 40);
        layoutout.minimumLineSpacing=10;
    }
    return self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HotCityCollectionCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"HotCityCollectionCell" forIndexPath:indexPath];
    AreaModel *model = self.data[indexPath.item];
    cell.lable.text=model.name;
    cell.contentView.backgroundColor=[UIColor whiteColor];
    [cell.contentView rounded:4];
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    AreaModel *model = self.data[indexPath.item];
    [self FunEventName:@"chooseCity" Para:model];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(25, 10, 10, 10);
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
@end
