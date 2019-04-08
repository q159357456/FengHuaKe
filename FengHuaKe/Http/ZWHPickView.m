//
//  ZWHPickView.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/24.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHPickView.h"

@interface ZWHPickView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)NSArray *dataArray;

@property(nonatomic,strong)UIPickerView *choosePickView;

@property(nonatomic,strong)NSString *choosevalue;

@property(nonatomic,strong)UIView *backView;

@property(nonatomic,assign)NSInteger index;

@end


@implementation ZWHPickView

-(instancetype)initWithArray:(NSArray *)array with:(returnChoose)valueblock{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.3];
        self.dataArray = array;
        //_inputValue = value;
        //value = self.inputValue;
        if (valueblock) {
            self.inputValue = ^(NSString *value, NSInteger index) {
                valueblock(value,index);
            };
        }
        _choosevalue = array[0];
        _index = 0;
        [self setUI];
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.2 animations:^{
        self.backView.frame = CGRectMake(WIDTH_PRO(8), SCREEN_HEIGHT-HEIGHT_PRO(10), (SCREEN_WIDTH-WIDTH_PRO(16)), HEIGHT_PRO(190));
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)setUI{
    
    _backView = [[UIView alloc]init];
    _backView.frame = CGRectMake(WIDTH_PRO(8), SCREEN_HEIGHT-HEIGHT_PRO(10), (SCREEN_WIDTH-WIDTH_PRO(16)), HEIGHT_PRO(190));
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.layer.cornerRadius = WIDTH_PRO(8);
    _backView.layer.masksToBounds = YES;
    [self addSubview:_backView];
    
    _choosePickView = [[UIPickerView alloc]init];
    _choosePickView.delegate = self;
    _choosePickView.dataSource = self;
    _choosePickView.backgroundColor = [UIColor clearColor];
    [_backView addSubview:_choosePickView];
    [_choosePickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(_backView);
        make.height.mas_equalTo(HEIGHT_PRO(150));
    }];
    //_choosePickView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, HEIGHT_PRO(150));
    
    
    QMUIButton *sure = [[QMUIButton alloc]init];
    [sure setBackgroundColor:MAINCOLOR];
    [sure setTitle:@"确定" forState:0];
    [sure setTitleColor:[UIColor whiteColor] forState:0];
    //[sure round:WIDTH_PRO(8) RectCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight];
    [_backView addSubview:sure];
    [sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_backView);
        make.top.equalTo(_choosePickView.mas_bottom);
        make.height.mas_equalTo(HEIGHT_PRO(40));
    }];
    [sure addTarget:self action:@selector(sureWith:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 取消 确定

-(void)sureWith:(QMUIButton *)btn{
    if ([self anySubViewScrolling:_choosePickView]) {
        return;
    }else{

        [UIView animateWithDuration:0.2 animations:^{
            self.backView.frame = CGRectMake(WIDTH_PRO(8), SCREEN_HEIGHT-HEIGHT_PRO(10), (SCREEN_WIDTH-WIDTH_PRO(16)), HEIGHT_PRO(190));
        } completion:^(BOOL finished) {
            if (_inputValue) {
                _inputValue(_choosevalue,_index);
            }
            [self removeFromSuperview];
        }];
        
    }
}


+(void)showZWHPickView:(NSArray *)dataSource with:(returnChoose)value{
    ZWHPickView *pickview = [[ZWHPickView alloc]initWithArray:dataSource with:value];
    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
    [keywindow addSubview:pickview];
    [UIView animateWithDuration:0.2 animations:^{
        //pickview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        pickview.backView.frame = CGRectMake(WIDTH_PRO(8), SCREEN_HEIGHT-HEIGHT_PRO(10)-HEIGHT_PRO(190), (SCREEN_WIDTH-WIDTH_PRO(16)), HEIGHT_PRO(190));
    }];
}

#pragma mark - uipickviewdelegate


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1; //拨盘数量
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _dataArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _dataArray[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _choosevalue = _dataArray[row];
    _index = row;
}

- (BOOL)anySubViewScrolling:(UIView *)view{
    
    if ([view isKindOfClass:[UIScrollView class]]) {
        
        UIScrollView *scrollView = (UIScrollView *)view;
        
        if (scrollView.dragging || scrollView.decelerating) {
            
            return YES;
            
        }
        
    }
    
    for (UIView *theSubView in view.subviews) {
        
        if ([self anySubViewScrolling:theSubView]) {
            
            return YES;
            
        }
        
    }
    
    return NO;
    
}


@end
