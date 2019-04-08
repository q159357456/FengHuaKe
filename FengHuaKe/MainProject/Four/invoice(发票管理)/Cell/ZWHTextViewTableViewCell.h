//
//  ZWHTextViewTableViewCell.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/7.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^sureInputContent)(NSString * input);

@interface ZWHTextViewTableViewCell : UITableViewCell

@property(nonatomic,strong)QMUITextView *textView;
@property(nonatomic,strong)UILabel *placeL;

//输入结束时
-(void)didEndInput:(sureInputContent)input;


@end
