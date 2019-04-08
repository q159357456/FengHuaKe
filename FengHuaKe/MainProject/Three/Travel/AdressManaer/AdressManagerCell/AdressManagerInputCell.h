//
//  AdressManagerInputCell.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/14.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdressManagerBaseCell.h"

typedef void (^sureInputContent)(NSString * input);

@interface AdressManagerInputCell : AdressManagerBaseCell<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *inputTextField;
@property (nonatomic,strong)sureInputContent sureBlcok;


//输入结束时
-(void)didEndInput:(sureInputContent)input;

@end
