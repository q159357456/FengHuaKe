//
//  ZWHSearchBar.m
//  ZHONGHUILAOWU
//
//  Created by Syrena on 2018/10/31.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHSearchBar.h"

@implementation ZWHSearchBar



- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = frame.size.height/2;
        self.layer.masksToBounds = YES;
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入查询条件";
        self.backgroundColor = [UIColor whiteColor];
        self.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES;
        // 提前在Xcode上设置图片中间拉伸
        //self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        // 通过init初始化的控件大多都没有尺寸
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        // contentMode：default is UIViewContentModeScaleToFill，要设置为UIViewContentModeCenter：使图片居中，防止图片填充整个imageView
        searchIcon.contentMode = UIViewContentModeCenter;
        searchIcon.frame = CGRectMake(0, 0, 30, 30);
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

+(instancetype)searchBar
{
    return [[self alloc] init];
}



@end
