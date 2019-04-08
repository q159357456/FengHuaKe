//
//  ZWHResonTableViewCell.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/30.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^sureInputContent)(NSString * input);

@interface ZWHResonTableViewCell : UITableViewCell

@property(nonatomic,strong)QMUILabel *title;
@property(nonatomic,strong)QMUITextView *textView;

//输入结束时
-(void)didEndInput:(sureInputContent)input;

@end
