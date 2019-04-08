//
//  AreaView.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/14.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "AreaView.h"
#import "AdressManagerData.h"
#import "AreaModel.h"
#import "MBProgressHUD.h"
@implementation AreaView
{
     UIView *blackBaseView;
    AreaModel *_proModel;
     AreaModel *_cityModel;
     AreaModel *_districtModel;
}
CG_INLINE CGRect CGRectMakes(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    float secretNum = [[UIScreen mainScreen] bounds].size.width / 375;
    float secretNumH = [[UIScreen mainScreen] bounds].size.height / 667;
    rect.origin.x = x*secretNum;
    rect.origin.y = y*secretNum;
    rect.size.width = width*secretNum;
    rect.size.height = height*secretNumH;
    
    return rect;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.autoresizesSubviews=NO;
        self.provinceArray=[NSMutableArray array];
        self.cityArray=[NSMutableArray array];
        self.districtArray=[NSMutableArray array];
        [self creatBaseUI];
        [self AddressProvince];
    }
    return self;
}


- (void)creatBaseUI
{
    blackBaseView = [[UIView alloc]initWithFrame:self.bounds];
    blackBaseView.backgroundColor = [UIColor blackColor];
    blackBaseView.alpha = 0;
    [self addSubview:blackBaseView];
    //_areaWhiteBaseView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, HEIGHT_PRO(380))];
    _areaWhiteBaseView = [[UIView alloc]initWithFrame:CGRectMakes(0, 667, 375, 380)];
    _areaWhiteBaseView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_areaWhiteBaseView];
    
    
    //UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(50))];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMakes(0, 0, 375, 50)];
    titleLabel.text = @"所在地";
    titleLabel.textColor = RGB(0, 0, 34);
    titleLabel.font = HTFont(28);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [_areaWhiteBaseView addSubview:titleLabel];
    
    for (int i = 0; i < 3; i++) {
        UIButton *areaBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        areaBtn.frame = CGRectMakes(100 * i, 50, 80, 30);
        [areaBtn setTitleColor:RGB(34, 34, 34) forState:UIControlStateNormal];
        areaBtn.tag = 100 + i;
        [areaBtn setTitle:@"" forState:UIControlStateNormal];
        [areaBtn addTarget:self action:@selector(areaBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        areaBtn.userInteractionEnabled = NO;
        [_areaWhiteBaseView addSubview:areaBtn];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMakes(100 * i + 10, 78, 60, 2)];
        lineView.backgroundColor = RGB(204, 54, 60);
        [_areaWhiteBaseView addSubview:lineView];
        lineView.tag = 300 + i;
        lineView.hidden = YES;
        if (i == 0) {
            areaBtn.userInteractionEnabled = YES;
            [areaBtn setTitle:@"请选择" forState:UIControlStateNormal];
            [areaBtn setTitleColor:RGB(204, 54, 60) forState:UIControlStateNormal];
            lineView.hidden = NO;
        }
    }
    
    //scroview
    _areaScrollView = [[UIScrollView alloc]initWithFrame:CGRectMakes(0, 80, ScreenWidth, 300)];
//    _areaScrollView.delegate = self;
    //_areaScrollView.contentSize = CGSizeMake(ScreenWidth, 300 * MULPITLE);
    _areaScrollView.contentSize = CGSizeMake(ScreenWidth, HEIGHT_PRO(300));
    _areaScrollView.backgroundColor = [UIColor redColor];
    _areaScrollView.pagingEnabled = YES;
    _areaScrollView.showsVerticalScrollIndicator = NO;
    _areaScrollView.showsHorizontalScrollIndicator = NO;
    _areaScrollView.scrollEnabled = NO;
    _areaScrollView.bounces = NO;
    [_areaWhiteBaseView addSubview:_areaScrollView];
    
    for (int i = 0; i < 3; i++) {
        //UITableView *area_tableView = [[UITableView alloc]initWithFrame:CGRectMakes(375 * i, 0, 375, 300) style:UITableViewStylePlain];
        UITableView *area_tableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, HEIGHT_PRO(300)) style:UITableViewStylePlain];
        area_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        area_tableView.delegate = self;
        area_tableView.dataSource = self;
        area_tableView.tag = 200 + i;
        [_areaScrollView addSubview:area_tableView];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHidenGes)];
    [blackBaseView addGestureRecognizer:tap];
    
}

