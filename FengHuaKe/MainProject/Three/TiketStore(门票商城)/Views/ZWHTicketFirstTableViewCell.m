//
//  ZWHTicketFirstTableViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/21.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHTicketFirstTableViewCell.h"

@implementation ZWHTicketFirstTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    CellLine;
    
    _right = [[QMUILabel alloc]qmui_initWithFont:HTFont(24) textColor:ZWHCOLOR(@"#888888")];
    _right.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_right];
    [_right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(8));
        //make.bottom.equalTo(self.contentView).offset(-WIDTH_PRO(8));
        //make.top.equalTo(self.contentView).offset(WIDTH_PRO(8));
        make.centerY.equalTo(self.contentView);
    }];
    
    
    _title = [[QMUILabel alloc]qmui_initWithFont:HTFont(24) textColor:[UIColor blackColor]];
    [self.contentView addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(WIDTH_PRO(8));
        make.bottom.equalTo(self.contentView).offset(-WIDTH_PRO(8));
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(60));
    }];
    
    _title.numberOfLines = 1;
}



@end
