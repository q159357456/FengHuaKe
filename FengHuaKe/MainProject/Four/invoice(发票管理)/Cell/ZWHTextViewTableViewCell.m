//
//  ZWHTextViewTableViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/7.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHTextViewTableViewCell.h"

@interface ZWHTextViewTableViewCell()<QMUITextViewDelegate>

@property (nonatomic,strong)sureInputContent sureBlcok;

@end

@implementation ZWHTextViewTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    CellLine
    _textView = [[QMUITextView alloc]init];
    _textView.placeholder = @"详细地址";
    _textView.font = HTFont(28);
    [self.contentView addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(WIDTH_PRO(8));
        make.right.bottom.equalTo(self.contentView).offset(-WIDTH_PRO(8));
    }];
    _textView.delegate = self;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if (_sureBlcok) {
        _sureBlcok(textView.text);
    }
}

-(void)didEndInput:(sureInputContent)input{
    _sureBlcok = input;
}

@end