#pragma mark - areaBtnAction(点击滑动)
- (void)areaBtnAction:(UIButton *)btn
{
    for (UIView *view in _areaWhiteBaseView.subviews) {
        if (view.tag >= 300) {
            view.hidden = YES;
        }
    }
    
    UIView *lineView = [_areaWhiteBaseView viewWithTag:300 + btn.tag - 100];
    lineView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        _areaScrollView.contentOffset = CGPointMake(ScreenWidth*(btn.tag - 100), 0);
    }];
    
}


#pragma mark - tapHidenGes
- (void)tapHidenGes
{
    [self hidenAreaView];
}


#pragma mark -public
- (void)showAreaView
{
    self.hidden = NO;
    [UIView animateWithDuration:0.25 animations:^{
        blackBaseView.alpha = 0.6;
        //_areaWhiteBaseView.frame = CGRectMakes(0, SCREEN_HEIGHT - HEIGHT_PRO(380), SCREEN_WIDTH, HEIGHT_PRO(380));
        _areaWhiteBaseView.frame = CGRectMake(0, SCREEN_HEIGHT-HEIGHT_PRO(380), SCREEN_WIDTH, HEIGHT_PRO(380));
    }];
}
- (void)hidenAreaView
{
    
    [UIView animateWithDuration:0.25 animations:^{
        blackBaseView.alpha = 0;
        //_areaWhiteBaseView.frame = CGRectMakes(0, SCREEN_HEIGHT, SCREEN_WIDTH, HEIGHT_PRO(380));
        _areaWhiteBaseView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, HEIGHT_PRO(380));
    }completion:^(BOOL finished) {
        self.hidden = YES;
     
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (tableView.tag - 200) {
        case 0:
        {
            return _provinceArray.count;
        }
            break;
        case 1:
        {
            return _cityArray.count;
        }
            break;
        case 2:
        {
            return _districtArray.count;
        }
            break;
        default:
            break;
    }
    return 0;
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44 * MULPITLE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"area_cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"area_cell"];
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = RGB(255,238,238);
    cell.textLabel.highlightedTextColor = RGB(204, 54, 60);
    switch (tableView.tag - 200) {
        case 0:
        {
            AreaModel *model = _provinceArray[indexPath.row];
            cell.textLabel.text = model.name;
            cell.textLabel.font = HTFont(28);
            cell.textLabel.textColor = RGB(102, 102, 102);
        }
            break;
        case 1:
        {
            AreaModel *model = _cityArray[indexPath.row];
            cell.textLabel.text = model.name;
            cell.textLabel.font = HTFont(28);
            cell.textLabel.textColor = RGB(102, 102, 102);
        }
            break;
        case 2:
        {
            AreaModel *model = _districtArray[indexPath.row];
            cell.textLabel.text = model.name;
            cell.textLabel.font = HTFont(28);
            cell.textLabel.textColor = RGB(102, 102, 102);
        }
            break;
        default:
            break;
    }
    
   

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (tableView.tag - 200) {
        case 0:
        {
            AreaModel *model = _provinceArray[indexPath.row];
            _proModel=model;
            [self AddressCityWithCode:model];
        }
            break;
        case 1:
        {
            AreaModel *model = _cityArray[indexPath.row];
            _cityModel=model;
            [self AddressDistrictWith:model];
        }
            break;
        case 2:
        {
            
             AreaModel *model = _districtArray[indexPath.row];
            UIButton *button2=[_areaWhiteBaseView viewWithTag:101];
            UIButton *button3=[_areaWhiteBaseView viewWithTag:102];
            UIView *linview2=[_areaWhiteBaseView viewWithTag:301];
            UIView *linview3=[_areaWhiteBaseView viewWithTag:302];
            [button3 setTitle:model.name forState:UIControlStateNormal];
            [button2 setTitleColor:RGB(34, 34, 34) forState:UIControlStateNormal];
            [button3 setTitleColor:RGB(204, 54, 60) forState:UIControlStateNormal];
            linview3.hidden=NO;
            linview2.hidden=YES;
            _districtModel=model;
            if (self.delegate && [self.delegate respondsToSelector:@selector(didChosenProvince:City:District:)]) {
                [self.delegate didChosenProvince:_proModel City:_cityModel District:_districtModel];
            }
            [self hidenAreaView];
            
        }
            break;
        default:
            break;
        }
   
    
}




#pragma mark - 获取省市区
-(void)AddressProvince
{
   
    UITableView *tableView=[_areaWhiteBaseView viewWithTag:200];
    [AdressManagerData AddressProvinceSuccess:^(id responseData) {
       
        NSDictionary *dic=(NSDictionary*)responseData;
        NSString *jsonStr=dic[@"sysmodel"][@"strresult"];
        if (![jsonStr isEqual:[NSNull null]]) {
            NSData *data=[jsonStr dataUsingEncoding:NSUTF8StringEncoding];
            NSObject *obj=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *array=(NSArray*)obj;
            self.provinceArray=[AreaModel getDatawithdic:array];
            [tableView reloadData];
        }
        //
       
        
        
        
    } Fail:^(id erro) {
        
    }];
}
-(void)AddressCityWithCode:(AreaModel*)model
{
    [MBProgressHUD showHUDAddedTo:_areaWhiteBaseView animated:YES];
    UITableView *tableView=[_areaWhiteBaseView viewWithTag:201];
    UIButton *button1=[_areaWhiteBaseView viewWithTag:100];
    UIButton *button2=[_areaWhiteBaseView viewWithTag:101];
    UIButton *button3=[_areaWhiteBaseView viewWithTag:102];
    UIView *linview1=[_areaWhiteBaseView viewWithTag:300];
    UIView *linview2=[_areaWhiteBaseView viewWithTag:301];
    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":model.code}];
    [AdressManagerData AddressCitySysmodel:sysmodel Success:^(id responseData) {
        [MBProgressHUD hideHUDForView:_areaWhiteBaseView animated:YES];
        NSDictionary *dic=(NSDictionary*)responseData;
        NSString *jsonStr=dic[@"sysmodel"][@"strresult"];
        if (![jsonStr isEqual:[NSNull null]]) {
            NSData *data=[jsonStr dataUsingEncoding:NSUTF8StringEncoding];
            NSObject *obj=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *array=(NSArray*)obj;
            self.cityArray=[AreaModel getDatawithdic:array];
            [tableView reloadData];
        }
        //
        _areaScrollView.contentSize=CGSizeMake(ScreenWidth*2,300*MULPITLE);
        [UIView animateWithDuration:0.5 animations:^{
            _areaScrollView.contentOffset = CGPointMake(ScreenWidth, 0);
        }];
        [button3 setTitle:@"" forState:UIControlStateNormal];
        [button2 setTitle:@"请选择" forState:UIControlStateNormal];
        [button1 setTitle:model.name forState:UIControlStateNormal];
        linview1.hidden=YES;
        linview2.hidden=NO;
        [button1 setTitleColor:RGB(34, 34, 34) forState:UIControlStateNormal];
        [button2 setTitleColor:RGB(204, 54, 60) forState:UIControlStateNormal];
        
        button2.userInteractionEnabled=YES;
        button3.userInteractionEnabled=NO;
        
    } Fail:^(id erro) {
        
    }];
    
}

-(void)AddressDistrictWith:(AreaModel*)model
{
    [MBProgressHUD showHUDAddedTo:_areaWhiteBaseView animated:YES];
    UITableView *tableView=[_areaWhiteBaseView viewWithTag:202];
   
    UIButton *button2=[_areaWhiteBaseView viewWithTag:101];
    UIButton *button3=[_areaWhiteBaseView viewWithTag:102];
    UIView *linview2=[_areaWhiteBaseView viewWithTag:301];
    UIView *linview3=[_areaWhiteBaseView viewWithTag:302];
     NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":model.code}];
    [AdressManagerData AddressDistrictSysmodel:sysmodel Success:^(id responseData) {
        [MBProgressHUD hideHUDForView:_areaWhiteBaseView animated:YES];
        NSDictionary *dic=(NSDictionary*)responseData;
        NSString *jsonStr=dic[@"sysmodel"][@"strresult"];
        if (![jsonStr isEqual:[NSNull null]]) {
            NSData *data=[jsonStr dataUsingEncoding:NSUTF8StringEncoding];
            NSObject *obj=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *array=(NSArray*)obj;
            self.districtArray=[AreaModel getDatawithdic:array];
            [tableView reloadData];
        }
        //
        _areaScrollView.contentSize=CGSizeMake(ScreenWidth*3,300*MULPITLE);
        [UIView animateWithDuration:0.5 animations:^{
            _areaScrollView.contentOffset = CGPointMake(ScreenWidth*2, 0);
        }];
        //
        [button3 setTitle:@"请选择" forState:UIControlStateNormal];
        [button2 setTitle:model.name forState:UIControlStateNormal];
        linview2.hidden=YES;
        linview3.hidden=NO;
        [button2 setTitleColor:RGB(34, 34, 34) forState:UIControlStateNormal];
        [button3 setTitleColor:RGB(204, 54, 60) forState:UIControlStateNormal];
         button3.userInteractionEnabled=YES;
    } Fail:^(id erro) {
        
    }];
    
}
@end
