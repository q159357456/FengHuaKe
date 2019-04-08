//
//  GroupPickerView.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/18.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "GroupPickerView.h"
#import "FMDBGroupTable.h"
#define backColor [UIColor colorWithWhite:0 alpha:0.3]
@interface GroupPickerView()<UIPickerViewDataSource, UIPickerViewDelegate>
@property(nonatomic,strong)NSMutableArray *dataArray;
/** 选择器 */
@property (nonatomic, strong) UIPickerView *pickerView;
/** 工具条 */
@property(nonatomic,strong)UIView *toolView;
/** 选中的数据 */
@property(nonatomic,copy)NSString *chosengroupid;
@end
@implementation GroupPickerView

-(instancetype)initWithBlock:(GroupBlok)groupBlok
{
    self=[super init];
    if (self) {
        self.frame=[UIScreen mainScreen].bounds;
        self.groupBlok=groupBlok;
        self.backgroundColor=backColor;
        UIView *workView=[[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-240, self.frame.size.width, 240)];
        workView.backgroundColor=[UIColor whiteColor];
        [workView addSubview:self.pickerView];
        [workView addSubview:self.toolView];
        [self addSubview:workView];
        //数据
        self.dataArray=[[FMDBGroupTable shareInstance]getGroupData];
        [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
      
     
        
    }
    return self;
}
#pragma mark 懒加载
- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.frame=CGRectMake(0,40, self.frame.size.width,200);
        [_pickerView selectRow:6 inComponent:0 animated:NO];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        
    }
    return _pickerView;
}
-(UIView *)toolView
{
    if (_toolView== nil) {
        _toolView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
        //        _toolView.backgroundColor=[UIColor redColor];
        UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame=CGRectMake(0, 0, 50, 40);
        [button1 setTitle:@"取消" forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button1.tag=1;
        [_toolView addSubview:button1];
        [button1 addTarget:self action:@selector(butt:) forControlEvents:UIControlEventTouchUpInside];
        UIButton *button2=[UIButton buttonWithType:UIButtonTypeCustom];
        button2.frame=CGRectMake(self.frame.size.width-50, 0, 50, 40);
        button2.tag=2;
        [_toolView addSubview:button2];
        [button2 setTitle:@"确定" forState:UIControlStateNormal];
        [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(butt:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _toolView;
    
}


#pragma mark action
-(void)butt:(UIButton*)butt
{
    switch (butt.tag) {
        case 1:
            {
                [self removeFromSuperview];
            }
            break;
            
        default:
        {
            self.groupBlok(self.chosengroupid);
            [self removeFromSuperview];
        }
            break;
    }
    
}


#pragma mark picker

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger numberOfRowsInComponent = 0;
 
    
    numberOfRowsInComponent = self.dataArray.count;
            

    return numberOfRowsInComponent;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)
component {
    MyGroupModel *model=self.dataArray[row];
    return model.groupname;
}
#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    MyGroupModel *model=self.dataArray[row];
    self.chosengroupid=model.mygroupid;
    
}
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
//{
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12.0f, 0.0f, [pickerView rowSizeForComponent:component].width-12, [pickerView rowSizeForComponent:component].height)];
//
//    label.backgroundColor = [UIColor clearColor];
//    [label setTextAlignment:NSTextAlignmentCenter];
//    switch (component) {
//        case 0:
//        {
//            [label setText:self.addressArray[row][@"state"]];
//        }
//            break;
//
//        case 1:
//
//        {
//            NSDictionary *province = self.addressArray[self.provinceIndex];
//
//            [label setText:province[@"cities"][row][@"city"]];
//        }
//            break;
//    }
//
//
//
//    return label;
//}
@end
