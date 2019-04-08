//
//  ZWHResonTableViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/30.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHResonTableViewCell.h"

@interface ZWHResonTableViewCell()<QMUITextViewDelegate>

@property (nonatomic,strong)sureInputContent sureBlcok;

@end


@implementation ZWHResonTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    _title = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:[UIColor blackColor]];
    _title.text = @"服务类型";
    [self.contentView addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(WIDTH_PRO(8));
    }];
    
    CellLine
    _textView = [[QMUITextView alloc]init];
    _textView.placeholder = @"请在此描述此问题";
    _textView.font = HTFont(28);
    _textView.backgroundColor = LINECOLOR;
    [self.contentView addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(8));
        make.right.bottom.equalTo(self.contentView).offset(-WIDTH_PRO(8));
        make.top.equalTo(_title.mas_bottom).offset(HEIGHT_PRO(6));
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
