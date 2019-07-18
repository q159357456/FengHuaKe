//
//  FollowGroupController.m
//  FengHuaKe
//
//  Created by chenheng on 2019/7/17.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "FollowGroupController.h"
#import "FollowGroupClassCell.h"
#import "FollowGroupSingleCell.h"
#import "ZWHVacationClassifyViewController.h"
#import "ZWHVacationDetailViewController.h"
@interface FollowGroupController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)UICollectionView * collectionView;
@end

@implementation FollowGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = [NSMutableArray array];
    [self.view addSubview:self.collectionView];
    [self getClassify];
    
    // Do any additional setup after loading the view.
}
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.height) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[FollowGroupClassCell class] forCellWithReuseIdentifier:@"FollowGroupClassCell"];
        [_collectionView registerClass:[FollowGroupSingleCell class] forCellWithReuseIdentifier:@"FollowGroupSingleCell"];
    }
    return _collectionView;
}
-(void)getClassify{
    [self showEmptyViewWithLoading];
    MJWeakSelf;
    [HttpHandler getClassifyList:@{@"para1":self.code,@"intresult":@"10",@"blresult":@"true"} start:@(1) end:@(2) querytype:@"0" Success:^(id obj) {
        [weakSelf hideEmptyView];
//        NSLog(@"obj1===>%@",obj);
        if (ReturnValue==1) {
            [weakSelf.dataArray addObject:[[TicketClassifyModel mj_objectArrayWithKeyValuesArray:ReturnDataList] subarrayWithRange:NSMakeRange(0, 2)]];
            
            [weakSelf getHotList];
        }else{
            [weakSelf showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(getClassify)];
        }
    } failed:^(id obj) {
        [weakSelf hideEmptyView];
        [weakSelf showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(getClassify)];
    }];
}

-(void)getHotList{
        DefineWeakSelf;
        NSDictionary * sysmodel1 = @{@"para1":self.code,@"para2":@"",@"para3":@""};
        [DataProcess requestDataWithURL:Pro_HotList RequestStr:GETRequestStr(nil, sysmodel1, @1, @4, nil) Result:^(id obj, id erro) {
//            NSLog(@"obj2==>%@",obj);
            if (obj) {
                [weakSelf.dataArray addObject:[ProductModel mj_objectArrayWithKeyValuesArray:ReturnDataList]];
                [weakSelf.collectionView reloadData];
                NSLog(@"weakSelf.dataArray==>%@",weakSelf.dataArray);
    
            }
        }];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArray.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray[section] count];
}
-(__kindof UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        FollowGroupClassCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FollowGroupClassCell" forIndexPath:indexPath];
        TicketClassifyModel * model = self.dataArray[indexPath.section][indexPath.row];
        if (indexPath.row == 0) {
            cell.label.text = @"国内游";
        }else
        {
            cell.label.text = @"国外游";
        }
        [cell loadData:model];
        return cell;
        
    }else
    {
        FollowGroupSingleCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FollowGroupSingleCell" forIndexPath:indexPath];
        ProductModel * model = self.dataArray[indexPath.section][indexPath.row];
        [cell loadData:model];
        return cell;
    }
    return nil;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        ZWHVacationClassifyViewController *vc = [[ZWHVacationClassifyViewController alloc]init];
        TicketClassifyModel * model = self.dataArray[indexPath.section][indexPath.row];
        vc.code = _code;
        vc.secode = model.code;
        vc.InsuranceCode = _InsuranceCode;
        vc.title = model.name;
        [self.navigationController pushViewController:vc animated:YES];
    }else
    {
        ProductModel * model = self.dataArray[indexPath.section][indexPath.row];
        ZWHVacationDetailViewController *vc = [[ZWHVacationDetailViewController alloc]init];
        vc.code = model.productno;
        vc.InsuranceCode = _InsuranceCode;
        vc.title = @"景点详情";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0)
    {
         return CGSizeMake((SCREEN_WIDTH-30)/2,(SCREEN_WIDTH-30)/4);
    }else
    {
         return CGSizeMake((SCREEN_WIDTH-30)/2,(SCREEN_WIDTH-30)/2);
    }
   
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


@end
