//
//  ZWHTicketThirdTableViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/21.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHTicketThirdTableViewCell.h"

@implementation ZWHTicketThirdTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    CellLine;
    
    _title = [[QMUILabel alloc]qmui_initWithFont:HTFont(24) textColor:[UIColor blackColor]];
    //_title.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(8));
        make.top.equalTo(self.contentView).offset(WIDTH_PRO(8));
    }];
    
    
    _detail = [[QMUILabel alloc]qmui_initWithFont:HTFont(24) textColor:[UIColor blackColor]];
    [self.contentView addSubview:_detail];
    [_detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(WIDTH_PRO(8));
        make.bottom.equalTo(self.contentView).offset(-WIDTH_PRO(8));
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(8));
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(70));
    }];
    
    _detail.numberOfLines = 0;
}



@end
