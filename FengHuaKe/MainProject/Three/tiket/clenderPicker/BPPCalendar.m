//
//  BPPCalendar.m
//  ZHONGHUILAOWU
//
//  Created by 秦根 on 2018/3/21.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "BPPCalendar.h"
#import "BPPCalendarModel.h"
#import "BPPCalendarCell.h"
#import "NSDate+Extension.h"
@interface BPPCalendar () <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic, strong) BPPCalendarModel *calendarModel;
@property (nonatomic, strong) NSArray *weekArray;
@property (nonatomic, strong) NSArray *dayArray;
@property (nonatomic, strong) UICollectionView *calendarCollectView;
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) NSMutableDictionary *mutDict;
@property(nonatomic,assign)NSInteger momth;
@property(nonatomic,assign)NSInteger year;
@end
@implementation BPPCalendar
- (UILabel *)titlelabel {
    if (!_titlelabel) {
        _titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2 - 60, 0, 120, 30)];
        _titlelabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titlelabel;
}

-(UIView *)backGView
{
    if (!_backGView) {
        _backGView=[[UIView alloc]initWithFrame:self.bounds];
        _backGView.backgroundColor=[UIColor colorWithWhite:0.5 alpha:0.5];
        _backGView.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dissmiss)];
        tap.delegate=self;
        [_backGView addGestureRecognizer:tap];
    }
    return _backGView;
}
-(void)dissmiss{
    [self removeFromSuperview];
}
-(UIView *)workView
{
    if (!_workView) {
        _workView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width-20, self.width+20)];
        _workView.center=CGPointMake(self.width/2, self.height/2);
//        _workView.userInteractionEnabled=NO;
        _workView.backgroundColor=[UIColor whiteColor];
    }
    return _workView;
}
#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.workView] || [touch.view isDescendantOfView:_calendarCollectView]) {
        return NO;
    }
    return YES;
}
- (instancetype)initWithFrame:(CGRect)frame SlectBlock:(SlectBlock)slectlock {
    self = [super initWithFrame:frame];
    if (self) {
        self.slectlock=slectlock;
        [self initDataSourse];
        [self stepUI];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark private
-(void)initDataSourse
{
    __weak typeof(self) weakSelf = self;
    _weekArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    _calendarModel = [[BPPCalendarModel alloc] init];
    self.calendarModel.block=^(NSInteger year, NSInteger month){
        weakSelf.momth=month;
        weakSelf.year=year;
        weakSelf.titlelabel.text = [NSString stringWithFormat:@"%ld年%ld月",year,month];
        if (weakSelf.datablock) {
              weakSelf.datablock (year, month);
        }
      
    };
    _dayArray = [_calendarModel setDayArr];
    self.index = _calendarModel.index;
    _mutDict = [NSMutableDictionary new];
}
-(void)stepUI
{
    [self addSubview:self.backGView];
    //self.backGView.backgroundColor = [UIColor clearColor];
    [self.backGView addSubview:self.workView];
    [self.workView addSubview:self.titlelabel];
    //self.workView.backgroundColor = [UIColor whiteColor];
    self.workView.layer.cornerRadius = 8;
    self.workView.layer.masksToBounds = YES;
    
    UIButton *lastBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [lastBtn setTitle:@"上一月" forState:UIControlStateNormal];
    [lastBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    lastBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [lastBtn addTarget:self action:@selector(lastMonthClick) forControlEvents:UIControlEventTouchUpInside];
    [self.workView addSubview:lastBtn];
    
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.workView.width - 50, 0, 50, 30)];
    [nextBtn setTitle:@"下一月" forState:UIControlStateNormal];
    nextBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [nextBtn addTarget:self action:@selector(nextMonthClick) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.workView addSubview:nextBtn];
    
    CGFloat width = self.workView.width/7.0;
    for (int i = 0; i < [_weekArray count]; i ++) {
        UIButton *weekBtn = [[UIButton alloc] initWithFrame:CGRectMake(i * width, 30, width, width)];
        [weekBtn setTitle:_weekArray[i] forState:UIControlStateNormal];
        [weekBtn setTitleColor:MainColor forState:UIControlStateNormal];
        if (ScreenWidth<=320) {
             nextBtn.titleLabel.font=[UIFont systemFontOfSize:12];
        }
        [self.workView addSubview:weekBtn];
    }
    
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    _calendarCollectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, width + 30, self.workView.width, (self.workView.width-30)*5/5.0) collectionViewLayout:flowlayout];
    _calendarCollectView.delegate = self;
    _calendarCollectView.dataSource = self;
    [_calendarCollectView registerClass:[BPPCalendarCell class] forCellWithReuseIdentifier:@"cell"];
    _calendarCollectView.backgroundColor = [UIColor whiteColor];
    self.calendarCollectView.alwaysBounceVertical=YES;
    [self.workView addSubview:_calendarCollectView];
    
}
- (void)lastMonthClick {
    [self.mutDict removeAllObjects];
    self.dayArray = [self.calendarModel lastMonthDataArr];
    [self.calendarCollectView reloadData];
}

- (void)nextMonthClick {
    [self.mutDict removeAllObjects];
    self.dayArray = [self.calendarModel nextMonthDataArr];
    [self.calendarCollectView reloadData];
}

#pragma mark -collection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_dayArray count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((self.workView.width-30)/7.0, (self.workView.width-30)/7.0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BPPCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dayArray[indexPath.row];
    if (ScreenWidth<=320) {
        cell.textLabel.font=[UIFont systemFontOfSize:12];
    }else
    {
        cell.textLabel.font=[UIFont systemFontOfSize:15];
        
    }
    //
    if ([self.dayArray[indexPath.row] integerValue]) {
        NSString *d=[NSString stringWithFormat:@"%ld-%ld-%@",self.year,self.momth,self.dayArray[indexPath.row]];
        NSDate *date1 =[NSDate date:d WithFormat:@"YYYY-MM-dd"];
        NSDate *date2=self.minDate;
        
        if ([date1 isEarlierThanDate:date2]) {
            cell.textLabel.textColor =[UIColor lightGrayColor];
            cell.userInteractionEnabled=NO;
        }else
        {
            cell.textLabel.textColor = [UIColor blackColor];
            cell.userInteractionEnabled=YES;
        }
    }
    //
    cell.textLabel.clipsToBounds = NO;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    

    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    if ([self.dayArray[indexPath.row] integerValue]) {
        BPPCalendarCell *cell=(BPPCalendarCell*)[self.calendarCollectView cellForItemAtIndexPath:indexPath];
        [cell rounded:(self.workView.width-30)/14.0];
        [cell.contentView setBackgroundColor:MainColor];
        if (self.slectlock) {
            
            self.slectlock(self.year,self.momth, [self.dayArray[indexPath.row] integerValue]);
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });
       
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BPPCalendarCell *cell=(BPPCalendarCell*)[self.calendarCollectView cellForItemAtIndexPath:indexPath];
    cell.clipsToBounds = NO;
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    
}

@end
