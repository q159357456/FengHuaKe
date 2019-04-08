//
//  ZWHTicketSecondTableViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/21.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHTicketSecondTableViewCell.h"

@implementation ZWHTicketSecondTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    CellLine;
    
    _title = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:[UIColor blackColor]];
    [self.contentView addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(WIDTH_PRO(10));
        make.bottom.equalTo(self.contentView).offset(-WIDTH_PRO(10));
    }];
    
    _img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"WechatIMG42"]];
    [self.contentView addSubview:_img];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(8));
        make.centerY.equalTo(self.contentView);
        make.height.width.mas_equalTo(WIDTH_PRO(15));
    }];
    
    
    _price = [[QMUILabel alloc]qmui_initWithFont:HTFont(32) textColor:[UIColor blackColor]];
    _price.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_price];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(_img.mas_left).offset(-WIDTH_PRO(6));
    }];
}



@end
