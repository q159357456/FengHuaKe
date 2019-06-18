//
//  GuidApplyBoolChoiceView.m
//  FengHuaKe
//
//  Created by chenheng on 2019/6/14.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "GuidApplyBoolChoiceView.h"

@implementation GuidApplyBoolChoiceView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         NSArray *arr = [[NSArray alloc]initWithObjects:@"男",@"女", nil];
        UISegmentedControl * seg =[[UISegmentedControl alloc]initWithItems:arr];
        [self addSubview:seg];
        self.seg = seg;
        [seg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self.mas_right).offset(-15);
            make.size.mas_equalTo(CGSizeMake(WIDTH_PRO(60), WIDTH_PRO(20)));
        }];
        [seg setSelectedSegmentIndex:0];
        [seg addTarget:self action:@selector(selected:) forControlEvents:UIControlEventValueChanged];
        
        
    }
    return self;
}

-(void)selected:(id)sender{
    UISegmentedControl* control = (UISegmentedControl*)sender;
    switch (control.selectedSegmentIndex) {
        case 0:
        {
            _value = @"男";
        }
            break;
        case 1:
        {
            _value = @"女";
        }
            break;
        default:
            break;
    }
}
-(void)setValue:(NSString *)value
{
    _value = value;
    if ([_value isEqualToString:@"男"]) {
        [self.seg setSelectedSegmentIndex:0];
    }else
    {
        [self.seg setSelectedSegmentIndex:1];
    }
    
}
-(NSString *)value
{
    if (!_value) {
        _value = @"男";
    }
    return _value;
}

@end
