//
//  TicektBillVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/22.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "TicektBillVC.h"
#import "NSDate+Extension.h"
#import "TiBillCollectionViewCell.h"
#import "BPPCalendar.h"
@interface TicektBillVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIView *BuyBackGView;
@property (weak, nonatomic) IBOutlet UIView *inputBackGView;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong)BPPCalendar *clender;
@end

@implementation TicektBillVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.BuyBackGView rounded:3 width:1 color:UIColorFromRGB(0xBBBBBB)];
    self.priceLable.text=[NSString stringWithFormat:@"¥%@",self.model.buyprice];
    [self.collectionView registerNib:[UINib nibWithNibName:@"TiBillCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TiBillCollectionViewCell"];
    [self creatData];
}
- (IBAction)buy:(UIButton *)sender {
    
}

-(void)creatData{
    self.dataArray=[NSMutableArray array];
    //获取日期
    NSDate *nowDate=[NSDate date];
    NSDate *tomorrow=[NSDate dateTomorrow];
    NSDate *yestoday=[NSDate dateWithDaysFromNow:2];
    NSDateFormatter *formater=[[NSDateFormatter alloc]init];
    formater.dateFormat=@"yyyy-MM-dd";
    NSString *t=[formater stringFromDate:tomorrow];
    NSString *y=[formater stringFromDate:yestoday];
    NSString *n=[formater stringFromDate:nowDate];
    NSString *d=@"更多日期>";
    NSArray *array=@[n,t,y,d];
    for (NSInteger i=0; i<4; i++) {
        TimePrice *p=[[TimePrice alloc]init];
        p.time=[NSString stringWithFormat:@"%@",array[i]];
        p.price=[NSString stringWithFormat:@"¥%@",self.model.buyprice];
        [self.dataArray addObject:p];
        
    }
    [self.collectionView reloadData];
    
}

-(void)updateDataWithDate:(NSString*)date{
    TimePrice *t=self.dataArray[2];
    t.price=[NSString stringWithFormat:@"¥%@",self.model.saleprice1];
    t.time=date;
    [self.collectionView reloadData];
    
}

#pragma mark - 时间选择

#pragma mark - UICollectionViewDelegate datasourse
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TiBillCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"TiBillCollectionViewCell" forIndexPath:indexPath];
    TimePrice *t=self.dataArray[indexPath.item];
    cell.lable1.text=t.time;
    cell.lable2.text=t.price;
    [cell.contentView rounded:4 width:0.5 color:UIColorFromRGB(0xBBBBBB)];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth -50)/4, 50);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    
    return 10;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item==3) {
        DefineWeakSelf;

        self.clender=[[BPPCalendar alloc]initWithFrame:[UIScreen mainScreen].bounds SlectBlock:^(NSInteger year,NSInteger moth, NSInteger day) {
           
            [weakSelf updateDataWithDate:[NSString stringWithFormat:@"%ld-%ld",moth,day]];
            
        }];
        self.clender.minDate=[NSDate date];
        [self.view addSubview:self.clender];
        
        
    }else
    {
        return;
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
@implementation TimePrice
@end
