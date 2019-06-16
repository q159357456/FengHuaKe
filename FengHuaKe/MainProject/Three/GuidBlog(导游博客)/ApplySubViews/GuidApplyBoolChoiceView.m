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
            self.value = @"男";
        }
            break;
        case 1:
        {
            self.value = @"女";
        }
            break;
        default:
            break;
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
